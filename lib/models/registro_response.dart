// To parse this JSON data, do
//
//     final registroResponse = registroResponseFromJson(jsonString);

import 'dart:convert';

RegistroResponse registroResponseFromJson(String str) =>
    RegistroResponse.fromJson(json.decode(str));

String registroResponseToJson(RegistroResponse data) =>
    json.encode(data.toJson());

class RegistroResponse {
  RegistroResponse({
    required this.code,
    required this.data,
    required this.error,
  });

  int code;
  Data data;
  Error error;

  factory RegistroResponse.fromJson(Map<String, dynamic> json) =>
      RegistroResponse(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        error: Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "error": error.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}

class Error {
  Error({
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.curp,
    this.username,
    this.numeroCelular,
    this.estadoResidencia,
    this.fechaNacimiento,
    this.esEgresado,
    this.anioIngreso,
    this.campusVilla,
    this.correo,
    this.password,
    this.rol,
    this.estado,
  });

  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? curp;
  String? username;
  String? numeroCelular;
  String? estadoResidencia;
  DateTime? fechaNacimiento;
  bool? esEgresado;
  int? anioIngreso;
  String? campusVilla;
  String? correo;
  String? password;
  int? rol;
  bool? estado;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        curp: json["curp"],
        username: json["username"],
        numeroCelular: json["numeroCelular"],
        estadoResidencia: json["estadoResidencia"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        esEgresado: json["esEgresado"],
        anioIngreso: json["anioIngreso"],
        campusVilla: json["campusVilla"],
        correo: json["correo"],
        password: json["password"],
        rol: json["rol"],
        estado: json["estado"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "curp": curp,
        "username": username,
        "numeroCelular": numeroCelular,
        "estadoResidencia": estadoResidencia,
        "fechaNacimiento": fechaNacimiento.toString(),
        "esEgresado": esEgresado,
        "anioIngreso": anioIngreso,
        "campusVilla": campusVilla,
        "correo": correo,
        "password": password,
        "rol": rol,
        "estado": estado,
      };
}
