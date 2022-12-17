// To parse this JSON data, do
//
//     final publiacaciones = publiacacionesFromJson(jsonString);

import 'dart:convert';

Publiacaciones publiacacionesFromJson(String str) =>
    Publiacaciones.fromJson(json.decode(str));

String publiacacionesToJson(Publiacaciones data) => json.encode(data.toJson());

class Publiacaciones {
  Publiacaciones({
    this.code,
    this.data,
    this.error,
  });

  int? code;
  List<Publicacion>? data;
  String? error;

  factory Publiacaciones.fromJson(Map<String, dynamic> json) => Publiacaciones(
        code: json["code"],
        data: List<Publicacion>.from(
            json["data"].map((x) => Publicacion.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Publicacion {
  Publicacion({
    this.body,
    this.estatus,
    this.creadoEn,
    this.autor,
    this.id,
  });

  String? body;
  bool? estatus;
  String? creadoEn;
  String? autor;
  String? id;

  factory Publicacion.fromJson(Map<String, dynamic> json) => Publicacion(
        body: json["body"],
        estatus: json["estatus"],
        creadoEn: json["creadoEn"],
        autor: json["autor"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "estatus": estatus,
        "creadoEn": creadoEn,
        "autor": autor,
        "id": id,
      };
}
