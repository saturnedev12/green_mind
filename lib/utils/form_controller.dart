import 'package:flutter/cupertino.dart';

class FormController {
  int productId;
  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? email;
  TextEditingController? phoneNumber;
  TextEditingController? password;
  TextEditingController? cityName;
  TextEditingController? startWishedDate;
  TextEditingController? endWishedDate;
  TextEditingController? coupon;
  TextEditingController? payementType;
  TextEditingController? note;
  TextEditingController? placeLoading;
  TextEditingController? placeUnloading;
  TextEditingController? address;
  TextEditingController? address2;
  TextEditingController? paymentType;
  String? serviceOption;
  int? city;
  void set setServiceOption(String service) {
    serviceOption = service;
  }

  FormController({
    required this.productId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.cityName,
    this.coupon,
    this.endWishedDate,
    this.startWishedDate,
    this.payementType,
    this.note,
    this.placeLoading,
    this.placeUnloading,
    this.address,
    this.address2,
    this.serviceOption,
    this.city,
  });
  set setCityCode(int cit) => this.city = cit;

  Map<String, dynamic> toJsonForOrder() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['service_option'] = this.serviceOption;
    data['note'] = (note != null) ? this.note!.text : '';
    data['customer_last_name'] = (lastName != null) ? this.lastName!.text : '';
    data['customer_first_name'] =
        (firstName != null) ? this.firstName!.text : '';
    data['first_name'] = (firstName != null) ? this.firstName!.text : '';
    data['last_name'] = (lastName != null) ? this.lastName!.text : '';
    data['email'] = (email != null) ? this.email!.text : '';
    data['customer_phone_number'] =
        (phoneNumber != null) ? this.phoneNumber!.text : '';
    data['phone_number'] = (phoneNumber != null) ? this.phoneNumber!.text : '';
    //data['password'] = (password != null) ? this.password!.text : '';
    data['customer_email'] = (email != null) ? this.email!.text : '';
    data['username'] = (email != null) ? this.email!.text : '';
    data['customer_country_id'] = (cityName != null) ? this.cityName!.text : '';
    data['customer_state_id'] = (cityName != null) ? this.cityName!.text : '';
    data['customer_city_id'] = (cityName != null) ? this.cityName!.text : '';
    data['customer_address'] = (address != null) ? this.address!.text : '';
    data['customer_address_2'] = (address2 != null) ? this.address2!.text : '';
    data['payment_type'] =
        (this.payementType != null) ? this.payementType!.text : '';
    data['password'] = (this.password != null) ? this.password!.text : '';
    data['city'] = this.city;
    return data;
  }
}
