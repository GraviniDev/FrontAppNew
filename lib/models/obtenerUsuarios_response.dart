// To parse this JSON data, do
//
//     final obtenerUsuariosResponse = obtenerUsuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:gravini/models/usuario.dart';

ObtenerUsuariosResponse obtenerUsuariosResponseFromJson(String str) =>
    ObtenerUsuariosResponse.fromJson(json.decode(str));

String obtenerUsuariosResponseToJson(ObtenerUsuariosResponse data) =>
    json.encode(data.toJson());

class ObtenerUsuariosResponse {
  ObtenerUsuariosResponse({
    this.code,
    this.data,
    this.error,
  });

  int? code;
  List<Usuario>? data;
  String? error;

  factory ObtenerUsuariosResponse.fromJson(Map<String, dynamic> json) =>
      ObtenerUsuariosResponse(
        code: json["code"],
        data: json["code"] == 0
            ? List<Usuario>.from(json["data"].map((x) => Usuario.fromJson(x)))
            : null,
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}
