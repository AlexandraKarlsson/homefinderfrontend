/*
        id INT PRIMARY KEY AUTO_INCREMENT,
        address VARCHAR(100) NOT NULL,
        description VARCHAR(2000) NOT NULL,
        livingspace FLOAT NOT NULL,
        rooms INT NOT NULL,
        built INT NOT NULL,
        operationcost INT NOT NULL

        id INT PRIMARY KEY AUTO_INCREMENT,
        apartmentnumber INT NOT NULL,
        charge INT NOT NULL,
        homeid INT NOT NULL,
        CONSTRAINT fk_apartment_home FOREIGN KEY (homeid) REFERENCES home(id)

*/
class Apartment {
  final int id;
  final String address;
  final String description;
  final double livingSpace;
  final int rooms;
  final int built;
  final int price;
  final int operationCost;
  final int apartmentNumber;
  final int charge;
  final String image;
  final List<String> images;

  Apartment(
      this.id,
      this.address,
      this.description,
      this.livingSpace,
      this.rooms,
      this.built,
      this.price,
      this.operationCost,
      this.apartmentNumber,
      this.charge,
      this.image,
      this.images
  );

  String get formatPrice {
    return '';
  }
  
}
