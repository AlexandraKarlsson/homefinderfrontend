import 'apartment.dart';

class Apartments {
  List<Apartment> apartments = [];

  Apartments() {
    // addTestData();
  }
/*
  final int id;
  final String address;
  final String description;
  final double livingSpace;
  final double rooms;
  final int built;
  final int price;
  final int operationCost;
  final String image;
  final List<String> images;
   */
  void add(Map<String, dynamic> apartmentMap) {
    apartmentMap['rows'].forEach((apartment) {
      int id = apartment['id'];
      String address = apartment['address'];
      String description = apartment['description'];
      int livingSpace = apartment['livingspace'];
      double rooms = apartment['rooms'].toDouble();
      int built = apartment['built'];
      int price = apartment['price'];
      int operationCost = apartment['operationcost'];
      String image = apartment['image'];
      List<String> images = apartment['images'];
      int apartmentNumber = apartment['apartmentnumber'];
      int charge = apartment['charge'];
      Apartment newApartment = Apartment(
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
          apartmentNumber,
          charge);
      apartments.add(newApartment);
    });
  }

  void setImage(Map<String, dynamic> imageMap) {
    imageMap['rows'].forEach((image) {
      int homeId = image['homeid'];
      String imageName = image['imagename'];
      for (int index = 0; index < apartments.length; index++) {
        if (apartments[index].id == homeId) {
          apartments[index].image = imageName;
        }
      }
    });
  }

  void addTestData() {
    Apartment apartment = Apartment(
      1,
      'Surbrunnsgatan 24',
      'Fyra trappor upp i fastigheten finner du denna väldisponerade trea på eftertraktad adress med härlig balkong mot gård! Detta trivsamma boende har en genomgående planlösning med två trevliga sovrum, ett vardagsrum med en vacker fungerande kakelugn och ett fullt utrustat kök. Mycket fina bevarade detaljer såsom väl tilltagen takhöjd, stuckaturer och speglade dörrar. Här bor du i en välskött förening med låg avgift och garage i huset. Ett utmärkt läge med närhet till grönområden och ett stort utbud av service, restauranger och caféer. Flertalet innerstadsbussar finner du ett stenkast bort och tunnelbana finns inom gångavstånd.',
      68.0,
      3.0,
      1907,
      5275000,
      350,
      'apartment-1_1.jpg',
      ['apartment-1_1.jpg', 'apartment-1_2.jpg', 'apartment-1_3.jpg'],
      1401,
      1133,
    );

    apartments.add(apartment);

    apartment = Apartment(
      2,
      'Birger Jarlsgatan 102 B',
      'Nu finns chans att förvärva denna fantastiska och unika vindslägenhet om 74 kvm + 17 kvm biyta, högst upp i huset. Charmig tvåa utöver det vanliga med synliga takbjälkar och snedtak som möter noga utvalda moderna materialval och interiörer gör detta till en lägenhet med rätt vindskaraktär. Kök med hög maskinell och materiell standard inrett med härlig modern känsla, helkaklat duschrum med lyxuösa interiörer och regndusch samt bekvämligheter som tvättmaskin. Rofyllt separat sovrum med fönster med utsikt ut över takåsarna och delvis öppen planlösning mellan kök och vardagsrum ger fint samspel mellan rummen. Ett praktiskt sovloft som du enkelt tar dig upp till via stegen från vardagsrummet. Utanför porten finner du det mesta som Vasastan/Östermalm har att erbjuda som caféer, restauranger och shopping.',
      68.0,
      2.5,
      1905,
      6250000,
      500,
      'apartment-2_1.jpg',
      ['apartment-2_1.jpg' /*, 'apartment-2_2.jpg', 'apartment-2_3.jpg'*/],
      1402,
      1586,
    );

    apartments.add(apartment);

    apartment = Apartment(
      3,
      'Birger Jarlsgatan 83',
      'Varmt välkomna till denna fantastiska sekelskiftesbostad om 163 kvm i fastighet uppförd 1918. Denna hörnlägenhet präglas av tidstypiska detaljer så som stuckatur, flera burspråk, generös takhöjd, fönster med spröjs och originaldetaljer, en öppen spis och en kakelugn som båda fungerar. Rymlig entré med öppen spis och tidsenlig bröstpanel och vidare kommer man till den stora matsalen med plats för stora sällskap och ett härligt burspråk mot Surbrunnsgatan. Bakom skjutdörrar ligger ett vardagsrum med stora fönster och plats för soffgrupp. Arbetskök med luckor i fin grön färg och med balkong mot innergården. Stort sovrum med garderobsvägg och ingång till badrum med hörnbadkar och mindre ett mindre sovrum intill köket. Allrummet intill vardagsrummet kan med fördel användas som sovrum. Badrum med hörnbadkar, fräscht duschrum och gäst-wc. För den som önskar finns mycket goda möjligheter att disponera om rummen så att den passar just er.',
      163.0,
      5.0,
      1918,
      12000000,
      1000,
      'apartment-3_1.jpg',
      ['apartment-3_1.jpg' /*, 'apartment-3_2.jpg', 'apartment-3_3.jpg'*/],
      1301,
      8040,
    );

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
  final double rooms;
  final int built;
  final int price;
  final int operationCost;
  final int apartmentNumber;
  final int charge;
  final String image;
  final String images;

 */
