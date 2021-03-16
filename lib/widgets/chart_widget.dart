import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample3 extends StatelessWidget {
  var weekDays = [
    '2019',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        SizedBox(
          width: 380,
          height: 180,
          child: FlChart(
            chart: LineChart(
              LineChartData(
                clipToBorder: false,
                lineTouchData: LineTouchData(
                    getTouchedSpotIndicator: (List<TouchedSpot> spots) {
                      return spots.map((spot) {
                        if (spot.spot.x == 0 || spot.spot.x == 6) {
                          return null;
                        }
                        return TouchedSpotIndicatorData(
                          const FlLine(
                              color: Colors.transparent, strokeWidth: 0),
                          const FlDotData(
                              dotSize: 8, dotColor: Color(0xFF5574F7)),
                        );
                      }).toList();
                    },
                    touchTooltipData: TouchTooltipData(
                        tooltipBgColor: Colors.blueAccent,
                        getTooltipItems: (List<TouchedSpot> spots) {
                          return spots.map((spot) {
                            final flSpot = spot.spot;
                            if (flSpot.x == 0 || flSpot.x == 6) {
                              return null;
                            }

                            return TooltipItem(
                              '${weekDays[flSpot.x.toInt()]} \n${flSpot.y} k',
                              const TextStyle(color: Colors.white),
                            );
                          }).toList();
                        })),
                extraLinesData:
                    ExtraLinesData(showVerticalLines: false, verticalLines: [
                  VerticalLine(
                    y: 1.8,
                    color: Colors.green.withOpacity(0.7),
                    strokeWidth: 4,
                  ),
                ]),
                borderData: FlBorderData(
                    show: true,
                    border: Border(
                        left: BorderSide(color: Colors.transparent, width: 0),
                        top: BorderSide(color: Colors.transparent, width: 0),
                        right: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 0.5),
                        bottom: BorderSide(
                            color: Color(0xFF5574F7).withOpacity(0.2),
                            width: 5))),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 1.3),
                      FlSpot(1, 0.5),
                      FlSpot(2, 1.3),
                      FlSpot(3, 2.0),
                      FlSpot(4, 0.8),
                      FlSpot(5, 1.8),
                    ],
                    isCurved: true,
                    barWidth: 4,
                    colors: [
                      Color(0xFF5574F7),
                    ],
                    belowBarData: BelowBarData(
                        //Bar fill gradient
                        show: true,
                        colors: [
                          Color(0xFF60C3FF).withOpacity(0.5),
                          Color(0xFF5574F7).withOpacity(0.0),
                        ],
                        gradientColorStops: [0.5, 1.0],
                        gradientFrom: Offset(0, 0),
                        gradientTo: Offset(0, 1),
                        belowSpotsLine: BelowSpotsLine(
                            show: false,
                            flLineStyle: const FlLine(
                              color: Color(0xFF5574F7),
                              strokeWidth: 2,
                            ),
                            checkToShowSpotBelowLine: (spot) {
                              if (spot.x == 0 || spot.x == 6) {
                                return false;
                              }

                              return true;
                            })),
                    dotData: FlDotData(
                        show: true,
                        dotColor: Color(0xFF5574F7),
                        dotSize: 6,
                        checkToShowDot: (spot) {
                          return spot.x != 6;
                        }),
                  ),
                ],
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalGrid: true,
                  drawVerticalGrid: false,
                  getDrawingVerticalGridLine: (value) {
                    return const FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.2,
                    );
                  },
                  getDrawingHorizontalGridLine: (value) {
                    return const FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.3,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                    show: true,
                    leftTitles: SideTitles(
                      showTitles: false,
                      getTitles: (value) {
                        // switch (value.toInt()) {
                        //   case 0:
                        //     return '';
                        //   case 1:
                        //     return '1k colories';
                        //   case 2:
                        //     return '2k colories';
                        //   case 3:
                        //     return '3k colories';
                        // }

                        return '';
                      },
                      // textStyle: const TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        return weekDays[value.toInt()];
                      },
                      textStyle: const TextStyle(
                          color: Color(0xFF5574F7), fontSize: 12.0),
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
