import 'package:flutter/material.dart';
import '../../data/tools/navigation_tool.dart';
import '../../data/tools/theme_tool.dart';
import 'my_widget_button.dart';

class AlertAskSureDelete extends StatelessWidget {
  final String alertText;
  final Function deleteAccept;
  const AlertAskSureDelete(
      {Key? key, required this.alertText, required this.deleteAccept})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(60, 0, 0, 0),
      body: Stack(
        children: [
          const InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: ToolNavigator.pop,
          ),
          AlertDialog(
            content: Card(
              color: ToolTheme.mainBgColor,
              elevation: 0,
              child: SizedBox(
                width: 350,
                height: 120,
                child: Center(
                    child: Text(
                  alertText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
            ),
            actionsAlignment: MainAxisAlignment.start,
            actions: [
              const MyWidgetButton(
                  onPressed: ToolNavigator.pop,
                  name: "STOP",
                  color: Colors.purple),
              MyWidgetButton(
                  onPressed: onDeleteAcceptPressed,
                  name: "DELETE",
                  color: Colors.red)
            ],
          )
        ],
      ),
    );
  }

  void onDeleteAcceptPressed() {
    deleteAccept.call();
    ToolNavigator.pop();
  }
}
