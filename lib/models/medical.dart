import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pry20220116/models/especialidad.dart';

class Medical {
  final int? codigoDistrito;
  final String? direccion;
  final int? dniMedico;
  final int? edad;
  final String? email;
  final int? especialidadCodigo;
  Especialidad? especialidad;
  final String? imagen;
  final String? nombre;
  final int? numero;
  final int? tiempoTrabajado;

  set setEspecialidad(Especialidad especialidad) {
    this.especialidad = especialidad;
  }

  Medical(
      {this.codigoDistrito,
      this.direccion,
      this.dniMedico,
      this.edad,
      this.email,
      this.especialidadCodigo,
      this.imagen,
      this.nombre,
      this.numero,
      this.tiempoTrabajado});

  factory Medical.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Medical(
      codigoDistrito: data?['codigo_distrito'],
      direccion: data?['direccion'],
      dniMedico: data?['dni_medico'],
      edad: data?['edad'],
      email: data?['email'],
      especialidadCodigo: data?['especialidad_codigo'],
      imagen: data?['imagen'],
      nombre: data?['nombre'],
      numero: data?['numero'],
      tiempoTrabajado: data?['tiempo_trabajado'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (codigoDistrito != null) "codigo_distrito": codigoDistrito,
      if (direccion != null) "direccion": direccion,
      if (dniMedico != null) "dni_medico": dniMedico,
      if (edad != null) "edad": edad,
      if (email != null) "email": email,
      if (especialidadCodigo != null) "especialidad_codigo": especialidadCodigo,
      if (imagen != null) "imagen": imagen,
      if (nombre != null) "nombre": nombre,
      if (numero != null) "numero": numero,
      if (tiempoTrabajado != null) "tiempo_trabajado": tiempoTrabajado,
    };
  }
}
