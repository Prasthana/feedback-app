import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/managers/apiservice_manager.dart';

class EnvironmentSettingView extends StatefulWidget {
  const EnvironmentSettingView({super.key});

  @override
  State<EnvironmentSettingView> createState() => _EnvironmentSettingViewState();
}

class _EnvironmentSettingViewState extends State<EnvironmentSettingView> {
  var sm = StorageManager();
  var currentEnvId = 1;
  var selectedEnvId = 1;

  @override
  void initState() {
    super.initState();

    sm.getData(constants.environmentId).then((val) async {
      if (val != constants.noDataFound) {
        setState(() {
          currentEnvId = int.parse(val);
          selectedEnvId = currentEnvId;
        });
      }
    });
  }

  saveEnvChanges(Environment env) {
            if (env.name == constants.stagingText) {
          EnvironmentManager.isProdEnv = false;
        } else {
          EnvironmentManager.isProdEnv = true;
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorText),
          onPressed: () {
            if (selectedEnvId != currentEnvId) {
              showValidationAlert(context, constants.environmentUpdatedHindText);
            } else {
              Navigator.pop(context);
            }
            
          }),
        title: const Text(constants.environmentSetup),
      ),
      body: ListView.builder(
          itemCount: EnvironmentManager.environments.length,
          itemBuilder: (BuildContext context, int index) {
            Environment env = EnvironmentManager.environments[index];
            return Column(
              children: <Widget>[
                ListTile(
                    trailing: env.id == currentEnvId
                        ? const Icon(Icons.check, color: Colors.blue,)
                        : const Text(""),
                    title: Text(
                      env.name ?? "",
                      style: const TextStyle(
                          fontFamily: constants.uberMoveFont,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    onTap: () {
                      Environment env = EnvironmentManager.environments[index];
                      EnvironmentManager.currentEnv = env;
                      currentEnvId = env.id;
                      ApiManager.baseURL = env.baseUrl;
                      saveEnvChanges(env);
                      print("selected baseUrl -------->>>>24> ${env.baseUrl}");
                      sm.saveData(constants.environmentId, env.id.toString());
                      setState(() {});

                    }),
                const Divider(
                  color: Color.fromRGBO(195, 195, 195, 1),
                  height: 3.0,
                  thickness: 1.0,
                  indent: 16.0,
                  endIndent: 0,
                ),
              ],
            );
          }),
    );
  }

   showValidationAlert(BuildContext context, String alertText) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(alertText),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class Environment {
  int id;
  String? name;
  String baseUrl;
  String clientId;
  String clientScret;

  Environment(
      {required this.id, this.name, required this.baseUrl, required this.clientId, required this.clientScret});
}
