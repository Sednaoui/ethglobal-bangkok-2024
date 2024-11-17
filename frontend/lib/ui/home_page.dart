import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kid_pay/ui/tabs/approved_merchants_tab.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:kid_pay/config/network.dart';
import 'package:kid_pay/services/metamask_manager/metamask_manager.dart';
import 'package:kid_pay/ui/tabs/send_tab.dart';
import 'package:kid_pay/ui/tabs/deposit_tab.dart';
import 'package:kid_pay/widgets/c_button.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  EthereumAddress? mmConnectedAccount;
  late MetamaskManager metamaskManager;
  bool connected = false;
  bool isOwner = false;

  void mmConnect() async {
    await metamaskManager.connect();
    var connectedAccounts = await metamaskManager.getConnectedAccounts();
    if (connectedAccounts.isNotEmpty){
      var owner = await Network.instance.kidsVault.owner();
      mmConnectedAccount = connectedAccounts.first;
      isOwner = owner.hex == mmConnectedAccount!.hex;
      setState(() {
        connected = true;
      });
    }
  }

  @override
  void initState() {
    metamaskManager = MetamaskManager.instance;
    super.initState();
  }

  /*String group = "";
  String address = "";
  String name = "";
  String description = "";
  String logo = "";
  @override
  Widget build(BuildContext context){
    Random rng = Random();
    address = (EthPrivateKey.createRandom(rng)).address.hexEip55;
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    label: Text("Group"),
                    hintText: ""
                ),
                onChanged: (val) => group = val,
              ),
              TextFormField(
                initialValue: address,
                decoration: const InputDecoration(
                  label: Text("Target"),
                  hintText: "eg. 0x..."
                ),
                onChanged: (val) => address = val,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Name"),
                  hintText: "Walmart"
                ),
                onChanged: (val) => name = val,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Description"),
                  hintText: "..."
                ),
                onChanged: (val) => description = val,
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Logo URI"),
                  hintText: "https://"
                ),
                onChanged: (val) => logo = val,
              ),
              const SizedBox(height: 25,),
              CButton(
                onPressed: () async {
                  var cancelLoad = BotToast.showLoading();
                  var client = Web3Client("https://sepolia.infura.io/v3/3023ab01a95a40ba8387ae74932e2aaf", http.Client());
                  var registry = KidsMerchantRegistry(address: EthereumAddress.fromHex("0xB0ECAeAffb6EAF78E267965E1846A94a438B4034"), client: client);
                  Credentials credentials = EthPrivateKey(hexToBytes("0xc7e84fc9315b47c4c2b6b96eadfe828e85c64034a25ebbcdebc89bd9eb6c7cc5"));
                  var _group = keccakUtf8(group);
                  var _description = keccakUtf8(description);
                  var _logo = keccakUtf8(logo);
                  print("_group: ${bytesToHex(_group)}");
                  print("_description: ${bytesToHex(_description)}");
                  print("_logo: ${bytesToHex(_logo)}");
                  var tx = await registry.addEntry(
                      _group,
                    [EthereumAddress.fromHex(address), name, _description, _logo],
                    credentials: credentials
                  );
                  print("tx: $tx");
                  cancelLoad();
                },
                child: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: Container(
          // padding: const EdgeInsets.only(top: 13, bottom: 13),
          child: Image.asset("assets/KidPay0.png", width: 48, height: 48,),
        ),
        titleSpacing: 0,
        title: Text("KidPay", style: TextStyle(fontWeight: FontWeight.bold, color: Get.theme.colorScheme.primary),),*/
        title: Image.asset("assets/KidPay0.png", width: 128, height: 128,),
        backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
        actions: [
          CButton(
            onPressed: !connected ? (){
              mmConnect();
            } : null,
            child: Text(!connected ? "CONNECT WALLET" : "${mmConnectedAccount!.hex.substring(0, 12)}...",),
          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: !connected ? Stack(
        children: [
          Positioned(
            top: 35,
            right: 70,
            child: Row(
              children: [
                Text("Connect first", style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                )),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    PhosphorIcons.arrowBendUpLeft(PhosphorIconsStyle.bold),
                    size: 40,
                  ),
                )
              ],
            ),
          ),
        ],
      ) : Center(
        child: Card(
          color: Get.theme.colorScheme.surface,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.fastOutSlowIn,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            width: Get.width * 0.7,
            height: Get.height * 0.7,
            child: DefaultTabController(
              length: isOwner ? 3 : 1,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: ButtonsTabBar(
                      onTap: (index) => setState(() {}),
                      radius: 25,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      unselectedDecoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelStyle: TextStyle(
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: isOwner ? [
                        const Tab(text: "DEPOSIT"),
                        const Tab(text: "APPROVED MERCHANTS"),
                        const Tab(text: "SEND"),
                      ] : [const Tab(text: "DEPOSIT")],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    child: TabBarView(
                      children: isOwner ? [
                        const DepositTab(),
                        const ApprovedMerchantsTab(),
                        const SendTab(),
                      ] : [const DepositTab()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
