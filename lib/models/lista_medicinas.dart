class Medicine{
  String name;
  String icon;

  Medicine(
      this.name,
      this.icon,
      );

  static List<Medicine> generateMedicine(){
    return[
      Medicine('Paracetamol','assets/image/paracetamol.png'),
      Medicine('Panadol','assets/image/panadol.png'),
      Medicine('Aspirina','assets/image/aspirina.png'),
      Medicine('Ibuprofeno','assets/image/ibuprofeno.png')
    ];
  }

}