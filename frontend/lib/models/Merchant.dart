import 'package:kid_pay/config/merchants_registry.dart';
import 'package:web3dart/credentials.dart';

class Merchant {
  EthereumAddress address;
  String group;
  String name;
  String description;
  String logo;
  bool approved;

  Merchant({
    required this.address,
    required this.group,
    required this.name,
    required this.description,
    required this.logo,
    required this.approved,
  }){
    description = MerchantsRegistry.descriptions[description]!;
    logo = MerchantsRegistry.logos[logo]!;
  }
}