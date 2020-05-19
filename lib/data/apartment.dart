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
    brokerId,
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
          brokerId,
        );
  
  static String formatCharge(int charge) {
    return charge as String;
  }
}
