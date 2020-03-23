import 'house.dart';

class Houses {
  List<House> houses = [];

  Houses() {
    House house = House (
      4,
      'Albano 357',
      'Denna charmiga 1940-talsvilla, som under senare år renoverats smakfullt, är belägen i utkanten av mindre bybildning nära Lunda kyrka och Arlanda. Stor härlig trädgårdstomt med gräsmatta, många äppelträd,, staket mm. På tomten finns även ett uthus med bl a vedbod. Högt läge med vy över grannhusen och öppna landskap. Närhet till ICA-butik (Lunda livs) samt busslinjer och bekvämt bilavstånd till affärscentra mm.',
      127.0,
      3.0,
      1947,
      3195000,
      33512,
      'apartment-1_1.jpg',
      ['apartment-1_1.jpg', 'apartment-1_2.jpg', 'apartment-1_3.jpg'],
      'Sigtuna Lunda-Mörby 5:19',
      'Villa 1.5 plan',
      3011,
      'Grundsula',
    );

    houses.add(house);
 
    house = House(
      5,
      'Oxdragarbacken 1',
      'Trevligt fritidshus med åretruntstandard beläget i populära Enviken. Trivsamt område med småbåtshamn, anlagd badplats, tennisbana, bastubollplan, bastu, 25-meters utomhuspool samt barnpool. Dessutom finns föreningslokal som går att hyra. Hus om 57 kvm som har renoverat kök och badrum, 2 sovrum och allrum med matplats i den inbyggda verandan. Altan under tak mellan huset och gäststugan. På tomten finns också förrådsbod och snickarbod. Plan tomt för lekar och spel som inramas av syrénhäck mot vägen och granhäck mot ena grannfastigheten. Här växer hallon, röda och svarta vinbär. Fiber framdraget till tomtgräns. Mer information om indragning kommer hösten 2016. Kommunalt VA installerat. SL-buss stannar ca 500 meter från huset, nr 620. Ca 3 km till skola, affär, post, pizzeria och vårdcentral i Bergshamra. Ca 2,5 mil till Norrtälje och ca 7 mil till Stockholm. Passande både som sommarnöje och åreruntbostad. Kanske första boendet som alternativ till lägenhet? För mer information om Enviken se hemsida; http://www.enviken.net Välkommen på visning!',
      57.0,
      3.0,
      1976,
      1375000,
      30750,
      'apartment-2_1.jpg',
      ['apartment-2_1.jpg' /*, 'apartment-2_2.jpg', 'apartment-2_3.jpg'*/],
      'Norrtälje Bergshamra 1:72',
      '1-planshus',
      1329,
      'Plintar',
    );

    houses.add(house);

    house = House(
      6,
      'nedergårdsvägen 2',
      'Välvårdat och sjönära fritidshus med åretruntstandard beläget på Rådmansö i Baltora ca 10 minuter från Norrtälje. Nära badplats och småbåtshamn i Saltsjön. Insjö på badrocksavstånd på andra sidan vägen. Här kan du bada och här finns inplanterad ädelfisk/regnbåge för dig som gillar att fiska. Härliga altaner på två sidor av huset. Insynsskyddad tomt och högt läge. Renoverat hus med 2 sovrum, duschrum och fina sällskapsytor. Kommunalt vatten och avlopp. Byggrätt 10% av tomtareal. Fiber framdraget till tomtgräns. Passande både som permanentboende och som sommarhus med hög standard. Kanske något för dig som söker första boendet som alternativ till lägenhet och bra pendlingsmöjligheter tiill Stockholm och Norrtälje. Mer information om området finns på www.baltora.se Baltora är ett populärt område med ca 150 fastigheter varav ca 25% är permanentboende. Baltora nås med bil på ca 1 timme från Stockholm och från Norrtälje på 10 minuter. SL-buss 631 stannar ca 1 km från huset. Närmaste livsmedelsbutik finns vid Vreta dit det är ca 4,5 km. Välkommen på visning!',
      54.0,
      3.0,
      1974,
      1995000,
      35646,
      'apartment-3_1.jpg',
      ['apartment-3_1.jpg' /*, 'apartment-3_2.jpg', 'apartment-3_3.jpg'*/],
      'Norrtälje Baltora 2:85',
      '1-planshus',
      2278,
      'Plintar',
    );

    houses.add(house);
  }
}

