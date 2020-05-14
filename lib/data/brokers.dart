import 'broker.dart';

class Brokers {
  Map<int,Broker> brokers = Map<int,Broker>();


void add(Map<String, dynamic> brokerMap) {
    brokerMap['rows'].forEach((broker) {
      int id = broker['id'];
      String name = broker['name'];
      String phone = broker['phone'];
      String email = broker['email'];

      Broker newBroker = Broker(
        id,
        name,
        phone,
        email,
      );
      brokers[newBroker.id] = newBroker;
    });
  }

  void addIfNotExists(Broker broker) {
    if(brokers[broker.id] == null) {
      brokers[broker.id] = broker;
    }
  }
  
}