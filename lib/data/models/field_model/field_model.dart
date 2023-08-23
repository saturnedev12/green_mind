// To parse this JSON data, do
//
//     final fieldCreated = fieldCreatedFromJson(jsonString);

import 'dart:convert';

FieldCreated fieldCreatedFromJson(String str) => FieldCreated.fromJson(json.decode(str));

String fieldCreatedToJson(FieldCreated data) => json.encode(data.toJson());

class FieldCreated {
    int id;
    String area;

    FieldCreated({
        required this.id,
        required this.area,
    });

    factory FieldCreated.fromJson(Map<String, dynamic> json) => FieldCreated(
        id: json["id"],
        area: json["area"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "area": area,
    };
}
