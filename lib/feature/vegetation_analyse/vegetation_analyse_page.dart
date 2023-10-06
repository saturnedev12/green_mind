import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/data/models/weather_data_agregation_model.dart';
import 'package:greenmind/feature/map/simple_map.dart';
import 'package:greenmind/tests/meteo_box.dart';
import 'package:greenmind/tests/weather_small_box.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

class VegetationAnalysePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: CupertinoColors.systemFill,
        appBar: AppBar(
          title: Text('Analyse du sole'),
        ),
        body: SingleChildScrollView(
          child: Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: SimpleMap(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Faible végétation'),
                              Text('Haute'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: LinearPercentIndicator(
                            linearGradient: LinearGradient(colors: [
                              Colors.red,
                              Colors.orange,
                              Colors.yellow,
                              Colors.green
                            ]),
                            animation: true,
                            percent: 0.7,

                            //progressColor: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: Offset.zero,
                            blurRadius: 10,
                            spreadRadius: 0.5,
                          )
                        ]),
                    child: TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 10, 16), // DateTime.now(),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(DateTime.now(), day);
                      },
                      // onDaySelected: (selectedDay, focusedDay) {
                      //   context
                      //       .read<BusinessCubit>()
                      //       .onGetRideByDay(context: context, date: selectedDay);
                      //   context
                      //       .read<GetSumCubit>()
                      //       .onGetRideSum(context: context, date: selectedDay);
                      //   setState(() {
                      //     _focusedDay = selectedDay;
                      //     _focusedDay =
                      //         focusedDay; // update `_focusedDay` here as well
                      //   });
                      // },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  WeatherSmallBox(
                    weatherDataAgregationModel: WeatherDataAgregationModel(
                        date: '29',
                        tempAirMin: 19,
                        tempAirMax: 29,
                        tempLandMin: 14,
                        tempLandMax: 19,
                        relHumidity: 19,
                        snowDepth: 10,
                        rain: Rain(
                            h02: 1,
                            h05: 2,
                            h08: 3,
                            h11: 4,
                            h14: 5,
                            h17: 6,
                            h20: 7,
                            h23: 8),
                        windSpeed: WindSpeed(
                            h02: 1,
                            h05: 2,
                            h08: 3,
                            h11: 3,
                            h14: 4,
                            h17: 5,
                            h20: 6,
                            h23: 8)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

/**
 * ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          const Text(
            'Column Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCartesianChart(
              series: <ChartSeries>[
                ColumnSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
              primaryXAxis: CategoryAxis(),
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Pie Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCircularChart(
              series: <CircularSeries>[
                PieSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Line Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCartesianChart(
              series: <ChartSeries>[
                LineSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
              primaryXAxis: CategoryAxis(),
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Area Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCartesianChart(
              series: <ChartSeries>[
                AreaSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
              primaryXAxis: CategoryAxis(),
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Bar Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCartesianChart(
              series: <ChartSeries>[
                BarSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
              primaryXAxis: CategoryAxis(),
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Spline Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCartesianChart(
              series: <ChartSeries>[
                SplineSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
              primaryXAxis: CategoryAxis(),
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Scatter Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCartesianChart(
              series: <ChartSeries>[
                ScatterSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
              primaryXAxis: CategoryAxis(),
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            'Stacked Column Chart',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Container(
            height: 300,
            child: SfCartesianChart(
              series: <ChartSeries>[
                StackedColumnSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 35),
                    SalesData('Feb', 28),
                    SalesData('Mar', 34),
                    SalesData('Apr', 32),
                    SalesData('May', 40),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                ),
              ],
              primaryXAxis: CategoryAxis(),
            ),
          ),
        ],
      ),
    
 */
class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}
