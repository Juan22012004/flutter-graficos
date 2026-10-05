import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class FlChartAvanzadas extends StatelessWidget {
  const FlChartAvanzadas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Gráfico de líneas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1),
                        FlSpot(1, 3),
                        FlSpot(2, 2),
                        FlSpot(3, 5),
                        FlSpot(4, 4),
                        FlSpot(5, 7),
                      ],
                      isCurved: true,
                      barWidth: 4,
                      dotData: const FlDotData(
                        show: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Gráfico de barras',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(toY: 8),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: 12),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: 10),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(toY: 15),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(toY: 11),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Gráfico circular',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      title: '40%',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 30,
                      title: '30%',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: '20%',
                      radius: 80,
                    ),
                    PieChartSectionData(
                      value: 10,
                      title: '10%',
                      radius: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}