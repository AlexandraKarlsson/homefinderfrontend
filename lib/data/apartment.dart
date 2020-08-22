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
    saleId,
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
          saleId
        );
  
  static String formatCharge(int charge) {
    return charge as String;
  }
}
