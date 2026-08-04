import 'package:artriapp/utils/index.dart';
import 'package:artriapp/view_models/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EvolutionPage extends StatefulWidget {
  const EvolutionPage({super.key});

  @override
  State<EvolutionPage> createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  // Controle de qual métrica exibir para não poluir o gráfico
  bool showPain = true;
  bool showFatigue = false;
  bool showSleep = false;
  bool showSwelling = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<EvolutionViewModel>(
      builder: (context, viewModel, child) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              'SUA EVOLUÇÃO',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                color: AppColors.darkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Acompanhe seus sintomas dos últimos 7 dias',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),

            // Filtros para o usuário escolher o que ver
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterChip(
                  label: const Text('Dor'),
                  selected: showPain,
                  selectedColor: AppColors.red.withValues(alpha: 0.3),
                  showCheckmark: false,
                  onSelected: (val) => setState(() => showPain = val),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  label: const Text('Fadiga'),
                  selected: showFatigue,
                  selectedColor: AppColors.darkGreen.withValues(alpha: 0.3),
                  showCheckmark: false,
                  onSelected: (val) => setState(() => showFatigue = val),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  label: const Text('Sono'),
                  selected: showSleep,
                  selectedColor: AppColors.yellow.withValues(alpha: 0.3),
                  showCheckmark: false,
                  onSelected: (val) => setState(() => showSleep = val),
                ),
                const SizedBox(width: 12),
                FilterChip(
                  label: const Text('Inchaço'),
                  selected: showSwelling,
                  selectedColor: AppColors.purple.withValues(alpha: 0.3),
                  showCheckmark: false,
                  onSelected: (val) => setState(() => showSwelling = val),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // O Gráfico usando fl_chart
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0, left: 8.0, bottom: 24.0),
                child: LineChart(
                  _mainData(viewModel),
                ),
              ),
            ),
          ],
        );

      },
    );
  }

  LineChartData _mainData(EvolutionViewModel viewModel) {
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
        show: false, // Sem bordas ao redor do gráfico para um visual mais limpo
      ),
      minX: 0,
      maxX: 6, // 7 dias (0 a 6)
      minY: 0,
      maxY: 10, // Escala de 0 a 10 usada no ScaleSelector
      lineBarsData: [
        if (showPain)
          LineChartBarData(
            spots: viewModel.getLast7PainLevels(),
            isCurved: true, // Deixa a linha suave
            color: AppColors.red, // Vermelho para representar dor
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.red.withValues(alpha: 0.15),
            ),
          ),
        if (showFatigue)
          LineChartBarData(
            spots: viewModel.getLast7FatigueLevels(),
            isCurved: true,
            color: AppColors.darkGreen, // Cor do tema para fadiga
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.darkGreenSurface.withValues(alpha: 0.3),
            ),
          ),
        if (showSleep)
          LineChartBarData(
            spots: viewModel.getLast7SleepLevels(),
            isCurved: true, // Deixa a linha suave
            color: AppColors.yellow, // Vermelho para representar dor
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.yellow.withValues(alpha: 0.15),
            ),
          ),
        if (showSwelling)
          LineChartBarData(
            spots: viewModel.getLast7SwellingLevels(),
            isCurved: true, // Deixa a linha suave
            color: AppColors.purple, // Vermelho para representar dor
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.purple.withValues(alpha: 0.15),
            ),
          ),
      ],
    );
  }

  // Títulos do Eixo X (Dias)
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: Colors.black54,
    );
    Widget text;
    switch (value.toInt()) {
      case 0: text = Text('Seg', style: style); break;
      case 1: text = Text('Ter', style: style); break;
      case 2: text = Text('Qua', style: style); break;
      case 3: text = Text('Qui', style: style); break;
      case 4: text = Text('Sex', style: style); break;
      case 5: text = Text('Sáb', style: style); break;
      case 6: text = Text('Dom', style: style); break;
      default: text = Text('', style: style); break;
    }

    return SideTitleWidget(
      meta: meta,
      child: text,
    );
  }

  // Títulos do Eixo Y (Escala 0 a 10)
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.black54,
    );
    return Text(value.toInt().toString(), style: style, textAlign: TextAlign.center);
  }
}