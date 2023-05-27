
class SignUpRequest {
  String? email;
  String? password;

  SignUpRequest({this.email, this.password});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

  Map performRequest(){
    final Map signUpRequest={
      'email':email.toString(),
      'password':password.toString()
    };
    return signUpRequest;
  }
}