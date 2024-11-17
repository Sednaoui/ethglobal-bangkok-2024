import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kid_pay/config/merchants_registry.dart';
import 'package:kid_pay/config/network.dart';
import 'package:kid_pay/models/Merchant.dart';
import 'package:kid_pay/services/metamask_manager/metamask_manager.dart';
import 'package:kid_pay/ui/tabs/components/merchant_tile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class ApprovedMerchantsTab extends StatefulWidget {
  const ApprovedMerchantsTab({super.key});

  @override
  State<ApprovedMerchantsTab> createState() => _ApprovedMerchantsTabState();
}

class _ApprovedMerchantsTabState extends State<ApprovedMerchantsTab> {
  bool loading = true;
  final List<(String, PhosphorIconData)> groups = MerchantsRegistry.getGroupsData();
  String selectedGroup = "";
  List<Merchant> merchants = [];
  Set<EthereumAddress> approvedMerchants = {};

  Future<void> loadMerchants(String group) async {
    setState(() => loading = true);
    var entries = await Network.instance.registry.getGroupEntries(keccakUtf8(group));
    merchants.clear();
    await loadApprovedMerchants();
    for (var entry in entries){
      Merchant merchant = Merchant(
        address: entry[0],
        name: entry[1],
        description: bytesToHex(entry[2], include0x: false),
        logo: bytesToHex(entry[3], include0x: false),
        group: group,
        approved: approvedMerchants.contains(entry[0])
      );
      merchants.add(merchant);
    }
    await Future.delayed(const Duration(seconds: 1));
    setState(() => loading = false);
  }

  Future<void> loadApprovedMerchants() async {
    final contractEvent = Network.instance.kidsVault.self.event('MaxRedeemChanged');
    List<FilterEvent> events = await Network.instance.client.getLogs(FilterOptions(
      fromBlock: const BlockNum.exact(7091028),
      toBlock: const BlockNum.current(),
      address: Network.instance.kidsVault.self.address,
      topics: [
        ["0xf236450fb69890ddf057cae7305afeae8ed1d676d79e7958cdc31fd2e33df2c3"],
        [],
      ]
    ));
    approvedMerchants.clear();
    for (var event in events){
      final decoded = contractEvent.decodeResults(
        event.topics!,
        event.data!,
      );
      EthereumAddress address = decoded[0];
      BigInt amount = decoded[1];
      if (amount == BigInt.zero){
        approvedMerchants.remove(address);
      }else{
        approvedMerchants.add(address);
      }
    }
  }

  Future<void> approveMerchant(EthereumAddress merchant) async {
    var metamask = MetamaskManager.instance;
    var data = Network.instance.kidsVault.self.function("setMaxDailyRedeemAmount").encodeCall([merchant, BigInt.parse("100000000000000000000000")]);
    var from = (await metamask.getConnectedAccounts()).first;
    var result = await metamask.sendTransaction(
      Network.instance.kidsVault.self.address,
      from,
      data
    );
    launchUrl(Uri.parse("https://eth-sepolia.blockscout.com/tx/$result"));
    loadApprovedMerchants();
  }

  Future<void> removeMerchant(EthereumAddress merchant) async {
    var metamask = MetamaskManager.instance;
    var data = Network.instance.kidsVault.self.function("setMaxDailyRedeemAmount").encodeCall([merchant, BigInt.zero]);
    var from = (await metamask.getConnectedAccounts()).first;
    var result = await metamask.sendTransaction(
        Network.instance.kidsVault.self.address,
        from,
        data
    );
    launchUrl(Uri.parse("https://eth-sepolia.blockscout.com/tx/$result"));
    loadApprovedMerchants();
  }

  @override
  void initState() {
    selectedGroup = groups[0].$1;
    loadMerchants(selectedGroup);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              for (var group in groups)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: selectedGroup == group.$1 ? Get.theme.colorScheme.primary.withOpacity(0.2) : null,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black87),
                    ),
                    child: InkWell(
                      onTap: loading == false ? (){
                        selectedGroup = group.$1;
                        loadMerchants(selectedGroup);
                      } : null,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: [
                            Icon(group.$2),
                            Text(group.$1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 10,)
            ],
          ),
          loading ? Container(
            margin: const EdgeInsets.only(top: 30),
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: CircularProgressIndicator()
            ),
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: TextButton(
                  onPressed: (){
                    loadMerchants(selectedGroup);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(PhosphorIcons.arrowClockwise(), size: 14,),
                      const SizedBox(width: 2),
                      const Text("Refresh"),
                    ],
                  ),
                ),
              ),
              for (var merchant in merchants)
                MerchantTile(
                  onToggle: () async {
                    if (merchant.approved){
                      await removeMerchant(merchant.address);
                    }else{
                      await approveMerchant(merchant.address);
                    }
                    loadMerchants(selectedGroup);
                  },
                  merchant: merchant,
                )
            ],
          )
        ],
      ),
    );
  }
}
