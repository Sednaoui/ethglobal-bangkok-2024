import 'package:bot_toast/bot_toast.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kid_pay/utils/currency.dart';
import 'package:kid_pay/utils/extensions/decimal_extensions.dart';
import 'package:kid_pay/widgets/c_button.dart';
import 'package:web3dart/web3dart.dart';

class SendAddDialog extends StatelessWidget {
  final Function(EthereumAddress address, BigInt amount) onAdd;
  SendAddDialog({super.key, required this.onAdd});

  String address = "";
  String amount = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add kid's wallet"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                label: Text("Address"),
                hintText: "eg. 0x12cad"
            ),
            onChanged: (val) => address = val,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Amount"),
              hintText: "eg. 145"
            ),
            onChanged: (val) => amount = val,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        CButton(
          onPressed: () async {
            onAdd.call(
              EthereumAddress.fromHex(address),
              CurrencyUtils.parseCurrency(Decimal.parse(amount).toTrimmedStringAsFixed(18), 18)
            );
            Get.back();
          },
          child: const Text("Add"),
        )
      ],
    );
  }
}
