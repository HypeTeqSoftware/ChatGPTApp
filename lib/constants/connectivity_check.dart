import 'package:flutter/cupertino.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityCheck {
  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> noInternetDialogIOS(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Column(
              children: const [
                Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_rounded,
                  size: 44,
                  color: CupertinoColors.activeOrange,
                ),
                SizedBox(height: 10),
                Text(
                  "No Internet Connection",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                  child: const Text('OK', style: TextStyle()),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }

  static Future<void> noInternetDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_rounded,
                  size: 50,
                  color: CupertinoColors.activeOrange,
                ),
                SizedBox(height: 15),
                Text(
                  "No Internet Connection",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
