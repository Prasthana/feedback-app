
import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/api_services/models/oneonones.dart';
import 'package:feedbackapp/api_services/models/oneononesresponse.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class UpdateOneoneOneView extends StatefulWidget {
  const UpdateOneoneOneView({super.key, required this.oneOnOneResp});

  final String oneOnOneResp;
  //final OneOnOneCreateResponse oneOnOneResp;
  @override
  State<UpdateOneoneOneView> createState() => _UpdateOneoneOneViewState();
}

class _UpdateOneoneOneViewState extends State<UpdateOneoneOneView> {
  Future<OneOnOneCreateResponse>? oneOnOneCreateResponseFuture;

  @override
  void initState() {
    // this.mEmployee = widget.mEmployee;
    // checkLoginstatus(mEmployee?.id ?? 0);
     oneOnOneCreateResponseFuture =
        ApiManager.authenticated.fetchOneOnOneDetails(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorText),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "1-on-1",
          style: TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<OneOnOneCreateResponse>(
          future: oneOnOneCreateResponseFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
               return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final oneOneResponse = snapshot.data;

              var length = oneOneResponse?.oneOnOne.oneOnOneParticipants?.length ?? 0;
              if ( length > 0) {
                return buildOneOnOneDetailsView(oneOneResponse?.oneOnOne);
              } else {
               return buildOneOnOneDetailsView(oneOneResponse?.oneOnOne);
              }
            } else {
              return buildEmptyView();
            }
          },
        ),
      ),
    );
  }

  Widget buildEmptyView() {
      return const Column(
          children: [
            Text("data"),
          ],
      );
  }
  Widget buildOneOnOneDetailsView(OneOnOneCreate? _oneOnOne) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_oneOnOne?.oneOnOneParticipants?.first.employee.name ?? "")

          ]
        ),
      );
  }
}