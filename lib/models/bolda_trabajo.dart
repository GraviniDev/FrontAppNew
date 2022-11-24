import 'dart:convert';

List<Bolsa> bolsaFromJson(String str) => List<Bolsa>.from(
    json.decode(str).map((x) => x == null ? null : Bolsa.fromJson(x)));

String bolsaToJson(List<Bolsa> data) => json
    .encode(List<dynamic>.from(data.map((x) => x == null ? null : x.toJson())));

class Bolsa {
  Bolsa({
    this.detalle,
    this.empresa,
    this.id,
    this.lugar,
    this.monto,
    this.tiempo,
    this.titulo,
  });

  String? detalle;
  String? empresa;
  int? id;
  String? lugar;
  String? monto;
  String? tiempo;
  String? titulo;

  factory Bolsa.fromJson(Map<String, dynamic> json) => Bolsa(
        detalle: json["Detalle"],
        empresa: json["Empresa"],
        id: json["Id"],
        lugar: json["Lugar"],
        monto: json["Monto"],
        tiempo: json["Tiempo"],
        titulo: json["Titulo"],
      );

  Map<String, dynamic> toJson() => {
        "Detalle": detalle,
        "Empresa": empresa,
        "Id": id,
        "Lugar": lugar,
        "Monto": monto,
        "Tiempo": tiempo,
        "Titulo": titulo,
      };
}
