import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/managers/apiservice_manager.dart';

class EnvironmentSettingView extends StatefulWidget {
  const EnvironmentSettingView({super.key});

  @override
  State<EnvironmentSettingView> createState() => _EnvironmentSettingViewState();
}

class _EnvironmentSettingViewState extends State<EnvironmentSettingView> {
  var sm = StorageManager();
  var selectedEnvId = 1;

  @override
  void initState() {
    super.initState();

    sm.getData(constants.environmentId).then((val) async {
      if (val != constants.noDataFound) {
        setState(() {
          selectedEnvId = int.parse(val);
        });
        print("get selectedEnvId -------->>>>> $selectedEnvId");
      }
    });
  }

  restartApp() async {
            await SystemNavigator.pop();
            //popUntil(context, ModalRoute.withName('/'));
            exit(0); // Exit the app with exit code 0 (success)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Environment setup"),
      ),
      body: ListView.builder(
          itemCount: EnvironmentManager.environments.length,
          itemBuilder: (BuildContext context, int index) {
            Environment env = EnvironmentManager.environments[index];
            return Column(
              children: <Widget>[
                ListTile(
                    leading: env.id == selectedEnvId
                        ? const Icon(Icons.check_box_outlined)
                        : const Icon(Icons.check_box_outline_blank),
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
                      selectedEnvId = index + 1;
                      ApiManager.baseURL = env.baseUrl;
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
