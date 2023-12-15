class FireBaseField {
  String? fieldname;
  bool? isPaid;
  List<dynamic>? polygone;

  FireBaseField({this.fieldname, this.isPaid, this.polygone});

  FireBaseField.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    isPaid = json['is_paid'];
    polygone = json['polygone']??'';
    /*if (json['polygone'] != null) {
      polygone = <PolygoneField>[];
      json['polygone'].forEach((v) {
        polygone!.add(new PolygoneField.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldname'] = this.fieldname;
    data['is_paid'] = this.isPaid;
    data['polygone'] = this.isPaid;

    return data;
  }
}

class PolygoneField {
  double? latitude;
  double? longitude;

  PolygoneField({this.latitude, this.longitude});

  PolygoneField.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
