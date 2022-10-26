import 'dart:io';

class DatosRegistro {
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
  bool? aviso;
  bool? reclamento;
  String? confPass;
  String? imagenPerfil;
  DatosRegistro(
      {this.nombre,
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
      this.aviso,
      this.reclamento,
      this.confPass,
      this.imagenPerfil});
}
