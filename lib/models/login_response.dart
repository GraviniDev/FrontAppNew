// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:gravini/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.respuesta,
  });

  Respuesta? respuesta;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        respuesta: Respuesta.fromJson(json["respuesta"]),
      );

  Map<String, dynamic> toJson() => {
        "respuesta": respuesta!.toJson(),
      };
}

class Respuesta {
  Respuesta({
    this.code,
    this.data,
    this.error,
  });

  int? code;
  Data? data;
  String? error;

  factory Respuesta.fromJson(Map<String, dynamic> json) {
    if (json["code"] == 0) {
      return Respuesta(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        error: json["error"],
      );
    } else {
      return Respuesta(
        code: json["code"],
        error: json["error"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data!.toJson(),
        "error": error,
      };
}

class Data {
  Data({
    this.user,
    this.token,
  });

  Usuario? user;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: Usuario.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "token": token,
      };
}

// class User {
//   User({
//     this.nombre,
//     this.apellidoPaterno,
//     this.apellidoMaterno,
//     this.curp,
//     this.username,
//     this.numeroCelular,
//     this.estadoResidencia,
//     this.fechaNacimiento,
//     this.esEgresado,
//     this.anioIngreso,
//     this.campusVilla,
//     this.correo,
//     this.rol,
//     this.estado,
//     this.uid,
//   });

//   String? nombre;
//   String? apellidoPaterno;
//   String? apellidoMaterno;
//   String? curp;
//   String? username;
//   String? numeroCelular;
//   String? estadoResidencia;
//   DateTime? fechaNacimiento;
//   bool? esEgresado;
//   int? anioIngreso;
//   String? campusVilla;
//   String? correo;
//   int? rol;
//   bool? estado;
//   String? uid;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         nombre: json["nombre"],
//         apellidoPaterno: json["apellidoPaterno"],
//         apellidoMaterno: json["apellidoMaterno"],
//         curp: json["curp"],
//         username: json["username"],
//         numeroCelular: json["numeroCelular"],
//         estadoResidencia: json["estadoResidencia"],
//         fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
//         esEgresado: json["esEgresado"],
//         anioIngreso: json["anioIngreso"],
//         campusVilla: json["campusVilla"],
//         correo: json["correo"],
//         rol: json["rol"],
//         estado: json["estado"],
//         uid: json["uid"],
//       );

//   Map<String, dynamic> toJson() => {
//         "nombre": nombre,
//         "apellidoPaterno": apellidoPaterno,
//         "apellidoMaterno": apellidoMaterno,
//         "curp": curp,
//         "username": username,
//         "numeroCelular": numeroCelular,
//         "estadoResidencia": estadoResidencia,
//         "fechaNacimiento": fechaNacimiento!.toIso8601String(),
//         "esEgresado": esEgresado,
//         "anioIngreso": anioIngreso,
//         "campusVilla": campusVilla,
//         "correo": correo,
//         "rol": rol,
//         "estado": estado,
//         "uid": uid,
//       };
// }
