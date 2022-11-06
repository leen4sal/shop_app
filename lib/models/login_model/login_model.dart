class LoginModel {
  bool status;
  String message;
  UserModel data;

  LoginModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null? UserModel.fromJson(json['data']) : null;
  }

}


class UserModel{
  String id;
  String name;
  String email;
  String image;
  String phone;
  int points;
  int credit;
  String token;
  UserModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'].toString();
    name=json['name'];
    email=json['email'];
    phone=json['phone'].toString();
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}