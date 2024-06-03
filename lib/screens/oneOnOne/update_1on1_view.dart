import 'package:dio/dio.dart';
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_request.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/api_services/models/oneonone.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/date_formaters.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:feedbackapp/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
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
  //TextEditingController _textFieldController = TextEditingController();
  double _currentSliderValue = 0.0;
  // ignore: prefer_final_fields
  List<OneOnOnePointsAttribute> _oneOnOnePointsAttributes = [];
  List<Point> localGoodAtList = [];
  List<Point> localYetToImproveList = [];
  String enteredAddPoint = "";

  @override
  void initState() {
    oneOnOneData = widget.oneOnOneData;
    oneOnOneCreateResponseFuture =
        ApiManager.authenticated.fetchOneOnOneDetails(oneOnOneData?.id ?? 0);
    super.initState();
  }

  void setUpdateOneOnOneFuture(Future<OneOnOneCreateResponse>? newValue) {
    setState(() {
      oneOnOneCreateResponseFuture = newValue;
      // isUpdating = true;
    });
  }

  Widget showRatingBar() {
    return Slider(
      value: _currentSliderValue,
      max: 5,
      divisions: 10,
      activeColor: Colors.black,
      label: _currentSliderValue.toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
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
      body: Container(
        color: Colors.white,
        child: Center(
          child: FutureBuilder<OneOnOneCreateResponse>(
            future: oneOnOneCreateResponseFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final oneOneResponse = snapshot.data;

                var oneOnOne = oneOneResponse?.oneOnOne;
                if (oneOnOne != null) {
                  debugPrint("------>>> 1");
                  return buildOneOnOneDetailsView(oneOnOne);
                } else {
                  debugPrint("------>>> 2");
                  return buildEmptyView();
                }
              } else {
                debugPrint("------>>> 3");
                return buildEmptyView();
              }
            },
          ),
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

    return SingleChildScrollView(
      //color: Colors.white,
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
            initialValue: oneOnOne?.notes ?? "",
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
        gootAtBottomView(oneOnOne?.goodAtPoints),
        yetToImproveBottomView(oneOnOne?.yetToImprovePoints),
        addVerticalSpace(20),
        const Text(
          "Rating:",
          style: TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        addVerticalSpace(30),
        showRatingBar(),
        addVerticalSpace(20),
        MaterialButton(
          minWidth: double.infinity,
          height: 58.0,
          onPressed: () {
            debugPrint("clicked on Save ----->>>> $_currentSliderValue");
            _updateOneOnOneAPIcall(context);
          },
          // ignore: sort_child_properties_last
          child: const Text("Save"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: const Color.fromRGBO(0, 0, 0, 1),
          textColor: Colors.white,
        ),
        addVerticalSpace(60),
      ]),
    );
  }

  _updateOneOnOneAPIcall(BuildContext context) async {
    var oneOnOneObj = OneOnOne();
    if (_currentSliderValue > 0) {
      oneOnOneObj.feedbackRating = _currentSliderValue;
    }
    if (enteredNotes.isNotEmpty) {
      oneOnOneObj.notes = enteredNotes;
    }

    if (localGoodAtList.isNotEmpty) {
      for (Point pnt in localGoodAtList) {
        var attr =
            OneOnOnePointsAttribute(pointType: "pt_good_at", title: pnt.title);
        _oneOnOnePointsAttributes.add(attr);
      }
    }

    if (localYetToImproveList.isNotEmpty) {
      for (Point pnt in localYetToImproveList) {
        var attr = OneOnOnePointsAttribute(
            pointType: "pt_yet_to_improve", title: pnt.title);
        _oneOnOnePointsAttributes.add(attr);
      }
    }

    if (_oneOnOnePointsAttributes.isNotEmpty) {
      oneOnOneObj.oneOnOnePointsAttributes = _oneOnOnePointsAttributes;
    }
    var request = OneOnOneCreateRequest(oneOnOne: oneOnOneObj);
    ApiManager.authenticated
        .updateOneOnOneDetails(request, oneOnOneData?.id ?? 0)
        .then((val) {
      logger.e('update OneOnOne response -- ${val.toJson()}');
      localGoodAtList.clear();
      localYetToImproveList.clear();
      _oneOnOnePointsAttributes.clear();
      var newFuture =
          ApiManager.authenticated.fetchOneOnOneDetails(oneOnOneData?.id ?? 0);
      setUpdateOneOnOneFuture(newFuture);
    }).catchError((obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case const (DioException):
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioException).response;
          logger.e('Got error : ${res?.statusCode} -> ${res?.statusMessage}');

          break;
        default:
          break;
      }
    });
  }

  Widget yetToImproveBottomView(List<Point>? yetToImproveList) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Yet to Improve",
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
                onPressed: () {
                  _displayTextInputDialog(false, "Yet to Improve", context, yetToImproveList ?? []);
                },
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
        ),
        addVerticalSpace(10),
        showRecordView(),
        buildYetToImproveList(yetToImproveList),
      ],
    );
  }

  Widget showRecordView() {
    return const ListTile(
        leading: Icon(Icons.menu),
        trailing: Icon(Icons.mic),
        title: Text(
          "Type here or click on Mic",
          style: TextStyle(
              fontFamily: constants.uberMoveFont,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 1)),
        ));
  }

  Widget buildYetToImproveList(List<Point>? yetToImproveList) {
    return ListView.separated(
      // Second list view
      shrinkWrap: true,
      itemCount: yetToImproveList?.length ?? 0,
      separatorBuilder: (context, index) =>
          const Divider(), // Optional separator
      itemBuilder: (context, index) {
        var yetToImprovePoint = yetToImproveList?[index];
        return SizedBox(
          height: 56.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.menu),
                title: Text(
                  yetToImprovePoint?.title ?? "",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                onTap: () {},
              )
            ],
          ),
        );
      },
    );
  }

  Widget gootAtBottomView(List<Point>? goodAtList) {
    return Column(
      children: [
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
                onPressed: () {
                  _displayTextInputDialog(true, "Good at point", context, goodAtList ?? []);
                },
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
        ),
        addVerticalSpace(10),
        showRecordView(),
        buildGoodAtList(goodAtList),
      ],
    );
  }

  Widget buildGoodAtList(List<Point>? goodAtList) {
    
    debugPrint("goodAtList length ------>>> ${goodAtList?.length}");
    debugPrint("localGoodAtList length ------>>> ${localGoodAtList.length}");
    List<Point>goodPointsList = [];
    goodPointsList.addAll(localGoodAtList.reversed);
    goodPointsList.addAll(goodAtList ?? []);
    
    //final goodPointsList =  goodAtList ?? [] + ;
    debugPrint("goodPointsList length ------>>> ${goodPointsList.length}");
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: goodPointsList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        var goodAtPoint = goodPointsList[index];
        return SizedBox(
          height: 56.0,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.menu),
                title: Text(
                  goodAtPoint.title,
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                onTap: () {},
              ),
            ],
          ),
        );
      },
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

  Future<void> _displayTextInputDialog(
      bool isGoodAt, String text, BuildContext context, List<Point> apiList) async {
    var chngedText = "";
    debugPrint("apiList length ------>>> ${apiList.length}");
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text(text),
          content: TextFormField(
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
                chngedText = value;
              }),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (isGoodAt) {
                  localGoodAtList.add(Point(title: chngedText));
                  debugPrint("localGoodAtList length ------>>> ${localGoodAtList.length}");
                  
                  setState(() {
                    buildGoodAtList(apiList);
                  });
                } else {
                  localYetToImproveList.add(Point(title: chngedText));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
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
