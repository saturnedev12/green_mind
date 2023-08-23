// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);


class User {
    String destination;
    
    static User singleton = User._internal(
        destination: '',
       
      );

  factory User() {
    return singleton;
  }
    User._internal({
         required this.destination,
    });


    factory User.fromJson(Map<String, dynamic> json) {
        singleton = User._internal(
        destination: json["destination"]
       );
       return singleton;
    }
  
    

   
}
