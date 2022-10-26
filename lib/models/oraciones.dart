import 'dart:convert';

Map<String, Oraciones> oracionesFromJson(String str) =>
    Map.from(json.decode(str))
        .map((k, v) => MapEntry<String, Oraciones>(k, Oraciones.fromJson(v)));

String oracionesToJson(Map<String, Oraciones> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Oraciones {
  Oraciones({
    this.detalle,
    this.subtitulo,
    this.titulo,
    this.imagen,
  });

  String? detalle;
  String? subtitulo;
  String? titulo;
  String? imagen;

  factory Oraciones.fromJson(Map<String, dynamic> json) => Oraciones(
        detalle: json["Detalle"],
        subtitulo: json["Subtitulo"],
        titulo: json["Titulo"],
        imagen: json["imagen"],
      );

  Map<String, dynamic> toJson() => {
        "Detalle": detalle,
        "Subtitulo": subtitulo,
        "Titulo": titulo,
        "imagen": imagen,
      };
}
