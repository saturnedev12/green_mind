import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenmind/configs/constants.dart';
import 'package:greenmind/data/models/weather_data_agregation_model.dart';

class WeatherDetailPage extends StatefulWidget {
  const WeatherDetailPage(
      {super.key, required this.weatherDataAgregationModel});
  final WeatherDataAgregationModel weatherDataAgregationModel;

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  late List<Map<String, dynamic>> dataRainsHours = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.weatherDataAgregationModel.rain.toMap().forEach((key, value) {
      dataRainsHours.add({
        'hour': key,
        'value': value,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex("#7F9BA6"),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://wallpaperaccess.com/full/701617.jpg'), // Chemin de votre image
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                'Terrain',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('25˚',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    )),
              ),
              //Text('Nuage predominant'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TemperatureMaxMin(
                    degre:
                        "${widget.weatherDataAgregationModel.tempAirMax.toInt()}˚",
                    icon: Icons.arrow_upward,
                  ),
                  TemperatureMaxMin(
                    degre:
                        '${widget.weatherDataAgregationModel.tempAirMin.toInt()}˚',
                    icon: Icons.arrow_downward_outlined,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WeatherHourBox(
                  dataRainsHours: dataRainsHours,
                ),
              ),
              SizedBox(
                width: 500,
                height: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: WeatherDaysBox(),
                    ),
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        child: GridView.count(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          cacheExtent: 200,
                          padding: EdgeInsets.only(left: 10),
                          crossAxisCount:
                              2, // Nombre de colonnes dans la grille
                          childAspectRatio:
                              1.2, // Ratio hauteur / largeur pour chaque cellule
                          children: <Widget>[
                            for (int i = 0; i < 8; i++) WindCard(),
                            // Ajoutez ici d'autres widgets pour représenter les cellules suivantes
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class TemperatureMaxMin extends StatelessWidget {
  const TemperatureMaxMin({super.key, required this.degre, this.icon});
  final String degre;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          (icon != null)
              ? Icon(
                  icon,
                  size: 14,
                  color: Colors.white,
                )
              : SizedBox(),
          Text(
            degre,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class WeatherHourBox extends StatelessWidget {
  const WeatherHourBox({super.key, required this.dataRainsHours});
  final List<Map<String, dynamic>> dataRainsHours;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 100,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: CupertinoColors.systemFill.darkColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: dataRainsHours
            .map((e) => SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        e['hour'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.cloud_drizzle_fill,
                        color: Colors.white,
                      ),
                      TemperatureMaxMin(
                          degre: '${((e['value'] as double) * 100).toInt()}%')
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class WeatherDaysBox extends StatelessWidget {
  const WeatherDaysBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      width: 250,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemFill.darkColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.separated(
        itemBuilder: (context, index) => (index == 0)
            ? Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.calendar,
                      color: Colors.white38,
                      size: 16,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'PREVISION SUR 10 JOURS',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white38,
                    ),
                  )
                ],
              )
            : CupertinoListTile(
                padding: EdgeInsets.all(0),
                title: Text(
                  (index > 3) ? 'Mardi' : 'Aujourd\'hui',
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),
                leading: Icon(
                  CupertinoIcons.cloud_hail_fill,
                  color: CupertinoColors.white,
                ),
                additionalInfo: Row(
                  children: [
                    Icon(
                      Icons.arrow_downward_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                    Text(
                      "25˚",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.opaqueSeparator.darkColor,
                      ),
                    ),
                  ],
                ),
                trailing: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                    Text(
                      "30˚",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ],
                ),
              ),
        separatorBuilder: (context, index) => Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.white,
        ),
        itemCount: 7,
      ),
    );
  }
}

class WindCard extends StatelessWidget {
  const WindCard({
    super.key,
    // required this.icon,
    // required this.title,
    // required this.data,
  });
  // final IconData icon;
  // final String title;
  // final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CupertinoColors.systemFill.darkColor,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    CupertinoIcons.wind,
                    color: CupertinoColors.white,
                  ),
                  Text(
                    'Vent',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '24%',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            )
          ]),
    );
  }
}
