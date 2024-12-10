class UserDataModel {
  String? name;
  String? email;
  String? id;
  String? phone;
  UserDataModel({
    this.id,this.name,
    this.email,
    this.phone
  });
  UserDataModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          name: json['name'],
          phone: json['phone']
        );

  Map<String, dynamic> toJson() {
    return {'id': id,'name': name, 'email': email,'phone':phone};
  }
}