import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/chart/chart_bloc.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.purple,
  ];

  bool showAvg = true;
  late ChartBloc chartBloc;

  @override
  void initState() {
    chartBloc = BlocProvider.of<ChartBloc>(context);
    chartBloc.add(GetIncomeAYear());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        showAvg = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.constraints.maxWidth > mobileWidth
            ? null
            : const BackButton(),
        title: const Text(
          "Doanh thu tháng này",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: BlocBuilder<ChartBloc, ChartState>(
                builder: (context, state) {
                  return LineChart(
                    duration: 300.ms,
                    showAvg
                        ? avgData()
                        : mainData(
                            state: state,
                          ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 60,
            height: 34,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Text(
                'Triệu đồng',
                style:
                    TextStyle(fontSize: 12, color: colorScheme(context).scrim),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('T1', style: style);
      case 1:
        text = const Text('T2', style: style);
      case 2:
        text = const Text('T3', style: style);
        break;
      case 2:
        text = const Text('T3', style: style);
        break;
      case 3:
        text = const Text('T4', style: style);
        break;
      case 4:
        text = const Text('T5', style: style);
        break;
      case 5:
        text = const Text('T6', style: style);
        break;
      case 6:
        text = const Text('T7', style: style);
        break;
      case 7:
        text = const Text('T8', style: style);
        break;
      case 8:
        text = const Text('T9', style: style);
        break;
      case 9:
        text = const Text('T10', style: style);
        break;
      case 10:
        text = const Text('T11', style: style);
        break;
      case 11:
        text = const Text('T12', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10tr';
        break;
      case 3:
        text = '30tr';
        break;
      case 5:
        text = '50tr';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData({required ChartState state}) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorScheme(context).scrim.withOpacity(0.2),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: colorScheme(context).scrim.withOpacity(0.3),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
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
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          // spots: const [
          //   FlSpot(0, 3),
          //   FlSpot(2, 2),
          //   FlSpot(4, 5),
          //   FlSpot(6, 3.1),
          //   FlSpot(8, 4),
          //   FlSpot(10, 3),
          //   FlSpot(11, 4),
          // ],
          spots: state.incomesYear
              .asMap()
              .entries
              .map((e) => FlSpot(
                  e.key.toDouble(), e.value.totalAmount!.toDouble() / 10000000))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 3),
            FlSpot(2, 3),
            FlSpot(3, 3),
            FlSpot(4, 3),
            FlSpot(5, 3),
            FlSpot(6, 3),
            FlSpot(7, 3),
            FlSpot(8, 3),
            FlSpot(9, 3),
            FlSpot(10, 3),
            FlSpot(11, 3),
            FlSpot(12, 3),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
