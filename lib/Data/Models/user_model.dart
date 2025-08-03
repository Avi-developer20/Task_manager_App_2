class UserModel{
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String mobile;
   String? photo;

   String get FullName {
     return "$firstName + " " + $lastName";
}


  UserModel({
  required this.id,
     required this.email,
     required this.firstName,
     required this.lastName,
     required this.mobile,
     this.photo

});
  UserModel.fromJson(Map<String, dynamic> JsonData){
     id = JsonData["_id"];
     email = JsonData["email"];
     firstName = JsonData['firstName'];
     lastName = JsonData["lastname"];
     mobile = JsonData["mobile"];
     photo = JsonData['photo'];
   }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'photo': photo,
    };
  }



}