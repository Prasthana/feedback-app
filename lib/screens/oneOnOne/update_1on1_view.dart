import 'package:cached_network_image/cached_network_image.dart';
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/api_services/models/oneonones.dart';
import 'package:feedbackapp/api_services/models/oneononesresponse.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:feedbackapp/utils/utilities.dart';
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

              var length =
                  oneOneResponse?.oneOnOne.oneOnOneParticipants?.length ?? 0;
              if (length > 0) {
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

  Widget buildOneOnOneDetailsView(OneOnOneCreate? _oneOnOne) {
    var employee =
        _oneOnOne?.oneOnOneParticipants?.first.employee ?? Employee();
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          addVerticalSpace(40),
          showEmployeeAvatar(employee),
          addVerticalSpace(12),
            Center(
              child: Text(
                employee.name ?? "",
                style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(4, 4, 4, 1)),
              ),
            ),
            addVerticalSpace(8),
            Center(
              child: Text(
                employee.email ?? "",
                style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(4, 4, 4, 1)),
              ),
            ),
            addVerticalSpace(8),
             Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_month),
                  addHorizontalSpace(5),
                  Text("Tuesday, 18 May 2024"),
                ],
              ),
            ),
            addVerticalSpace(8),
             Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time_filled),
                  addHorizontalSpace(5),
                  Text("9:30 AM"),
                ],
              ),
            ),

      ]),
    );
  }

    Widget showEmployeeAvatar(Employee selectedEmployee) {
    return CircleAvatar(
      backgroundColor: colorPrimary,
      maxRadius: 58.0,
      foregroundImage: NetworkImage(selectedEmployee.avatarAttachmentUrl ?? ""),
      child: Text(
        getInitials(selectedEmployee.name ?? "No Particiapnt", 2),
        style: const TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );
  }

  Widget buildEmptyView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/emptyOneOnOneList.png', height: 250),
              addVerticalSpace(20),
              const Text(
                constants.noEmployeeAdded,
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              addVerticalSpace(20),
              const Text(
                constants.addEmployeeMsg,
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ));
  }
}
