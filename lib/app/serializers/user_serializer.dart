/*
  ! Contoh data yang diambil
{
    "message": "Berhasil update user",
    "statusCode": 200,
    "data": {
        "id": 49,
        "first_name": "Burian",
        "last_name": "Bask",
        "username": "buba",
        "email": "buba@gmail.com"
    }
}

*/

class Data {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;

  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class UserSerializer {
  final String? message;
  final int? statusCode;
  final dynamic data;

  UserSerializer({this.message, this.statusCode, this.data});

  factory UserSerializer.fromJson(Map<String, dynamic> json) {
    if (json['data'] is List) {
      return UserSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: json['data'].map((e) => Data.fromJson(e)).toList(),
      );
    } else {
      return UserSerializer(
        message: json['message'],
        statusCode: json['statusCode'],
        data: Data.fromJson(json['data']),
      );
    }
  }
}
