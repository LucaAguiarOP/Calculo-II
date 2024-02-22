import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numberOfRectangles = 1;
  double a = 0;
  double b = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área sob a Função Raiz de X'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: LineChart(
                _createLineChartData(),
              ),
            ),
            Slider(
              value: numberOfRectangles.toDouble(),
              min: 1,
              max: 10,
              onChanged: (value) {
                setState(() {
                  numberOfRectangles = value.toInt();
                });
              },
            ),
            Text('Número de retângulos: $numberOfRectangles'),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                // Calcular a área sob a curva
                double area = calculateArea(numberOfRectangles);
                print('Área estimada: $area');
              },
              child: const Text('Calcular Área'),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  LineChartData _createLineChartData() {
    List<FlSpot> spots = [];

    for (double i = a; i <= b; i += 0.1) {
      double y = sqrt(i);
      spots.add(FlSpot(i, y));
    }

    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];

    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: true),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1.5),
      ),
      minX: -10,
      maxX: 10,
      minY: -10,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          belowBarData: BarAreaData(show: false),
          dotData: FlDotData(show: false),
        ),
      ],
    );
  }

  double calculateArea(int numberOfRectangles) {
    double width = (b - a) / numberOfRectangles;
    double area = 0;
    for (int i = 0; i < numberOfRectangles; i++) {
      double x = a + i * width;
      double height = sqrt(x);
      area += width * height;
    }
    return area;
  }
}
