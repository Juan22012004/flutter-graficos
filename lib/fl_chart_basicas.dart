import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartEntry {
  final String titulo;
  final Widget Function() build;

  const ChartEntry(this.titulo, this.build);
}

// ============================================================
// DATOS
// ============================================================

final List<FlSpot> _datosA = [
  FlSpot(0, 1),
  FlSpot(1, 3),
  FlSpot(2, 2),
  FlSpot(3, 5),
  FlSpot(4, 3.5),
  FlSpot(5, 4),
  FlSpot(6, 6),
];

final List<FlSpot> _datosB = [
  FlSpot(0, 2),
  FlSpot(1, 1.5),
  FlSpot(2, 4),
  FlSpot(3, 3),
  FlSpot(4, 5),
  FlSpot(5, 2.5),
  FlSpot(6, 4),
];

final List<FlSpot> _datosC = [
  FlSpot(0, 4),
  FlSpot(1, 5),
  FlSpot(2, 3),
  FlSpot(3, 1),
  FlSpot(4, 2),
  FlSpot(5, 6),
  FlSpot(6, 5),
];

// ============================================================
// LÍNEAS
// ============================================================

LineChartBarData _linea(
  List<FlSpot> spots, {
  Color color = Colors.blue,
  bool curva = false,
  bool puntos = true,
  bool area = false,
  List<int>? dash,
  bool escalon = false,
  double grosor = 3,
  Gradient? degradado,
}) {
  return LineChartBarData(
    spots: spots,
    isCurved: curva,
    color: color,
    gradient: degradado,
    barWidth: grosor,
    dotData: FlDotData(show: puntos),
    belowBarData: BarAreaData(
      show: area,
      color: color.withAlpha(50),
    ),
    dashArray: dash,
    isStepLineChart: escalon,
  );
}

Widget _grafLinea(
  List<LineChartBarData> lineas, {
  LineTouchData touch = const LineTouchData(),
}) {
  return LineChart(
    LineChartData(
      lineBarsData: lineas,
      lineTouchData: touch,
      gridData: const FlGridData(show: true),
      borderData: FlBorderData(show: false),
    ),
  );
}

// ============================================================
// BARRAS
// ============================================================

BarChartGroupData _grupoBarra(
  int x,
  List<double> valores, {
  List<Color> colores = const [Colors.blue],
}) {
  return BarChartGroupData(
    x: x,
    barRods: List.generate(
      valores.length,
      (i) => BarChartRodData(
        toY: valores[i],
        color: colores[i % colores.length],
        width: 14,
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}

Widget _grafBarras(List<BarChartGroupData> grupos) {
  return BarChart(
    BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 8,
      barGroups: grupos,
      gridData: const FlGridData(show: true),
      borderData: FlBorderData(show: false),
      titlesData: const FlTitlesData(
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
    ),
  );
}

// ============================================================
// LISTA DE LAS 43 GRÁFICAS BÁSICAS
// ============================================================

final List<ChartEntry> basicasFl = [

  // ==================== B1-B12 LÍNEAS ====================

  ChartEntry(
    'B1 Línea simple',
    () => _grafLinea([
      _linea(_datosA),
    ]),
  ),

  ChartEntry(
    'B2 Línea curva',
    () => _grafLinea([
      _linea(_datosA, curva: true),
    ]),
  ),

  ChartEntry(
    'B3 Línea con puntos',
    () => _grafLinea([
      _linea(_datosA, puntos: true),
    ]),
  ),

  ChartEntry(
    'B4 Línea sin puntos',
    () => _grafLinea([
      _linea(_datosA, puntos: false),
    ]),
  ),

  ChartEntry(
    'B5 Línea con área',
    () => _grafLinea([
      _linea(
        _datosA,
        area: true,
        curva: true,
      ),
    ]),
  ),

  ChartEntry(
    'B6 Línea punteada',
    () => _grafLinea([
      _linea(
        _datosA,
        dash: [6, 4],
      ),
    ]),
  ),

  ChartEntry(
    'B7 Línea escalonada',
    () => _grafLinea([
      _linea(
        _datosA,
        escalon: true,
      ),
    ]),
  ),

  ChartEntry(
    'B8 Dos líneas',
    () => _grafLinea([
      _linea(_datosA, color: Colors.blue),
      _linea(_datosB, color: Colors.orange),
    ]),
  ),

  ChartEntry(
    'B9 Tres líneas',
    () => _grafLinea([
      _linea(_datosA, color: Colors.blue),
      _linea(_datosB, color: Colors.orange),
      _linea(_datosC, color: Colors.green),
    ]),
  ),

  ChartEntry(
    'B10 Líneas con grosor distinto',
    () => _grafLinea([
      _linea(
        _datosA,
        color: Colors.blue,
        grosor: 2,
      ),
      _linea(
        _datosB,
        color: Colors.orange,
        grosor: 6,
      ),
    ]),
  ),

  ChartEntry(
    'B11 Línea con degradado',
    () => _grafLinea([
      _linea(
        _datosA,
        curva: true,
        grosor: 5,
        degradado: const LinearGradient(
          colors: [
            Colors.blue,
            Colors.purple,
          ],
        ),
      ),
    ]),
  ),

  ChartEntry(
    'B12 Línea con tooltip táctil',
    () => _grafLinea(
      [
        _linea(
          _datosA,
          curva: true,
        ),
      ],
      touch: const LineTouchData(
        handleBuiltInTouches: true,
      ),
    ),
  ),

  // ==================== B13-B26 BARRAS ====================

  ChartEntry(
    'B13 Barras simples',
    () => _grafBarras([
      _grupoBarra(0, [4]),
      _grupoBarra(1, [6]),
      _grupoBarra(2, [3]),
      _grupoBarra(3, [7]),
      _grupoBarra(4, [5]),
    ]),
  ),

  ChartEntry(
    'B14 Barras de colores',
    () => _grafBarras([
      _grupoBarra(0, [4], colores: [Colors.blue]),
      _grupoBarra(1, [6], colores: [Colors.orange]),
      _grupoBarra(2, [3], colores: [Colors.green]),
      _grupoBarra(3, [7], colores: [Colors.red]),
    ]),
  ),

  ChartEntry(
    'B15 Barras agrupadas',
    () => _grafBarras([
      _grupoBarra(
        0,
        [4, 6],
        colores: [Colors.blue, Colors.orange],
      ),
      _grupoBarra(
        1,
        [5, 3],
        colores: [Colors.blue, Colors.orange],
      ),
      _grupoBarra(
        2,
        [7, 4],
        colores: [Colors.blue, Colors.orange],
      ),
    ]),
  ),

  ChartEntry(
    'B16 Barras de tres series',
    () => _grafBarras([
      _grupoBarra(
        0,
        [3, 5, 2],
        colores: [
          Colors.blue,
          Colors.orange,
          Colors.green,
        ],
      ),
      _grupoBarra(
        1,
        [6, 2, 5],
        colores: [
          Colors.blue,
          Colors.orange,
          Colors.green,
        ],
      ),
      _grupoBarra(
        2,
        [4, 7, 3],
        colores: [
          Colors.blue,
          Colors.orange,
          Colors.green,
        ],
      ),
    ]),
  ),

  ChartEntry(
    'B17 Barras horizontales',
    () => BarChart(
      BarChartData(
        maxY: 8,
        barGroups: [
          _grupoBarra(0, [4]),
          _grupoBarra(1, [6]),
          _grupoBarra(2, [3]),
          _grupoBarra(3, [7]),
        ],
        rotationQuarterTurns: 1,
      ),
    ),
  ),

  ChartEntry(
    'B18 Barras altas',
    () => _grafBarras([
      _grupoBarra(0, [8]),
      _grupoBarra(1, [6]),
      _grupoBarra(2, [7]),
      _grupoBarra(3, [5]),
    ]),
  ),

  ChartEntry(
    'B19 Barras pequeñas',
    () => _grafBarras([
      _grupoBarra(0, [1]),
      _grupoBarra(1, [2]),
      _grupoBarra(2, [1.5]),
      _grupoBarra(3, [2.5]),
    ]),
  ),

  ChartEntry(
    'B20 Barras comparativas',
    () => _grafBarras([
      _grupoBarra(
        0,
        [5, 3],
        colores: [Colors.blue, Colors.red],
      ),
      _grupoBarra(
        1,
        [7, 4],
        colores: [Colors.blue, Colors.red],
      ),
      _grupoBarra(
        2,
        [4, 6],
        colores: [Colors.blue, Colors.red],
      ),
    ]),
  ),

  ChartEntry(
    'B21 Barras con tres categorías',
    () => _grafBarras([
      _grupoBarra(
        0,
        [2, 4, 6],
        colores: [
          Colors.blue,
          Colors.orange,
          Colors.green,
        ],
      ),
      _grupoBarra(
        1,
        [3, 5, 7],
        colores: [
          Colors.blue,
          Colors.orange,
          Colors.green,
        ],
      ),
    ]),
  ),

  ChartEntry(
    'B22 Barras ascendentes',
    () => _grafBarras([
      _grupoBarra(0, [1]),
      _grupoBarra(1, [2]),
      _grupoBarra(2, [3]),
      _grupoBarra(3, [4]),
      _grupoBarra(4, [5]),
      _grupoBarra(5, [6]),
      _grupoBarra(6, [7]),
    ]),
  ),

  ChartEntry(
    'B23 Barras descendentes',
    () => _grafBarras([
      _grupoBarra(0, [7]),
      _grupoBarra(1, [6]),
      _grupoBarra(2, [5]),
      _grupoBarra(3, [4]),
      _grupoBarra(4, [3]),
      _grupoBarra(5, [2]),
      _grupoBarra(6, [1]),
    ]),
  ),

  ChartEntry(
    'B24 Barras con dos grupos',
    () => _grafBarras([
      _grupoBarra(
        0,
        [5, 2],
        colores: [Colors.blue, Colors.orange],
      ),
      _grupoBarra(
        1,
        [3, 6],
        colores: [Colors.blue, Colors.orange],
      ),
      _grupoBarra(
        2,
        [7, 4],
        colores: [Colors.blue, Colors.orange],
      ),
    ]),
  ),

  ChartEntry(
    'B25 Barras multicolor',
    () => _grafBarras([
      _grupoBarra(0, [4], colores: [Colors.blue]),
      _grupoBarra(1, [5], colores: [Colors.orange]),
      _grupoBarra(2, [6], colores: [Colors.green]),
      _grupoBarra(3, [3], colores: [Colors.red]),
      _grupoBarra(4, [7], colores: [Colors.purple]),
    ]),
  ),

  ChartEntry(
    'B26 Barras con bordes',
    () => _grafBarras([
      _grupoBarra(0, [4]),
      _grupoBarra(1, [6]),
      _grupoBarra(2, [5]),
      _grupoBarra(3, [7]),
    ]),
  ),

  // ==================== B27-B34 CIRCULARES ====================

  ChartEntry(
    'B27 Gráfico circular',
    () => PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 40,
            title: '40%',
            color: Colors.blue,
            radius: 80,
          ),
          PieChartSectionData(
            value: 30,
            title: '30%',
            color: Colors.orange,
            radius: 80,
          ),
          PieChartSectionData(
            value: 20,
            title: '20%',
            color: Colors.green,
            radius: 80,
          ),
          PieChartSectionData(
            value: 10,
            title: '10%',
            color: Colors.red,
            radius: 80,
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B28 Gráfico donut',
    () => PieChart(
      PieChartData(
        centerSpaceRadius: 45,
        sections: [
          PieChartSectionData(
            value: 40,
            title: '40%',
            color: Colors.blue,
            radius: 70,
          ),
          PieChartSectionData(
            value: 30,
            title: '30%',
            color: Colors.orange,
            radius: 70,
          ),
          PieChartSectionData(
            value: 20,
            title: '20%',
            color: Colors.green,
            radius: 70,
          ),
          PieChartSectionData(
            value: 10,
            title: '10%',
            color: Colors.red,
            radius: 70,
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B29 Circular con porcentajes',
    () => PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 50,
            title: '50%',
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 25,
            title: '25%',
            color: Colors.orange,
          ),
          PieChartSectionData(
            value: 15,
            title: '15%',
            color: Colors.green,
          ),
          PieChartSectionData(
            value: 10,
            title: '10%',
            color: Colors.red,
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B30 Circular con cuatro categorías',
    () => PieChart(
      PieChartData(
        sectionsSpace: 4,
        sections: [
          PieChartSectionData(
            value: 30,
            title: 'A',
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 25,
            title: 'B',
            color: Colors.orange,
          ),
          PieChartSectionData(
            value: 20,
            title: 'C',
            color: Colors.green,
          ),
          PieChartSectionData(
            value: 25,
            title: 'D',
            color: Colors.red,
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B31 Circular con separación',
    () => PieChart(
      PieChartData(
        sectionsSpace: 10,
        sections: [
          PieChartSectionData(
            value: 40,
            title: '40',
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 35,
            title: '35',
            color: Colors.orange,
          ),
          PieChartSectionData(
            value: 25,
            title: '25',
            color: Colors.green,
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B32 Donut pequeño',
    () => PieChart(
      PieChartData(
        centerSpaceRadius: 60,
        sections: [
          PieChartSectionData(
            value: 60,
            title: '60%',
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 40,
            title: '40%',
            color: Colors.orange,
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B33 Circular de ventas',
    () => PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 45,
            title: 'A',
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 30,
            title: 'B',
            color: Colors.orange,
          ),
          PieChartSectionData(
            value: 25,
            title: 'C',
            color: Colors.green,
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B34 Circular de categorías',
    () => PieChart(
      PieChartData(
        centerSpaceRadius: 35,
        sections: [
          PieChartSectionData(
            value: 35,
            title: '35%',
            color: Colors.purple,
          ),
          PieChartSectionData(
            value: 30,
            title: '30%',
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 20,
            title: '20%',
            color: Colors.orange,
          ),
          PieChartSectionData(
            value: 15,
            title: '15%',
            color: Colors.green,
          ),
        ],
      ),
    ),
  ),

  // ==================== B35-B38 DISPERSIÓN ====================

  ChartEntry(
    'B35 Dispersión simple',
    () => ScatterChart(
      ScatterChartData(
        scatterSpots: [
          ScatterSpot(1, 2),
          ScatterSpot(2, 4),
          ScatterSpot(3, 3),
          ScatterSpot(4, 6),
          ScatterSpot(5, 5),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B36 Dispersión con más puntos',
    () => ScatterChart(
      ScatterChartData(
        scatterSpots: [
          ScatterSpot(1, 1),
          ScatterSpot(2, 3),
          ScatterSpot(3, 2),
          ScatterSpot(4, 5),
          ScatterSpot(5, 4),
          ScatterSpot(6, 7),
          ScatterSpot(7, 6),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B37 Dispersión agrupada',
    () => ScatterChart(
      ScatterChartData(
        scatterSpots: [
          ScatterSpot(1, 2),
          ScatterSpot(2, 4),
          ScatterSpot(3, 3),
          ScatterSpot(4, 5),
          ScatterSpot(5, 6),
          ScatterSpot(6, 4),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B38 Dispersión ascendente',
    () => ScatterChart(
      ScatterChartData(
        scatterSpots: [
          ScatterSpot(1, 1),
          ScatterSpot(2, 2),
          ScatterSpot(3, 3),
          ScatterSpot(4, 4),
          ScatterSpot(5, 5),
          ScatterSpot(6, 6),
        ],
      ),
    ),
  ),

  // ==================== B39-B43 RADAR ====================

  ChartEntry(
    'B39 Radar simple',
    () => RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            fillColor: Colors.blue.withAlpha(80),
            borderColor: Colors.blue,
            entryRadius: 3,
            dataEntries: [
              RadarEntry(value: 4),
              RadarEntry(value: 6),
              RadarEntry(value: 5),
              RadarEntry(value: 7),
              RadarEntry(value: 3),
            ],
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B40 Radar comparativo',
    () => RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            fillColor: Colors.blue.withAlpha(70),
            borderColor: Colors.blue,
            dataEntries: [
              RadarEntry(value: 5),
              RadarEntry(value: 7),
              RadarEntry(value: 4),
              RadarEntry(value: 6),
              RadarEntry(value: 3),
            ],
          ),
          RadarDataSet(
            fillColor: Colors.orange.withAlpha(70),
            borderColor: Colors.orange,
            dataEntries: [
              RadarEntry(value: 4),
              RadarEntry(value: 5),
              RadarEntry(value: 7),
              RadarEntry(value: 3),
              RadarEntry(value: 6),
            ],
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B41 Radar de habilidades',
    () => RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            fillColor: Colors.green.withAlpha(70),
            borderColor: Colors.green,
            dataEntries: [
              RadarEntry(value: 8),
              RadarEntry(value: 6),
              RadarEntry(value: 7),
              RadarEntry(value: 5),
              RadarEntry(value: 8),
            ],
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B42 Radar de rendimiento',
    () => RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            fillColor: Colors.purple.withAlpha(70),
            borderColor: Colors.purple,
            dataEntries: [
              RadarEntry(value: 6),
              RadarEntry(value: 8),
              RadarEntry(value: 5),
              RadarEntry(value: 7),
              RadarEntry(value: 6),
              RadarEntry(value: 8),
            ],
          ),
        ],
      ),
    ),
  ),

  ChartEntry(
    'B43 Radar de comparación',
    () => RadarChart(
      RadarChartData(
        dataSets: [
          RadarDataSet(
            fillColor: Colors.blue.withAlpha(60),
            borderColor: Colors.blue,
            dataEntries: [
              RadarEntry(value: 7),
              RadarEntry(value: 5),
              RadarEntry(value: 8),
              RadarEntry(value: 6),
              RadarEntry(value: 4),
            ],
          ),
          RadarDataSet(
            fillColor: Colors.red.withAlpha(60),
            borderColor: Colors.red,
            dataEntries: [
              RadarEntry(value: 5),
              RadarEntry(value: 7),
              RadarEntry(value: 6),
              RadarEntry(value: 8),
              RadarEntry(value: 3),
            ],
          ),
        ],
      ),
    ),
  ),
];