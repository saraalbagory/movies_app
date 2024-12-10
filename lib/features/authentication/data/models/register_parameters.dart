class RegisterParameters {
  RegisterParameters(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.phone});
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  RegisterParameters.fromJson(Map<String, dynamic> json)
      : this(
            email: json['email'],
            password: json['password'],
            name: json['name'],
            confirmPassword: json['confirm password'],
            phone: json['phone']);
            
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "confirm paswword": confirmPassword,
      "phone": phone
    };
  }
}
