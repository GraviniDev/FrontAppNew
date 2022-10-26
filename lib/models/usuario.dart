// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario(
      {this.nombre,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.curp,
      this.numeroCelular,
      this.estadoResidencia,
      this.imagenPerfil,
      this.fechaNacimiento,
      this.esEgresado,
      this.anioIngreso,
      this.campusVilla,
      this.correo,
      this.rol,
      this.estado,
      this.uid,
      this.conectado});

  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? curp;
  String? numeroCelular;
  String? estadoResidencia;
  String? imagenPerfil;
  DateTime? fechaNacimiento;
  bool? esEgresado;
  int? anioIngreso;
  String? campusVilla;
  String? correo;
  int? rol;
  bool? estado;
  String? uid;
  bool? conectado = false;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      nombre: json["nombre"],
      apellidoPaterno: json["apellidoPaterno"],
      apellidoMaterno: json["apellidoMaterno"],
      curp: json["curp"],
      numeroCelular: json["numeroCelular"],
      estadoResidencia: json["estadoResidencia"],
      imagenPerfil: json["img"],
      fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
      esEgresado: json["esEgresado"],
      anioIngreso: json["anioIngreso"],
      campusVilla: json["campusVilla"],
      correo: json["correo"],
      rol: json["rol"],
      estado: json["estado"],
      uid: json["uid"]);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "curp": curp,
        "numeroCelular": numeroCelular,
        "estadoResidencia": estadoResidencia,
        "img": "imagenPerfil",
        "fechaNacimiento": fechaNacimiento!.toIso8601String(),
        "esEgresado": esEgresado,
        "anioIngreso": anioIngreso,
        "campusVilla": campusVilla,
        "correo": correo,
        "rol": rol,
        "estado": estado,
        "uid": uid,
      };

  Map<String, dynamic> toJsonBD(Map<String, Object> usuarioBD) => {
        "nombre": usuarioBD['nombre'],
        "apellidoPaterno": usuarioBD['apellidoPaterno'],
        "apellidoMaterno": usuarioBD['apellidoMaterno'],
        "curp": usuarioBD['curp'],
        "numeroCelular": usuarioBD['numeroCelular'],
        "estadoResidencia": usuarioBD['estadoResidencia'],
        //AQUI VA LA IMAGENPARA GUARDAR EN BD
        "fechaNacimiento": usuarioBD['fechaNacimiento'],
        "esEgresado": usuarioBD['esEgresado'],
        "anioIngreso": usuarioBD['anioIngreso'],
        "campusVilla": usuarioBD['campusVilla'],
        "correo": usuarioBD['correo'],
        "rol": usuarioBD['rol'],
        "estado": usuarioBD['estado'],
        "uid": usuarioBD['uid'],
      };

  factory Usuario.fromJsonBD(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        curp: json["curp"],
        numeroCelular: json["numeroCelular"],
        estadoResidencia: json["estadoResidencia"],
        imagenPerfil: json["imagenPerfil"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        esEgresado: json["esEgresado"].toLowerCase() == 'true' ? true : false,
        anioIngreso: int.parse(json["anioIngreso"]),
        campusVilla: json["campusVilla"],
        correo: json["correo"],
        rol: int.parse(json["rol"]),
        estado: json["estado"].toLowerCase() == 'true' ? true : false,
        uid: json["uid"],
      );
}
