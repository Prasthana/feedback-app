import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:oneononetalks/api_services/api_errohandler.dart';
import 'package:oneononetalks/api_services/api_service.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/one_on_one_create_request.dart';
import 'package:oneononetalks/api_services/models/one_on_one_create_response.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/api_services/models/pointRequest.dart';
import 'package:oneononetalks/api_services/models/pointResponse.dart';
import 'package:oneononetalks/api_services/models/preparecallresponse.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/oneOnOne/AddOrUpdate_1on1_feedback_points.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/constants.dart';
import 'package:oneononetalks/utils/date_formaters.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/snackbar_helper.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

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
  double _currentSliderValue = 0.0;
  // ignore: prefer_final_fields
  List<OneOnOnePointsAttribute> _oneOnOnePointsAttributes = [];
  List<Point> localGoodAtList = [];
  List<Point> localYetToImproveList = [];
  List<Point> apiGoodPoints = [];
  List<Point> apiYetToImprovePoints = [];
  String enteredAddPoint = "";
  bool hasAccessForUpdate1on1 = false;
  bool hasAccessForUpdatePoints = false;
  bool initialData = true;
  //initializing the API Service class
  final ApiService _apiService = ApiService();
  final TextEditingController _textController = TextEditingController();
  bool isNewPointsAdded = false;

  @override
  void initState() {
    super.initState();
    checkCanUpdate1On1();
    checkCanUpdate1On1Point();
    oneOnOneData = widget.oneOnOneData;
    oneOnOneCreateResponseFuture =
        ApiManager.authenticated.fetchOneOnOneDetails(oneOnOneData?.id ?? 0);
  }

  void setCanUpdate1On1(bool newValue) {
    setState(() {
      hasAccessForUpdate1on1 = newValue;
    });
  }

  void setCanUpdate1On1Point(bool newValue) {
    setState(() {
      hasAccessForUpdatePoints = newValue;
    });
  }

  void checkCanUpdate1On1Point() {
    var sm = StorageManager();
    sm.getData(constants.prepareCallResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mPrepareCallResponse = PrepareCallResponse.fromJson(json);
        logger.d('val -- $json');
        Permission? tabCreate1On1Access =
            mPrepareCallResponse.user?.permissions?["one_on_one_points.update"];
        if (tabCreate1On1Access?.access == Access.enabled) {
          setCanUpdate1On1Point(true);
        } else {
          setCanUpdate1On1Point(false);
        }
      } else {
        setCanUpdate1On1Point(false);
      }
    });
  }

  void checkCanUpdate1On1() {
    var sm = StorageManager();
    sm.getData(constants.prepareCallResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mPrepareCallResponse = PrepareCallResponse.fromJson(json);
        logger.d('val -- $json');
        Permission? tabCreate1On1Access =
            mPrepareCallResponse.user?.permissions?["one_on_ones.update"];
        if (tabCreate1On1Access?.access == Access.enabled) {
          setCanUpdate1On1(true);
        } else {
          setCanUpdate1On1(false);
        }
      } else {
        setCanUpdate1On1(false);
      }
    });
  }

  void setUpdateOneOnOneFuture(Future<OneOnOneCreateResponse>? newValue) {
    setState(() {
      oneOnOneCreateResponseFuture = newValue;
      // isUpdating = true;
    });
  }

  Widget showRatingBar(OneOnOne? oneOnOne) {
    var ratingValue =
        initialData ? oneOnOne?.feedbackRating ?? 0.0 : _currentSliderValue;
    return Slider(
      value: ratingValue,
      max: 5,
      divisions: 10,
      activeColor: Colors.black,
      label: ratingValue.toString(),
      onChanged: (double value) {
        setState(() {
          initialData = false;
          _currentSliderValue = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EnvironmentManager.isProdEnv == true ? colorProductionHeader : colorStagingHeader,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: colorText),
          onPressed: () {
            bool areEqualGoodAtList =
                listEquals(localGoodAtList, apiGoodPoints);
            bool areEqualYetToImproveList =
                listEquals(localYetToImproveList, apiYetToImprovePoints);
            if (hasAccessForUpdate1on1 &&
                (!areEqualGoodAtList || !areEqualYetToImproveList)) {
              showValidationAlert(
                  context, constants.validationAlertText);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          constants.oneOnOneText,
          style: TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        /*
        actions: <Widget>[
          Visibility(
            visible: hasAccessForUpdate1on1,
            child: IconButton(
              icon: const Icon(Icons.more_vert_outlined),
              onPressed: () {
                debugPrint("more clicked ----->>>>");
              },
            ),
          )
        ],
        */
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: FutureBuilder<OneOnOneCreateResponse>(
            future: oneOnOneCreateResponseFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                    backgroundColor: colorPrimary,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
              } else if (snapshot.hasData) {
                final oneOneResponse = snapshot.data;

                var oneOnOne = oneOneResponse?.oneOnOne;
                apiGoodPoints.addAll(oneOnOne?.goodAtPoints ?? []);
                apiYetToImprovePoints
                    .addAll(oneOnOne?.yetToImprovePoints ?? []);

                // debugPrint("apiGoodPoints length ------>>11> ${apiGoodPoints.length}");
                localGoodAtList = oneOnOne?.goodAtPoints ?? [];
                localYetToImproveList = oneOnOne?.yetToImprovePoints ?? [];
                // debugPrint("localGoodAtList1 length ------>>11> ${localGoodAtList.length}");

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
    var employee = oneOnOne?.getOpponentUser();
    var startDateTime = oneOnOne?.startDateTime ?? "";
    String meetingStartTime = startDateTime.utcToLocalDate(constants.timeFormat);
    String meetingDate = getFormatedDateConvertion(
        oneOnOne?.startDateTime ?? "", constants.dateFormat);

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
            employee?.name ?? constants.invalidEmployee,
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
            employee?.email ?? "",
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
            readOnly: !hasAccessForUpdate1on1,
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
        gootAtBottomView(),
        yetToImproveBottomView(),
        addVerticalSpace(20),
        hasAccessForUpdate1on1
            ? managerWriteRatingView(oneOnOne)
            : employeeReadRatingView(oneOnOne?.feedbackRating ?? 0.0),
        addVerticalSpace(50)
      ]),
    );
  }

  Widget employeeReadRatingView(double rating) {
    return Row(
      children: [
        const Text(
          constants.yourRatingText,
          style: TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 21,
            fontWeight: FontWeight.w500,
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: colorText, width: 1.5),
          ),
          child: Text(
            " $rating/${constants.ratingCount}",
            style: const TextStyle(
              fontFamily: constants.uberMoveFont,
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Widget managerWriteRatingView(OneOnOne? oneOnOne) {
    var ratingValue =
        initialData ? oneOnOne?.feedbackRating ?? 0.0 : _currentSliderValue;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              constants.ratingText,
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            addHorizontalSpace(8),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: colorText, width: 1.2),
              ),
              child: Text(
                "  $ratingValue/${constants.ratingCount} ",
                style: const TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
        addVerticalSpace(10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(constants.intialRatingCount), Text(constants.ratingCount)],
          ),
        ),
        showRatingBar(oneOnOne),
        addVerticalSpace(20),
        MaterialButton(
          minWidth: double.infinity,
          height: 58.0,
          onPressed: () {
            _updateOneOnOneAPIcall(context);
          },
          // ignore: sort_child_properties_last
          child: const Text(constants.save),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: const Color.fromRGBO(0, 0, 0, 1),
          textColor: Colors.white,
        ),
        addVerticalSpace(60),
      ],
    );
  }

  _updateOneOnOneAPIcall(BuildContext context) async {
    var dataUpdated = false;

    var oneOnOneObj = OneOnOne();
    if (_currentSliderValue > 0) {
      oneOnOneObj.feedbackRating = _currentSliderValue;
      dataUpdated = true;
    }
    if (enteredNotes.isNotEmpty) {
      oneOnOneObj.notes = enteredNotes;
      dataUpdated = true;
    }

    debugPrint("localGoodAtList after ----->>11>${localGoodAtList.length}");
    for (Point pnt in localGoodAtList) {
      var attr = OneOnOnePointsAttribute(
          id: pnt.id, title: pnt.title, pointType: constants.pointGoodAtType);
      _oneOnOnePointsAttributes.add(attr);      
    }

    for (Point pnt in localYetToImproveList) {
      var attr = OneOnOnePointsAttribute(
          id: pnt.id, title: pnt.title, pointType: constants.pointYetToImproveType);
      _oneOnOnePointsAttributes.add(attr);
    }

    if (_oneOnOnePointsAttributes.isNotEmpty) {
      oneOnOneObj.oneOnOnePointsAttributes = _oneOnOnePointsAttributes;
      dataUpdated = true;
    }
    if (dataUpdated == false) {
      Navigator.pop(context);
      return;
    }
    showLoader(context);
    var request = OneOnOneCreateRequest(oneOnOne: oneOnOneObj);
    debugPrint("request ----->>11>$request");
    ApiManager.authenticated
        .updateOneOnOneDetails(request, oneOnOneData?.id ?? 0)
        .then((val) {
      hideLoader();
      logger.e('update OneOnOne response -- ${val.toJson()}');
      localGoodAtList.clear();
      localYetToImproveList.clear();
      _oneOnOnePointsAttributes.clear();
      Navigator.pop(context);
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

  Widget yetToImproveBottomView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              constants.yetToImproveTitleText,
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            Visibility(
              visible: hasAccessForUpdate1on1,
              child: TextButton(
                  onPressed: () async {
                    getAddedPointsList(localYetToImproveList, "",
                        localYetToImproveList.length, false);
                  },
                  child: const Text(
                    constants.addPoints,
                    style: TextStyle(
                      color: Color.fromRGBO(22, 97, 210, 1),
                      fontFamily: constants.uberMoveFont,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            )
          ],
        ),
        addVerticalSpace(10),
        Visibility(
            visible: localYetToImproveList.isEmpty,
            child: showEmptyPointsView(constants.yetToImprovePoints)),
        buildYetToImproveList(),
      ],
    );
  }

  Widget showEmptyPointsView(String pointTypeText) {
    return ListTile(
        title: Text(
      hasAccessForUpdate1on1
          ? "${constants.clickToAddPoints} $pointTypeText"
          : constants.notAvailableText,
      style: const TextStyle(
          fontFamily: constants.uberMoveFont,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color.fromRGBO(0, 0, 0, 1)),
    ));
  }

  Widget buildYetToImproveList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: localYetToImproveList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 0.0),
      itemBuilder: (context, index) {
        var yetToImprovePoint = localYetToImproveList[index];
        var isMarked = yetToImprovePoint.markAsDone ?? false;

        return ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu),
              yetToImprovePoint.id != null
                  ? const SizedBox(width: 12.0)
                  : const Text(""),
              Visibility(
                visible: yetToImprovePoint.id != null,
                child: InkWell(
                  onTap: () {
                    if (yetToImprovePoint.id != null) {
                      _employeeYetToImprovePointStatuUpdate(
                          context, !isMarked, yetToImprovePoint.id ?? 0);
                    }
                  },
                  child: isMarked
                      ? const Icon(Icons.check_box_outlined)
                      : const Icon(Icons.check_box_outline_blank),
                ),
              ),
            ],
          ),
          title: Text(
            yetToImprovePoint.title,
            style: const TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(0, 0, 0, 1)),
          ),
          onTap: () async {
            if (hasAccessForUpdate1on1) {
              getAddedPointsList(
                  localYetToImproveList, yetToImprovePoint.title, index, false);
            }
          },
        );
      },
    );
  }

  _employeeYetToImprovePointStatuUpdate(
      BuildContext context, bool status, int pointId) async {
    var oneOnOnePoint = OneOnOnePoint(markAsDone: status);
    PointRequest request = PointRequest(oneOnOnePoint: oneOnOnePoint);
    showLoader(context);
    _apiService.updateOneOnOnePointStatus(request, pointId).then((value) {
      PointResponse? response = value.data;
      if (value.getException != null) {
        hideLoader();
        ErrorHandler errorHandler = value.getException;
        String msg = errorHandler.getErrorMessage();

        displaySnackbar(context, msg);
      } else {
        hideLoader();
      }
      refreshScreen();
    });
  }

  refreshScreen() {
    var newFuture =
        ApiManager.authenticated.fetchOneOnOneDetails(oneOnOneData?.id ?? 0);
    setUpdateOneOnOneFuture(newFuture);
  }

  Widget gootAtBottomView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              constants.goodAtTitleText,
              style: TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            Visibility(
              visible: hasAccessForUpdate1on1,
              child: TextButton(
                  onPressed: () async {
                    getAddedPointsList(
                        localGoodAtList, "", localGoodAtList.length, true);
                  },
                  child: const Text(
                    constants.addPoints,
                    style: TextStyle(
                      color: Color.fromRGBO(22, 97, 210, 1),
                      fontFamily: constants.uberMoveFont,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            )
          ],
        ),
        addVerticalSpace(10),
        Visibility(
            visible: localGoodAtList.isEmpty,
            child: showEmptyPointsView(constants.goodAtPointsText)),
        buildGoodAtList(),
      ],
    );
  }

  Widget buildGoodAtList() {
    debugPrint("localGoodAtList2 length ------>>11> ${localGoodAtList.length}");
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: localGoodAtList.length,
      separatorBuilder: (context, index) => const SizedBox(height: 0.0),
      itemBuilder: (context, index) {
        var goodAtPoint = localGoodAtList[index];
        return ListTile(
          leading: const Icon(Icons.menu),
          title: Text(
            goodAtPoint.title,
            style: const TextStyle(
                fontFamily: constants.uberMoveFont,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(0, 0, 0, 1)),
          ),
          onTap: () async {
            if (hasAccessForUpdate1on1) {
              getAddedPointsList(
                  localGoodAtList, goodAtPoint.title, index, true);
            }
          },
        );
      },
    );
  }

  Widget showEmployeeAvatar(Employee? selectedEmployee) {
    return CircleAvatar(
      backgroundColor: colorPrimary,
      maxRadius: 58.0,
      foregroundImage: selectedEmployee?.getAvatarImage(),
      child: Text(
        getInitials(selectedEmployee?.name ?? constants.invalidEmployee, 2),
        style: const TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );
  }

  refreshList() {
    setState(() {
    });
    Navigator.pop(context);
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

  showValidationAlert(BuildContext context, String alertText) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text(constants.okButton),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text(constants.cancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(alertText),
      actions: [okButton, cancelButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> getAddedPointsList(List<Point> listOfPoints, String pointTitle,
      int index, bool isFromGoodAt) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOrUpdateOneOnOneFeedbackPointsView(
          addedPointText: pointTitle,
          index: index,
          isFromGoodAtList: isFromGoodAt,
        ),
      ),
    );
    if (result != null && result is String) {
      setState(() {
        if (pointTitle.isEmpty) {
          listOfPoints.add((Point(title: result)));
        } else {
          if (listOfPoints.isNotEmpty) {
            var point = listOfPoints[index];
            listOfPoints[index] = (Point(id: point.id, title: result));
          }
        }
      });
    }
  }
}
