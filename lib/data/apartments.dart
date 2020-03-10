import 'apartment.dart';

class Apartments {
  List<Apartment> apartments = [];

  Apartments() {
    Apartment apartment = Apartment(
    1,
    'Surbrunnsgatan 24',
    'Fyra trappor upp i fastigheten finner du denna väldisponerade trea på eftertraktad adress med härlig balkong mot gård! Detta trivsamma boende har en genomgående planlösning med två trevliga sovrum, ett vardagsrum med en vacker fungerande kakelugn och ett fullt utrustat kök. Mycket fina bevarade detaljer såsom väl tilltagen takhöjd, stuckaturer och speglade dörrar. Här bor du i en välskött förening med låg avgift och garage i huset. Ett utmärkt läge med närhet till grönområden och ett stort utbud av service, restauranger och caféer. Flertalet innerstadsbussar finner du ett stenkast bort och tunnelbana finns inom gångavstånd.',
    68.0,
    3,
    1907,
    5275000,
    350,
    1401,
    1133,
    'apartment-1_1.jpg',
    ['apartment-1_1.jpg','apartment-1_2.jpg','apartment-1_3.jpg']);

    apartments.add(apartment);
  }
}

/*
 "address": "Surbrunnsgatan 24",
    "description": "Fyra trappor upp i fastigheten finner du denna väldisponerade trea på eftertraktad adress med härlig balkong mot gård! Detta trivsamma boende har en genomgående planlösning med två trevliga sovrum, ett vardagsrum med en vacker fungerande kakelugn och ett fullt utrustat kök. Mycket fina bevarade detaljer såsom väl tilltagen takhöjd, stuckaturer och speglade dörrar. Här bor du i en välskött förening med låg avgift och garage i huset. Ett utmärkt läge med närhet till grönområden och ett stort utbud av service, restauranger och caféer. Flertalet innerstadsbussar finner du ett stenkast bort och tunnelbana finns inom gångavstånd.",
    "price": "5275000",
    "livingSpace": "68",
    "rooms": "3",
    "apartmentnumber": "1401",
    "built": "1907",
    "charge": "1133",
    "operationCost": "350"

    final int id;
  final String address;
  final String description;
  final double livingSpace;
  final int rooms;
  final int built;
  final int operationCost;
  final int apartmentNumber;
  final int charge;
  final String image;
  final String images;

 */