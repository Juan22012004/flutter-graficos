import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'fl_chart_basicas.dart';

final List<Color> _col = [
  Colors.blue, Colors.orange, Colors.green, Colors.red,
  Colors.purple, Colors.teal, Colors.pink,
];

// ---------- PASTEL / DONA ----------
PieChartSectionData _sec(
  double v,
  Color c, {
  String? titulo,
  double radio = 80,
  BorderSide? borde,
}) {
  return PieChartSectionData(
    value: v,
    color: c,
    title: titulo ?? v.toStringAsFixed(0),
    radius: radio,
    titleStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    borderSide: borde ?? const BorderSide(width: 0),
  );
}

Widget _pie(
  List<PieChartSectionData> s, {
  double centro = 0,
  double espacio = 2,
  double inicio = 0,
}) {
  return PieChart(
    PieChartData(
      sections: s,
      centerSpaceRadius: centro,
      sectionsSpace: espacio,
      startDegreeOffset: inicio,
    ),
  );
}

final List<double> _pv = [30, 25, 20, 15, 10];

List<PieChartSectionData> _secciones({
  String Function(int)? titulo,
  double Function(int)? radio,
  BorderSide? borde,
  List<Color>? colores,
}) {
  return List.generate(_pv.length, (i) {
    return _sec(
      _pv[i],
      (colores ?? _col)[i],
      titulo: titulo?.call(i),
      radio: radio?.call(i) ?? 80,
      borde: borde,
    );
  });
}

// ---------- DISPERSIÓN ----------
final List<List<double>> _pts = [
  [1, 2], [2, 4], [3, 3], [4, 6], [5, 5], [6, 8],
  [7, 6], [8, 9], [9, 7], [3, 7], [6, 3], [8, 4],
];

List<ScatterSpot> _spots({
  double Function(int)? radio,
  Color Function(int)? color,
}) {
  return List.generate(_pts.length, (i) {
    return ScatterSpot(
      _pts[i][0],
      _pts[i][1],
      dotPainter: FlDotCirclePainter(
        radius: radio?.call(i) ?? 6,
        color: color?.call(i) ?? Colors.blue,
      ),
    );
  });
}

Widget _scatter(
  List<ScatterSpot> s, {
  FlGridData grid = const FlGridData(show: true),
  ScatterTouchData? touch,
}) {
  return ScatterChart(
    ScatterChartData(
      scatterSpots: s,
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 10,
      gridData: grid,
      borderData: FlBorderData(show: false),
      scatterTouchData: touch,
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
    ),
  );
}

// ---------- RADAR ----------
final List<String> _ejes = ['Ataque', 'Defensa', 'Velocidad', 'Magia', 'Fuerza'];

RadarDataSet _set(
  List<double> v, {
  Color color = Colors.blue,
  double borde = 2,
  double punto = 3,
}) {
  return RadarDataSet(
    fillColor: color.withAlpha(70),
    borderColor: color,
    borderWidth: borde,
    entryRadius: punto,
    dataEntries: [for (final x in v) RadarEntry(value: x)],
  );
}

Widget _radar(List<RadarDataSet> sets) {
  return RadarChart(
    RadarChartData(
      dataSets: sets,
      tickCount: 4,
      ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 10),
      getTitle: (i, angle) => RadarChartTitle(text: _ejes[i]),
    ),
  );
}

// ---------- BÁSICAS 27-43 ----------
final List<ChartEntry> basicasRestoFl = [
  ChartEntry('B27 Pastel simple', () => _pie(_secciones())),
  ChartEntry('B28 Dona', () => _pie(_secciones(), centro: 50)),
  ChartEntry('B29 Pastel con porcentajes',
      () => _pie(_secciones(titulo: (i) => '${_pv[i].toInt()}%'))),
  ChartEntry(
      'B30 Pastel con colores personalizados',
      () => _pie(_secciones(colores: const [
            Color(0xFF264653), Color(0xFF2A9D8F), Color(0xFFE9C46A),
            Color(0xFFF4A261), Color(0xFFE76F51),
          ]))),
  ChartEntry('B31 Pastel con separación',
      () => _pie(_secciones(), espacio: 8)),
  ChartEntry('B32 Pastel con radios distintos',
      () => _pie(_secciones(radio: (i) => 60.0 + i * 10))),
  ChartEntry('B33 Pastel con título en cada sección',
      () => _pie(_secciones(titulo: (i) => 'Sec ${i + 1}'))),
  ChartEntry('B34 Media dona', () {
    final s = _secciones();
    final total = _pv.reduce((a, b) => a + b);
    s.add(PieChartSectionData(
      value: total,
      color: Colors.transparent,
      title: '',
      radius: 80,
    ));
    return _pie(s, centro: 50, inicio: 180);
  }),
  ChartEntry(
      'B35 Pastel con bordes',
      () => _pie(_secciones(
            borde: const BorderSide(color: Colors.white, width: 4),
          ))),
  ChartEntry('B36 Dispersión simple', () => _scatter(_spots())),
  ChartEntry('B37 Puntos de distinto tamaño',
      () => _scatter(_spots(radio: (i) => 4.0 + i))),
  ChartEntry('B38 Colores por punto',
      () => _scatter(_spots(color: (i) => _col[i % _col.length]))),
  ChartEntry(
      'B39 Dispersión con cuadrícula personalizada',
      () => _scatter(
            _spots(),
            grid: FlGridData(
              show: true,
              horizontalInterval: 2,
              verticalInterval: 2,
              getDrawingHorizontalLine: (v) => FlLine(
                color: Colors.red.withAlpha(80),
                strokeWidth: 1,
                dashArray: [4, 4],
              ),
              getDrawingVerticalLine: (v) => FlLine(
                color: Colors.green.withAlpha(80),
                strokeWidth: 1,
                dashArray: [4, 4],
              ),
            ),
          )),
  ChartEntry(
      'B40 Dispersión con tooltip',
      () => _scatter(
            _spots(),
            touch: ScatterTouchData(
              enabled: true,
              handleBuiltInTouches: true,
              touchTooltipData: ScatterTouchTooltipData(
                getTooltipItems: (s) => ScatterTooltipItem(
                  '(${s.x}, ${s.y})',
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )),
  ChartEntry('B41 Radar simple',
      () => _radar([_set([4, 3, 5, 2, 4])])),
  ChartEntry(
      'B42 Radar con 2 series',
      () => _radar([
            _set([4, 3, 5, 2, 4], color: Colors.blue),
            _set([2, 5, 3, 4, 3], color: Colors.orange),
          ])),
  ChartEntry(
      'B43 Radar con relleno personalizado',
      () => _radar([
            _set([4, 3, 5, 2, 4], color: Colors.purple, borde: 4, punto: 6),
          ])),
];