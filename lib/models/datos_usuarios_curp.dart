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
  DataUser? data;
  String? error;

  factory MensajesResponse.fromJson(Map<String, dynamic> json) =>
      MensajesResponse(
        code: json["code"],
        data: DataUser.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data?.toJson(),
        "error": error,
      };
}

class DataUser {
  DataUser({
    this.id,
    this.matricula,
    this.nombreCompleto,
    this.hermanosOPapas,
    this.paterno,
    this.materno,
    this.nombre,
    this.apellidos,
    this.nivel,
    this.grado,
    this.genero,
    this.status,
    this.claveCiudadana,
    this.estadoCivil,
    this.fechaNacimiento,
    this.generacion,
    this.domicilio,
    this.ciudad,
    this.estado,
    this.nombretutor,
    this.lugarNacimiento,
    this.estadoNacimiento,
    this.fechaIngreso,
    this.alumnoAltainicial,
    this.alumnoAltafinal,
    this.alumnoAltaperiodo,
    this.idCampus,
  });

  String? id;
  String? matricula;
  String? nombreCompleto;
  String? hermanosOPapas;
  String? paterno;
  String? materno;
  String? nombre;
  String? apellidos;
  String? nivel;
  String? grado;
  String? genero;
  String? status;
  String? claveCiudadana;
  String? estadoCivil;
  String? fechaNacimiento;
  String? generacion;
  String? domicilio;
  String? ciudad;
  String? estado;
  String? nombretutor;
  String? lugarNacimiento;
  String? estadoNacimiento;
  String? fechaIngreso;
  String? alumnoAltainicial;
  String? alumnoAltafinal;
  String? alumnoAltaperiodo;
  String? idCampus;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["_id"],
        matricula: json["MATRICULA"],
        nombreCompleto: json["NOMBRE_COMPLETO"],
        hermanosOPapas: json["HERMANOS_O_PAPAS"],
        paterno: json["PATERNO"],
        materno: json["MATERNO"],
        nombre: json["NOMBRE"],
        apellidos: json["APELLIDOS"],
        nivel: json["NIVEL"],
        grado: json["GRADO"],
        genero: json["GENERO"],
        status: json["STATUS"],
        claveCiudadana: json["CLAVE_CIUDADANA"],
        estadoCivil: json["ESTADO_CIVIL"],
        fechaNacimiento: json["FECHA_NACIMIENTO"],
        generacion: json["GENERACION"],
        domicilio: json["DOMICILIO"],
        ciudad: json["CIUDAD"],
        estado: json["ESTADO"],
        nombretutor: json["NOMBRETUTOR"],
        lugarNacimiento: json["LUGAR_NACIMIENTO"],
        estadoNacimiento: json["ESTADO_NACIMIENTO"],
        fechaIngreso: json["FECHA_INGRESO"],
        alumnoAltainicial: json["ALUMNO_ALTAINICIAL"],
        alumnoAltafinal: json["ALUMNO_ALTAFINAL"],
        alumnoAltaperiodo: json["ALUMNO_ALTAPERIODO"],
        idCampus: json["ID_CAMPUS"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "MATRICULA": matricula,
        "NOMBRE_COMPLETO": nombreCompleto,
        "HERMANOS_O_PAPAS": hermanosOPapas,
        "PATERNO": paterno,
        "MATERNO": materno,
        "NOMBRE": nombre,
        "APELLIDOS": apellidos,
        "NIVEL": nivel,
        "GRADO": grado,
        "GENERO": genero,
        "STATUS": status,
        "CLAVE_CIUDADANA": claveCiudadana,
        "ESTADO_CIVIL": estadoCivil,
        "FECHA_NACIMIENTO": fechaNacimiento,
        "GENERACION": generacion,
        "DOMICILIO": domicilio,
        "CIUDAD": ciudad,
        "ESTADO": estado,
        "NOMBRETUTOR": nombretutor,
        "LUGAR_NACIMIENTO": lugarNacimiento,
        "ESTADO_NACIMIENTO": estadoNacimiento,
        "FECHA_INGRESO": fechaIngreso,
        "ALUMNO_ALTAINICIAL": alumnoAltainicial,
        "ALUMNO_ALTAFINAL": alumnoAltafinal,
        "ALUMNO_ALTAPERIODO": alumnoAltaperiodo,
        "ID_CAMPUS": idCampus,
      };
}
