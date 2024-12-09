class LoginParameters {
  const LoginParameters({required this.email, required this.password});
  final String email;
  final String password;
  LoginParameters.fromJson(Map<String, dynamic> json)
      : this(email: json['email'],password: json['password']);
  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
