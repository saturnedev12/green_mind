part of maplib;

class ScrollableSheetInfo extends StatelessWidget {
  ScrollableSheetInfo(
      {super.key,
      required this.markers,
      required this.perimetre,
      required this.surface});
  final List<Marker> markers;
  final num perimetre;
  final num surface;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => Container(
        child: ListView(
          controller: scrollController,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 5, top: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            CupertinoListSection(children: [
              CupertinoListTile(
                leading: Icon(Icons.square_foot_sharp),
                title: Text('Surface:'),
                trailing: Text(MapDisplayFunction(context: context)
                    .convertSurface(surface)),
              ),
              CupertinoListTile(
                leading: Icon(Icons.square_foot_sharp),
                title: Text('Périmètre:'),
                trailing: Text(MapDisplayFunction(context: context)
                    .convertDistance(perimetre)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.polyline_outlined),
                    label: const Text('Polygonale'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.save_alt_rounded),
                    label: const Text('Enregistrer'),
                  ),
                  // TextButton.icon(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => Container(),
                  //         ));
                  //   },
                  //   icon: const Icon(Icons.science_outlined),
                  //   label: const Text('Analyser'),
                  // ),
                ],
              ),
            ]),
            DataTable(
              columns: [
                DataColumn(label: Text('Bornes')),
                DataColumn(
                  label: Text('X'),
                ),
                DataColumn(label: Text('Y')),
                // DataColumn(label: Text('ANOLES')),
                // DataColumn(label: Text('DISTANCES')),
              ],
              rows: markers
                  .map<DataRow>((e) => DataRow(
                        color: MaterialStateProperty.all(Colors.grey[300]),
                        cells: [
                          DataCell(Text(e.infoWindow.title ?? 'KO')),
                          DataCell(Text(UTM
                              .fromLatLon(
                                  lat: e.position.latitude,
                                  lon: e.position.longitude)
                              .easting
                              .toStringAsFixed(3))),
                          DataCell(Text(UTM
                              .fromLatLon(
                                  lat: e.position.latitude,
                                  lon: e.position.longitude)
                              .northing
                              .toStringAsFixed(3))),
                          // DataCell(Text('')),
                          // DataCell(Text('')),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
