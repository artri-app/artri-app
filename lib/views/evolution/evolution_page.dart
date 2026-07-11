import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:artriapp/utils/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class EvolutionPage extends StatefulWidget {
  const EvolutionPage({super.key});

  @override
  State<EvolutionPage> createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  bool showPain = true;
  bool showFatigue = false;
  final GlobalKey _chartKey = GlobalKey();

  Future<void> _shareImage() async {
    try {
      RenderRepaintBoundary boundary = _chartKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getTemporaryDirectory()).path;
      File imgFile = File('$directory/evolucao_artriapp.png');
      await imgFile.writeAsBytes(pngBytes);

      await Share.shareXFiles(
        [XFile(imgFile.path)],
        text: 'Acompanhe minha evolução no Artriapp!',
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _chartKey,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SUA EVOLUÇÃO',
                  style: GoogleFonts.montserrat(
                    fontSize: 28,
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.share, color: AppColors.darkGreen),
                  onPressed: _shareImage,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Acompanhe seus sintomas dos últimos 7 dias',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterChip(
                  label: const Text('Dor'),
                  selected: showPain,
                  selectedColor: const Color(0xFFAE263D).withOpacity(0.3),
                  checkmarkColor: const Color(0xFFAE263D),
                  onSelected: (val) => setState(() => showPain = val),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  label: const Text('Fadiga'),
                  selected: showFatigue,
                  selectedColor: AppColors.darkGreen.withOpacity(0.3),
                  checkmarkColor: AppColors.darkGreen,
                  onSelected: (val) => setState(() => showFatigue = val),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0, left: 8.0, bottom: 24.0),
                child: LineChart(
                  _mainData(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.neutral,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        if (showPain)
          LineChartBarData(
            spots: const [
              FlSpot(0, 8),
              FlSpot(1, 6),
              FlSpot(2, 7),
              FlSpot(3, 5),
              FlSpot(4, 4),
              FlSpot(5, 6),
              FlSpot(6, 3),
            ],
            isCurved: true,
            color: const Color(0xFFAE263D),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFAE263D).withOpacity(0.15),
            ),
          ),
        if (showFatigue)
          LineChartBarData(
            spots: const [
              FlSpot(0, 4),
              FlSpot(1, 5),
              FlSpot(2, 5),
              FlSpot(3, 3),
              FlSpot(4, 6),
              FlSpot(5, 8),
              FlSpot(6, 4),
            ],
            isCurved: true,
            color: AppColors.darkGreen,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.darkGreenSurface.withOpacity(0.3),
            ),
          ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: Colors.black54,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Seg', style: style);
        break;
      case 1:
        text = Text('Ter', style: style);
        break;
      case 2:
        text = Text('Qua', style: style);
        break;
      case 3:
        text = Text('Qui', style: style);
        break;
      case 4:
        text = Text('Sex', style: style);
        break;
      case 5:
        text = Text('Sáb', style: style);
        break;
      case 6:
        text = Text('Dom', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      meta: meta,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.black54,
    );
    return Text(value.toInt().toString(), style: style, textAlign: TextAlign.center);
  }
}