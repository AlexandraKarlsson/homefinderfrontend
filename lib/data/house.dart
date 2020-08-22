import 'home.dart';

class House extends Home {
  final String cadastral;
  final String structure;
  final int plotSize;
  final String ground;

  House(
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
    this.cadastral,
    this.structure,
    this.plotSize,
    this.ground,
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
          saleId,
        );
}
