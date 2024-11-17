import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:kid_pay/config/network.dart';
import 'package:kid_pay/services/metamask_manager/metamask_manager.dart';
import 'package:kid_pay/ui/tabs/components/send_add_dialog.dart';
import 'package:kid_pay/utils/currency.dart';
import 'package:kid_pay/widgets/c_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web3dart/credentials.dart';

class SendTab extends StatefulWidget {
  const SendTab({super.key});

  @override
  State<SendTab> createState() => _SendTabState();
}

class _SendTabState extends State<SendTab> {
  bool loading = true;
  BigInt balance = BigInt.zero;
  List<_Distribution> distributions = [];

  void refreshBalance() async {
    setState(() {
      loading = true;
    });
    balance = await Network.instance.kidsVault.balanceOf(Network.instance.kidsVault.self.address);
    if (!mounted) return;
    setState(() {
      loading = false;
    });
  }

  void distribute() async {
    var cancelLoad = BotToast.showLoading();
    var metamask = MetamaskManager.instance;
    var data = Network.instance.kidsVault.self.function("batchDistribute").encodeCall([distributions.map((e) => [e.receiver, e.amount]).toList()]);
    var from = (await metamask.getConnectedAccounts()).first;
    var result = await metamask.sendTransaction(
      Network.instance.kidsVault.self.address,
      from,
      data
    );
    launchUrl(Uri.parse("https://eth-sepolia.blockscout.com/tx/$result"));
    cancelLoad();
    if (!mounted) return;
    setState(() {
      distributions.clear();
    });
  }

  @override
  void initState() {
    refreshBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    var balanceFormatted = CurrencyUtils.formatUnits(balance, 18);
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Send to your kids", style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold, fontSize: 35),),
              const SizedBox(width: 5,),
              IconButton(
                onPressed: (){
                  refreshBalance();
                },
                icon: Icon(PhosphorIcons.arrowClockwise(), size: 15,),
              ),
            ],
          ),
          Text("Balance: $balanceFormatted", style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold, fontSize: 12),),
          const SizedBox(height: 15,),
          for (var distribution in distributions.toList())
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: _DistributionEntry(
                distribution: distribution,
                onDelete: (){
                  setState(() {
                    distributions.remove(distribution);
                  });
                },
              ),
            ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CButton(
                onPressed: (){
                  Get.dialog(SendAddDialog(
                    onAdd: (address, amount){
                      setState(() {
                        distributions.add(_Distribution(address, amount));
                      });
                    },
                  ));
                },
                child: const Text("Add"),
              ),
              const SizedBox(width: 10,),
              CButton(
                onPressed: distributions.isNotEmpty ? (){
                  distribute();
                } : null,
                child: const Text("Send"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DistributionEntry extends StatelessWidget {
  final _Distribution distribution;
  final VoidCallback onDelete;
  const _DistributionEntry({super.key, required this.distribution, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    var amountFormatted = CurrencyUtils.formatUnits(distribution.amount, 18);
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      tileColor: Get.theme.cardColor,
      title: Text(distribution.receiver.hexEip55),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(amountFormatted, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          const SizedBox(width: 10,),
          IconButton(
            onPressed: (){
              onDelete.call();
            },
            icon: Icon(
              PhosphorIcons.trash(),
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}


class _Distribution {
  EthereumAddress receiver;
  BigInt amount;
  _Distribution(this.receiver, this.amount);
}

