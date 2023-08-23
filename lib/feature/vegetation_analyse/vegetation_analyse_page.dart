import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VegetationAnalysePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analyse du sole'),
      ),
      body: ListView(
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
    );
  }
}

class SalesData {
  final String month;
  final int sales;

  SalesData(this.month, this.sales);
}
