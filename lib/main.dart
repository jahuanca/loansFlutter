import 'package:flutter/material.dart';
import 'package:loands_flutter/src/app.dart';
import 'package:loands_flutter/src/utils/core/config.dart';
import 'package:utils/utils.dart';

void main() {
  
  loadConfig(
    DataConfig(
      showLog: false,
      inputBorder: InputBorder.none,
      primaryColor: Colors.black,
      urlServer: serverUrl,
      labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
      wrapperWidgetInputs: (Widget child) => Card(
                  elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: child,
                  ),
                )
    )
  );

  runApp(const App());
}