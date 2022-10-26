// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) =>
    MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) =>
    json.encode(data.toJson());

class MensajesResponse {
  MensajesResponse({
    this.code,
    this.data,
    this.error,
  });

  int? code;
  List<Datum>? data;
  String? error;

  factory MensajesResponse.fromJson(Map<String, dynamic> json) =>
      MensajesResponse(
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  Datum({
    this.id,
    this.de,
    this.para,
    this.mensaje,
    this.estatus,
    this.creadoEn,
    this.v,
  });

  String? id;
  String? de;
  String? para;
  String? mensaje;
  bool? estatus;
  String? creadoEn;
  int? v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        estatus: json["estatus"],
        creadoEn: json["creadoEn"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "estatus": estatus,
        "creadoEn": creadoEn,
        "__v": v,
      };
}
