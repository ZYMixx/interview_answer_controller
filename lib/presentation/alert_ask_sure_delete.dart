import 'package:flutter/material.dart';

import '../data/tools/navigation_tool.dart';
import 'my_widgets/MyWidgetButton.dart';

class AlertAskSureDelete extends StatelessWidget {
  const AlertAskSureDelete(
      {Key? key, required this.alertText, required this.deleteAccept})
      : super(key: key);
  final String alertText;
  final Function deleteAccept;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(60, 0, 0, 0),
      body: Stack(
        children: [
          InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () => ToolNavigator.pop(),
          ),
          AlertDialog(
            content: Card(
              child: SizedBox(
                width: 350,
                height: 120,
                child: Center(
                    child: Text(
                  alertText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                )),
              ),
            ),
            actionsAlignment: MainAxisAlignment.start,
            actions: [
              MyWidgetButton(
                  onPressed: () => ToolNavigator.pop(),
                  name: "STOP",
                  color: Colors.purple),
              MyWidgetButton(
                  onPressed: () {
                    deleteAccept.call();
                    ToolNavigator.pop();
                  },
                  name: "DELETE",
                  color: Colors.red)
            ],
          )
        ],
      ),
    );
  }
}
