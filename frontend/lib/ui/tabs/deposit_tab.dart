import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:kid_pay/config/network.dart';
import 'package:kid_pay/contracts/bindings/ERC20.g.dart';
import 'package:kid_pay/services/metamask_manager/metamask_manager.dart';
import 'package:kid_pay/utils/currency.dart';
import 'package:kid_pay/utils/extensions/decimal_extensions.dart';
import 'package:kid_pay/utils/input_formatters.dart';
import 'package:kid_pay/widgets/c_button.dart';
import 'package:web3dart/credentials.dart';
import 'package:url_launcher/url_launcher.dart';

class DepositTab extends StatefulWidget {
  const DepositTab({super.key});

  @override
  State<DepositTab> createState() => _DepositTabState();
}

class _DepositTabState extends State<DepositTab> {
  Decimal value = Decimal.zero;
  BigInt accountAllowance = BigInt.zero;

  refreshAccountAllowance() async {
    var metamask = MetamaskManager.instance;
    var account = (await metamask.getConnectedAccounts()).first;
    var asset = await Network.instance.kidsVault.asset();
    var assetContract = ERC20(address: asset, client: Network.instance.client);
    accountAllowance = await assetContract.allowance(account, Network.instance.kidsVault.self.address);
    if (!mounted) return;
    setState(() {});
  }

  deposit() async {
    var metamask = MetamaskManager.instance;
    var from = (await metamask.getConnectedAccounts()).first;
    var amount = CurrencyUtils.parseCurrency(value.toTrimmedStringAsFixed(18), 18);
    EthereumAddress to;
    Uint8List data;
    if (accountAllowance < amount){
      var asset = await Network.instance.kidsVault.asset();
      var assetContract = ERC20(address: asset, client: Network.instance.client);
      to = asset;
      data = assetContract.self.function("approve").encodeCall([Network.instance.kidsVault.self.address, amount]);
    }else{
      to = Network.instance.kidsVault.self.address;
      data = Network.instance.kidsVault.self.function("deposit").encodeCall([amount]);
    }
    var result = await metamask.sendTransaction(
      to,
      from,
      data
    );
    launchUrl(Uri.parse("https://eth-sepolia.blockscout.com/tx/$result"));
    refreshAccountAllowance();
  }

  @override
  void initState() {
    refreshAccountAllowance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        children: [
          Text("Deposit Amount", style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold, fontSize: 35),),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    ThousandsFormatter(allowFraction: true)
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                  ),
                  onChanged: (val){
                    setState(() {
                      value = Decimal.parse(val.trim().isEmpty ? "0" : val.replaceAll(",", ""));
                    });
                  },
                ),
              ),
              const SizedBox(width: 6,),
              Card(
                elevation: 10,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Text("\$")
                ),
              )
            ],
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CButton(
                onPressed: value > Decimal.zero ? (){
                  deposit();
                } : null,
                child: Text(
                  accountAllowance >= CurrencyUtils.parseCurrency(value.toTrimmedStringAsFixed(18), 18) ?
                    "Deposit" : "Approve"
                ),
              ),
              const SizedBox(width: 5,),
              IconButton(
                onPressed: (){
                  refreshAccountAllowance();
                },
                icon: Icon(PhosphorIcons.arrowClockwise(), size: 15,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
