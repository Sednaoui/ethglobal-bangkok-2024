import 'package:kid_pay/contracts/bindings/KidsMerchantRegistry.g.dart';
import 'package:kid_pay/contracts/bindings/KidsVault.g.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class Network {
  int chainId;
  Web3Client client;
  KidsMerchantRegistry registry;
  KidsVault kidsVault;
  static Network? _instance;

  Network(this.chainId, this.client, this.registry, this.kidsVault);

  static Network get instance {
    if (_instance == null){
      var client = Web3Client("https://sepolia.infura.io/v3/3023ab01a95a40ba8387ae74932e2aaf", http.Client());
      _instance = Network(
        11155111,
        client,
        KidsMerchantRegistry(address: EthereumAddress.fromHex("0xB0ECAeAffb6EAF78E267965E1846A94a438B4034"), client: client),
        KidsVault(address: EthereumAddress.fromHex("0x935714320e2b8fa7617ad9ab74bcc425df0be9f2"), client: client),
      );
    }
    return _instance!;
  }
}