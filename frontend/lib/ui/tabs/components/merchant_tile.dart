import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/Merchant.dart';

class MerchantTile extends StatefulWidget {
  final Merchant merchant;
  final VoidCallback onToggle;
  const MerchantTile({super.key, required this.merchant, required this.onToggle});

  @override
  State<MerchantTile> createState() => _MerchantTileState();
}

class _MerchantTileState extends State<MerchantTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(10000),
              image: DecorationImage(
                image: NetworkImage(widget.merchant.logo,)
              )
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.merchant.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const SizedBox(width: 4,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000), color: (widget.merchant.approved ? Colors.green : Colors.red).withOpacity(0.4)),
                        child: Container(width: 8, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(1000), color: (widget.merchant.approved ? Colors.green : Colors.red).withOpacity(0.8)),),
                      ),
                      const SizedBox(width: 2,),
                      Text(widget.merchant.approved ? "Enabled" : "Disabled")
                    ],
                  )
                ],
              ),
              SizedBox(
                width: Get.width * 0.50,
                child: Text(widget.merchant.description, style: const TextStyle(color: Colors.white54),),
              )
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => widget.onToggle.call(),
            style: ButtonStyle(
              shadowColor: WidgetStateProperty.all(widget.merchant.approved ? Colors.red : Colors.green),
              elevation: WidgetStateProperty.resolveWith<double>((states) {
                if (states.contains(WidgetState.hovered)) {
                  return 5.0;
                }
                return 1.0;
              }),
            ),
            child: Text(widget.merchant.approved ? "Disable" : "Enable"),
          )
        ],
      ),
    );
  }
}
