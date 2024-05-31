import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/api_services/models/oneonone.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/date_formaters.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:feedbackapp/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class UpdateOneoneOneView extends StatefulWidget {
  const UpdateOneoneOneView({super.key, required this.oneOnOneData});

  //final String oneOnOneResp;
  final OneOnOne? oneOnOneData;
  @override
  State<UpdateOneoneOneView> createState() => _UpdateOneoneOneViewState();
}

class _UpdateOneoneOneViewState extends State<UpdateOneoneOneView> {
  Future<OneOnOneCreateResponse>? oneOnOneCreateResponseFuture;
  String enteredNotes = "";
  OneOnOne? oneOnOneData;

  @override
  void initState() {
     oneOnOneData = widget.oneOnOneData;
    // checkLoginstatus(mEmployee?.id ?? 0);
    oneOnOneCreateResponseFuture =
        ApiManager.authenticated.fetchOneOnOneDetails(oneOnOneData?.id ?? 0);
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
        backgroundColor: Colors.white,
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

  Widget buildOneOnOneDetailsView(OneOnOne? oneOnOne) {
    var employee = oneOnOne?.oneOnOneParticipants?.first.employee ?? Employee();
    String meetingStartTime =
        getFormatedDateConvertion(oneOnOne?.startDateTime ?? "", "hh:mm a");
    String meetingDate = getFormatedDateConvertion(
        oneOnOne?.startDateTime ?? "", "EEEE, dd MMM yyyy");
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        addVerticalSpace(20),
        Center(
          child: showEmployeeAvatar(employee),
        ),
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
                fontWeight: FontWeight.w500,
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
              Text(
                meetingDate,
                style: const TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        addVerticalSpace(8),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time_filled),
              addHorizontalSpace(5),
              Text(
                meetingStartTime,
                style: const TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        addVerticalSpace(12),
        const Text(
          constants.notesText,
          style: TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        addVerticalSpace(8),
        TextFormField(
            minLines: 2,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              hintText: constants.notesHintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorText,
                ),
              ),
            ),
            style: const TextStyle(
              fontFamily: constants.uberMoveFont,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            onChanged: (value) {
              enteredNotes = value;
            }),
        addVerticalSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Good At",
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "+ Add point",
                  style: TextStyle(
                    color: Color.fromRGBO(22, 97, 210, 1),
                    fontFamily: constants.uberMoveFont,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ))
          ],
        )
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
