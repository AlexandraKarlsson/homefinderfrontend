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

import 'home.dart';

class Apartment extends Home {
  final int apartmentNumber;
  final int charge;

  Apartment(
    id,
    address,
    description,
    livingSpace,
    rooms,
    built,
    price,
    operationCost,
    image,
    images,
    this.apartmentNumber,
    this.charge,
  ) : super(
          id,
          address,
          description,
          livingSpace,
          rooms,
          built,
          price,
          operationCost,
          image,
          images,
        );
  
  static String formatCharge(int charge) {
    return charge as String;
  }
}
