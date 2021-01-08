//send the user inputs email and password for create request
class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    this.email,
    this.password,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };
    return map;
  }
}
// get server response token and login
class LoginResponseModel {
  final String token;
  final String error;
  LoginResponseModel({this.token, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}
//send the user text message to server
class AIRequestModel {
  String message;

  AIRequestModel({
    this.message,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'message': message.toString(),
    };
    return map;
  }
}
// get server responses
class AIResponseModel{
  final String id;
  final String text;
  final bool active;
  AIResponseModel({this.id, this.text,this.active});

  factory AIResponseModel.fromJson(Map<String, dynamic> json) {
    return AIResponseModel(
      text: json["text"] != null ? json["text"] : "",
    );
  }
}