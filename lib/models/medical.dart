class Medical{
  String name;
  String icon;
  String especialidad;

  Medical(
      this.name,
      this.icon,
      this.especialidad
      );

  static List<Medical> generateMedical(){
    return[
      Medical('Medico 1','assets/image/icon.png','Dermatología'),
      Medical('Medico 2','assets/image/icon.png','Neurología'),
      Medical('Medico 3','assets/image/icon.png','Oncología'),
      Medical('Medico 4','assets/image/icon.png','Pedriatía')
    ];
  }

}