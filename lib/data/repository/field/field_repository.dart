import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:greenmind/data/models/field_model/field_model.dart';
import 'package:http/http.dart' as http;

import 'base_field_repository.dart';


class FieldRepository extends BaseFieldRepository{
final String key = dotenv.env['API_KEY']!;

  @override
  Future<FieldCreated> createdNewField(String name, String year, String sowingDate, String cropType, List<List<double>> coordinates) async {
    final String url = "${dotenv.env['HOST']!}api/cz/backend/api/field?api_key=$key";
    var headers = {
    'Content-Type': 'application/json',
    };

    var body = jsonEncode({
    "type": "Feature",
    "properties": {
      "name": name,
      "years_data": [
        {
          "crop_type": cropType,
          "year": year,
          "sowing_date": sowingDate
        }
      ]
    },
    "geometry": {
      "type": "Polygon",
      "coordinates": [
        
          coordinates
        
      ]
    }
  });
  print("voici mes coordonnées");
  print(coordinates);
    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    var json = convert.jsonDecode(response.body);
    print("voici résult");
    print(json);
    print("voici mon deuxième résultat");
    return FieldCreated.fromJson(json);
  }
}