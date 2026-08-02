import 'package:artriapp/models/health_metric_type.dart';
import 'package:artriapp/utils/app_colors.dart';
import 'package:artriapp/view_models/health_view_model.dart';
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
  bool showPain = true;
  bool showFatigue = false;
  bool showSteps = false;
  bool showSleep = false;
  bool showHeartRate = false;
  bool showEnergy = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HealthViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text(
          'SUA EVOLUÇÃO',
          style: GoogleFonts.montserrat(
            fontSize: 28,
            color: AppColors.darkGreen,
            fontWeight: FontWeight.bold,
          ),
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
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              FilterChip(
                label: const Text('Dor'),
                selected: showPain,
                selectedColor: const Color(0xFFAE263D).withOpacity(0.3),
                checkmarkColor: const Color(0xFFAE263D),
                onSelected: (val) => setState(() => showPain = val),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Fadiga'),
                selected: showFatigue,
                selectedColor: AppColors.darkGreen.withOpacity(0.3),
                checkmarkColor: AppColors.darkGreen,
                onSelected: (val) => setState(() => showFatigue = val),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Passos'),
                selected: showSteps,
                selectedColor: AppColors.mediumGreen.withOpacity(0.3),
                checkmarkColor: AppColors.mediumGreen,
                onSelected: (val) => setState(() => showSteps = val),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Sono'),
                selected: showSleep,
                selectedColor: const Color(0xFF026873).withOpacity(0.3),
                checkmarkColor: const Color(0xFF026873),
                onSelected: (val) => setState(() => showSleep = val),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Freq. Cardíaca'),
                selected: showHeartRate,
                selectedColor: const Color(0xFFAE263D).withOpacity(0.15),
                checkmarkColor: const Color(0xFFAE263D),
                onSelected: (val) => setState(() => showHeartRate = val),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: const Text('Energia'),
                selected: showEnergy,
                selectedColor: AppColors.mediumGreen.withOpacity(0.15),
                checkmarkColor: AppColors.mediumGreen,
                onSelected: (val) => setState(() => showEnergy = val),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 8.0, bottom: 24.0),
            child: Consumer<HealthViewModel>(
              builder: (context, vm, _) {
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return LineChart(mainData(vm));
              },
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(HealthViewModel vm) {
    final lines = <LineChartBarData>[
      if (showPain)
        LineChartBarData(
          spots: [
            for (int i = 0; i < 7; i++)
              FlSpot(i.toDouble(), (8 - i).toDouble()),
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
          spots: [
            for (int i = 0; i < 7; i++)
              FlSpot(i.toDouble(), (5 - i % 3).toDouble()),
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
      if (showSteps)
        _buildHealthDataLine(
          vm,
          HealthMetricType.steps,
          const Color(0xFF04BF8A),
          'Passos',
        ),
      if (showSleep)
        _buildHealthDataLine(
          vm,
          HealthMetricType.sleep,
          const Color(0xFF026873),
          'Sono (h)',
        ),
      if (showHeartRate)
        _buildHealthDataLine(
          vm,
          HealthMetricType.heartRate,
          const Color(0xFFAE263D).withOpacity(0.6),
          'Freq. Cardíaca (bpm)',
        ),
      if (showEnergy)
        _buildHealthDataLine(
          vm,
          HealthMetricType.activeEnergy,
          const Color(0xFF6EFF00),
          'Energia (kcal)',
        ),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: _calculateInterval(lines),
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
            interval: _calculateInterval(lines),
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: _calculateMaxY(lines),
      lineBarsData: lines,
    );
  }

  double _calculateMaxY(List<LineChartBarData> lines) {
    double maxY = 10;
    for (final line in lines) {
      for (final spot in line.spots) {
        if (spot.y > maxY) maxY = spot.y;
      }
    }
    return maxY > 0 ? maxY * 1.1 : 10;
  }

  double _calculateInterval(List<LineChartBarData> lines) {
    final maxY = _calculateMaxY(lines);
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 10;
    if (maxY <= 100) return 20;
    return (maxY / 5).ceilToDouble();
  }

  LineChartBarData _buildHealthDataLine(
    HealthViewModel vm,
    HealthMetricType type,
    Color color,
    String label,
  ) {
    final dailyAgg = vm.getDailyAggregate(type);
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 6));

    final spots = <FlSpot>[];
    for (int i = 0; i < 7; i++) {
      final day = DateTime(
        sevenDaysAgo.year,
        sevenDaysAgo.month,
        sevenDaysAgo.day + i,
      );
      final value = dailyAgg[day] ?? 0;
      spots.add(FlSpot(i.toDouble(), value));
    }

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: spots.any((s) => s.y > 0)),
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.1),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: Colors.black54,
    );
    final days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    final text = value.toInt() >= 0 && value.toInt() < 7
        ? days[value.toInt()]
        : '';

    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.black54,
    );
    return Text(
      value.toInt().toString(),
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
