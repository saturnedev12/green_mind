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

class VegetationAnalysePage extends StatefulWidget {
  @override
  State<VegetationAnalysePage> createState() => _VegetationAnalysePageState();
}

class _VegetationAnalysePageState extends State<VegetationAnalysePage> {
  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [false, false, false];
    return Scaffold(
        body: Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          color: Colors.amber,
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(left: 30),
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Champs : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text("Champs de palm",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    Image.asset(
                      'assets/icons/search.png',
                      scale: 20,
                    ),
                    Image.asset(
                      'assets/icons/list.png',
                      scale: 30,
                    ),
                  ]),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 20, top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Zone d'observation",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.3)),
                        child: Row(
                          children: [],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Date de la dernière observation",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Icon(Icons.date_range),
                        SizedBox(width: 8),
                        Text("22 dec 2023")
                      ]),
                    )
                  ]),
            )
          ]),
        )
      ],
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
