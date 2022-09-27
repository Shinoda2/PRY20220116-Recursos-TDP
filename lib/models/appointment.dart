class Appointment{
  String name;
  String icon;
  String especialidad;
  String diagnostico;

  Appointment(
      this.name,
      this.icon,
      this.especialidad,
      this.diagnostico
      );

  static List<Appointment> enCurso(){
    return[
      Appointment('Medico 1','assets/image/icon.png','Especialidad: Dermatología','No hay diagnostico'),
    ];
  }
  static List<Appointment> proxima(){
    return[
      Appointment('Medico 2','assets/image/icon.png','Especialidad: Neurología','No hay diagnostico'),
    ];
  }
  static List<Appointment> pasadas(){
    return[
      Appointment('Medico 4','assets/image/icon.png','Especialidad: Pedriatía','No hay diagnostico'),
    ];
  }

}