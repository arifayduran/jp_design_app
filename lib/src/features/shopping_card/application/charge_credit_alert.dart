import 'package:flutter/material.dart';
import 'package:jp_design_app/src/features/shopping_card/data/credit.dart';

Future<dynamic> chargeCreditAlert(
    BuildContext context, ValueNotifier<double> chargeCreditNotifier) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChargeCreditAlert(chargeCreditNotifier: chargeCreditNotifier);
    },
  );
}

class ChargeCreditAlert extends StatefulWidget {
  const ChargeCreditAlert({super.key, required this.chargeCreditNotifier});
  final ValueNotifier<double> chargeCreditNotifier;

  @override
  State<ChargeCreditAlert> createState() => _ChargeCreditAlertState();
}

class _ChargeCreditAlertState extends State<ChargeCreditAlert> {
  double selectedAmountToCharge = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("How much do you want to charge your credit?"),
      titleTextStyle: Theme.of(context).textTheme.bodyLarge,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      content: SizedBox(
        height: 100,
        width: 100,
        child: Row(
          children: [
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 5;
                    });
                  },
                  child: const Text("5"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 70;
                    });
                  },
                  child: const Text("70"),
                )
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 10;
                    });
                  },
                  child: const Text("10"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 100;
                    });
                  },
                  child: const Text("100"),
                )
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 20;
                    });
                  },
                  child: const Text("20"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 200;
                    });
                  },
                  child: const Text("200"),
                )
              ],
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 50;
                    });
                  },
                  child: const Text("50"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedAmountToCharge = 500;
                    });
                  },
                  child: const Text("500"),
                )
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            credit += selectedAmountToCharge;
            widget.chargeCreditNotifier.value = credit;
            Navigator.of(context).pop();
          },
          child: Text(
              "Charge ${String.fromCharCodes(Runes('\u20B3'))} $selectedAmountToCharge"),
        )
      ],
    );
  }
}
