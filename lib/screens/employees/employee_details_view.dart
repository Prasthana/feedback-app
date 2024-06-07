import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oneononetalks/api_services/api_service.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/employeedetailsresponse.dart';
import 'package:oneononetalks/api_services/models/employeerequest.dart';
import 'package:oneononetalks/api_services/models/logintoken.dart';
import 'package:oneononetalks/api_services/models/one_on_ones_list_response.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/api_services/models/preparecallresponse.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/storage_manager.dart';
import 'package:oneononetalks/screens/employees/create_employee_view.dart';
import 'package:oneononetalks/screens/login/login_view.dart';
import 'package:oneononetalks/screens/oneOnOne/create_1on1_view.dart';
import 'package:oneononetalks/screens/oneOnOne/update_1on1_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/date_formaters.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:oneononetalks/theme/theme_constants.dart' as themeconstants;
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:system_date_time_format/system_date_time_format.dart';

class EmployeeDetailsView extends StatefulWidget {
  const EmployeeDetailsView({super.key, required this.mEmployee});

  final Employee mEmployee;

  @override
  State<EmployeeDetailsView> createState() => _EmployeeDetailsViewState();
}

class _EmployeeDetailsViewState extends State<EmployeeDetailsView> {
  Future<EmployeeDetailsResponse>? employeeFuture;
  Future<OneOnOnesListResponse>? oneOnOneFuture;
  final ApiService _apiService = ApiService();
  bool isLoginEmployee = false;
  bool isUpdating = false;
  bool addMobileNumber = false;
  bool hasAccessToCreate1On1 = false;
  bool hasProfileUrl = false;
  String mobileNumber = "";

  Employee? mEmployee;
  late String systemFormateDateTime;

  Future getSystemFormateDateTime() async {
    final datePattern = await SystemDateTimeFormat().getLongDatePattern();
    final timePattern = await SystemDateTimeFormat().getTimePattern();
    systemFormateDateTime = "$datePattern $timePattern";
    systemFormateDateTime;
  }

  Future updateMobileNumber(String mobile) async {
    var employeerequest =
        EmployeeRequest(name: mEmployee?.name ?? "", mobileNumber: mobile);

    var employeeFuture = ApiManager.authenticated
        .updateEmployeesMobile(mEmployee?.id ?? 0, employeerequest);

    setEmployeeFuture(employeeFuture);
  }

  Future getImage(String type) async {
    XFile? image;
    if (type == constants.camera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      File file = File(image.path);
      final filePath = file.absolute.path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 70,
      );

      File file1 = File(result!.path);

      var employeeFuture = ApiManager.authenticated
          .updateEmployeesDetails(mEmployee?.id ?? 0, file1);

      setEmployeeFuture(employeeFuture);
    }
  }

  void deleteProfilePic(int empId){
     _apiService.deleteProfilePic(empId).then((value) {
      HttpResponse? response = value.data;
      var employeeFuture = ApiManager.authenticated.fetchEmployeesDetails(mEmployee?.id ?? 0);
      setEmployeeFuture(employeeFuture);  
    });
  }
 
  void setEmployeeFuture(Future<EmployeeDetailsResponse>? newValue) {
    setState(() {
      employeeFuture = newValue;
      isUpdating = true;
    });
  }

  void setAddMobileNumber(bool newValue) {
    setState(() {
      addMobileNumber = newValue;
    });
  }

  void setIsLoginEmployee(bool newValue) {
    setState(() {
      isLoginEmployee = newValue;
    });
  }

  void setMobileNumber(String newValue) {
    setState(() {
      mobileNumber = newValue;
    });
  }

  void setCanCreate1On1(bool newValue) {
    setState(() {
      hasAccessToCreate1On1 = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
    mEmployee = widget.mEmployee;
    checkLoginstatus(mEmployee?.id ?? 0);
    checkCanCreate1On1();
    setMobileNumber(mEmployee?.mobileNumber ?? "");

    employeeFuture =
        ApiManager.authenticated.fetchEmployeesDetails(mEmployee?.id ?? 0);
  }

  void checkCanCreate1On1() {
    var sm = StorageManager();
    sm.getData(constants.prepareCallResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mPrepareCallResponse = PrepareCallResponse.fromJson(json);
        logger.d('val -- $json');
        Permission? tabCreate1On1Access =
            mPrepareCallResponse.user?.permissions?["one_on_ones.create"];
        if (tabCreate1On1Access?.access == Access.enabled) {
          setCanCreate1On1(true);
        } else {
          setCanCreate1On1(false);
        }
      } else {
        setCanCreate1On1(false);
      }
    });
  }

  void checkLoginstatus(int employeeId) {
    var sm = StorageManager();
    sm.getData(constants.loginTokenResponse).then((val) {
      if (val != constants.noDataFound) {
        Map<String, dynamic> json = jsonDecode(val);
        var mLoginTokenResponse = LoginTokenResponse.fromJson(json);
        logger.d('val -- $json');
        if (mLoginTokenResponse.user != null &&
            mLoginTokenResponse.user?.employeeId == employeeId) {
          setIsLoginEmployee(true);
        } else {
          setIsLoginEmployee(false);
          oneOnOneFuture = ApiManager.authenticated.fetchEmployeePastOneOnOns(
              constants.historyOneOnOnes, mEmployee?.id ?? 0);
        }
      } else {
        setIsLoginEmployee(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(0, 0, 0, 1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        FutureBuilder<EmployeeDetailsResponse>(
          future: employeeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return isUpdating
                  ? buildEmployeeDetailsView(mEmployee)
                  : SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
            } else if (snapshot.hasData) {
              final employeeResponse = snapshot.data;
              if (employeeResponse?.employee != null) {
                mEmployee = employeeResponse?.employee;
                return buildEmployeeDetailsView(employeeResponse?.employee);
              } else {
                return buildEmployeeDetailsView(mEmployee);
              }
            } else {
              return buildEmployeeDetailsView(mEmployee);
            }
          },
        ),
        FutureBuilder<OneOnOnesListResponse>(
          future: oneOnOneFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              final oneOnOnesListResponse = snapshot.data;
              var listCount = oneOnOnesListResponse?.oneononesList?.length ?? 0;
              if (listCount > 0 && isLoginEmployee == false) {
                return buildOneOnOnesView(oneOnOnesListResponse?.oneononesList);
              } else {
                return buildOneOnOnesView(List.empty());
              }
            } else {
              return buildOneOnOnesView(List.empty());
            }
          },
        ),
      ])),
    );
  }

  Widget buildOneOnOnesView(List<OneOnOne>? oneOnOneList) {
    getSystemFormateDateTime();
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: oneOnOneList?.length,
        itemBuilder: (BuildContext context, int index) {
          var oneOnOne = oneOnOneList?[index];
          var startDateTime = oneOnOne?.startDateTime ?? "";
          String startTime = startDateTime.utcToLocalDate(systemFormateDateTime);
          var yetToImprovePoints = oneOnOne?.yetToImprovePoints?.length ?? 0;
          return Column(
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(28.0, 0, 16.0, 0),
                trailing: const Icon(Icons.chevron_right),
                title: Text(
                  startTime,
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                subtitle: Text(
                  '$yetToImprovePoints ${constants.openYetToImprove}',
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateOneoneOneView(oneOnOneData: oneOnOne),
                      ));
                },
              ),
              const Divider(
                color: Color.fromRGBO(195, 195, 195, 1),
                height: 3.0,
                thickness: 1.0,
                indent: 28.0,
                endIndent: 0,
              ),
            ],
          );
        });
  }

  Widget buildEmployeeDetailsView(Employee? employee) {
    if (isUpdating) {
      employee?.avatarAttachmentUrl = "";
    }
    hasProfileUrl = employee?.avatarAttachmentUrl?.isEmpty == false && employee?.avatarAttachmentUrl?.isNotNull == true;
    isUpdating = false;
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            addVerticalSpace(12),
            GestureDetector(
              onTap: () {
                if (isLoginEmployee) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                       Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                           const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                constants.profilePicture,
                                                style: TextStyle(
                                                    fontFamily:
                                                        constants.uberMoveFont,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1)),
                                              ),
                                            ),
                                             Visibility(
                                              visible: hasProfileUrl,
                                              child: Align(
                                              alignment: Alignment.centerRight,
                                              child: IconButton(
                                                iconSize: 24.0,
                                                icon: const Icon(Icons.delete),
                                                tooltip: constants.profilePicture,
                                                onPressed: () {
                                                  deleteProfilePic(mEmployee?.id ?? 0);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            )
                                            )
                                          ]),
                                      addVerticalSpace(24),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(children: <Widget>[
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  iconSize: 36.0,
                                                  icon: const Icon(Icons.camera),
                                                  tooltip:
                                                      constants.profilePicture,
                                                  onPressed: () {
                                                    getImage(constants.camera);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                  child: const Text(
                                                      constants.camera,
                                                      style: TextStyle(
                                                          fontFamily: constants
                                                              .uberMoveFont,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color.fromRGBO(
                                                              4, 4, 4, 1))),
                                                  onTap: () {
                                                    getImage(constants.camera);
                                                    Navigator.pop(context);
                                                  })
                                            ]),
                                            addVerticalSpace(24),
                                            Column(children: <Widget>[
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  iconSize: 36.0,
                                                  icon: const Icon(Icons.image),
                                                  tooltip:
                                                      constants.profilePicture,
                                                  onPressed: () {
                                                    getImage(constants.gallery);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    getImage(constants.gallery);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                      constants.gallery,
                                                      style: TextStyle(
                                                          fontFamily: constants
                                                              .uberMoveFont,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color.fromRGBO(
                                                              4, 4, 4, 1)))),
                                            ]),
                                          ])
                                    ]),
                              )
                            ],
                          ),
                        );
                      });
                }
              },
              child: CircleAvatar(
                backgroundColor: themeconstants.colorPrimary,
                maxRadius: 64.0,
                // backgroundImage: CachedNetworkImageProvider(employee?.avatarAttachmentUrl ?? ""),

                child: Stack(children: [
                  Visibility(
                    visible: employee?.avatarAttachmentUrl != null,
                    child: ClipOval(
                      child: Align(
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: employee?.avatarAttachmentUrl ?? "",
                          height: 128.0,
                          width: 128.0,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => url == ""
                              ? const Center(child: CircularProgressIndicator())
                              : const Icon(Icons.account_circle),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isLoginEmployee,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white70,
                        child: Icon(Icons.camera_alt),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      getInitials(employee?.name ?? "",
                          employee?.avatarAttachmentUrl == null ? 2 : 0),
                      style: const TextStyle(
                          fontFamily: constants.uberMoveFont,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  )
                ]),
              ),
            ),
            addVerticalSpace(12),
            Center(
              child: Text(
                employee?.name ?? "",
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
                employee?.designation ?? "",
                style: const TextStyle(
                    fontFamily: constants.uberMoveFont,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(4, 4, 4, 1)),
              ),
            ),
            addVerticalSpace(8),
            Visibility(
              visible: isLoginEmployee &&
                  !(employee?.mobileNumber ?? "").isNotEmpty &&
                  addMobileNumber == false,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    setAddMobileNumber(true);
                  },
                  child: const Text(
                    constants.addMobileNumber,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(22, 97, 210, 1),
                        fontFamily: constants.uberMoveFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(22, 97, 210, 1)),
                  ),
                ),
              ),
            ),
            
            Visibility(
              visible: isLoginEmployee && ((employee?.mobileNumber ?? "").isNotEmpty && addMobileNumber == false),
              child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                    mEmployee?.mobileNumber ?? "",
                    style: const TextStyle(
                        fontFamily: constants.uberMoveFont,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(4, 4, 4, 1)),
                  ),

                  IconButton(
                  icon: const Icon(Icons.edit_square),
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  onPressed: () {
                    setAddMobileNumber(true);
                  },
                  )
                ],
              ),
            ),
            
            Visibility(
              visible: isLoginEmployee && addMobileNumber == true,
              child: Center(
                  child: SizedBox(
                width: 160.0,
                child: TextField(
                  autofocus: true,
                  showCursor: true,
                  textInputAction: TextInputAction.go,
                  keyboardType: const TextInputType.numberWithOptions(signed: true),
                  canRequestFocus: true,
                  onSubmitted: (value) {
                    setAddMobileNumber(false);
                    updateMobileNumber(value);
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textAlign: TextAlign.center,
                  controller: TextEditingController(
                      text: mEmployee?.mobileNumber ?? ""),
                  decoration: const InputDecoration.collapsed(
                    hintText: "",
                    fillColor: Colors.white,),
                  style: const TextStyle(
                      backgroundColor: Colors.white,
                      fontFamily: constants.uberMoveFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(4, 4, 4, 1)),
                ),
              )),
            ),
            addVerticalSpace(8),
            Visibility(
              visible: !isLoginEmployee,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addVerticalSpace(8),
                      SizedBox(
                        width: 144.0,
                        height: 40.0,
                        child: TextButton(
                          onPressed: () async {
                            // Android: Will open mail app or show native picker.
                            // iOS: Will open mail app if single mail app found.
                            var result = await OpenMailApp.openMailApp(
                              nativePickerTitle: 'Select email app to open',
                            );
                            if (!result.didOpen && !result.canOpen) {
                              showNoMailAppsDialog(context);
                            } else if (!result.didOpen && result.canOpen) {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return MailAppPickerDialog(
                                    mailApps: result.options,
                                  );
                                },
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            side:
                                const BorderSide(color: colorText, width: 1.0),
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ImageIcon(
                                  AssetImage('assets/icMailSent.png'),
                                  size: 24,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  constants.sendEmail,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: colorText,
                                    fontFamily: constants.uberMoveFont,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  addHorizontalSpace(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(8),
                      Visibility(
                        visible: hasAccessToCreate1On1,
                        child: SizedBox(
                          width: 144.0,
                          height: 40.0,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateOneOnOneView(
                                        mEmployee: employee)),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side: const BorderSide(
                                  color: colorText, width: 1.0),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ImageIcon(
                                    AssetImage('assets/icOneonOne.png'),
                                    size: 24,
                                    color: Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    constants.create1On1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: colorText,
                                      fontFamily: constants.uberMoveFont,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            addVerticalSpace(8),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0, 0),
                child: Text(
                  getSubsectionTitle(),
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(4, 4, 4, 1)),
                ),
              ),
            ),
            addVerticalSpace(6),
            // ToDo : V 1.0 its hidden
            // Visibility(
            //     visible: isLoginEmployee,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         ListTile(
            //           leading: Image.asset('assets/icApplock.png', height: 38),
            //           trailing: const Icon(Icons.chevron_right),
            //           title: const Text(
            //             constants.appLock,
            //             style: TextStyle(
            //                 fontFamily: constants.uberMoveFont,
            //                 fontSize: 17,
            //                 fontWeight: FontWeight.w500,
            //                 color: Color.fromRGBO(0, 0, 0, 1)),
            //           ),
            //           onTap: () {
            //             // Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employeeList![index])),);
            //           },
            //         ),
            //         const Divider(
            //           color: Color.fromRGBO(195, 195, 195, 1),
            //           height: 3.0,
            //           thickness: 1.0,
            //           indent: 68.0,
            //           endIndent: 0,
            //         ),
            //       ],
            //     )),
            Visibility(
                visible: isLoginEmployee,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Image.asset('assets/icLogout.png', height: 38),
                      trailing: const Icon(Icons.chevron_right),
                      title: const Text(
                        constants.logOut,
                        style: TextStyle(
                            fontFamily: constants.uberMoveFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      onTap: () {
                        showLogoutAlertDialog(context, constants.logoutDialogText);
                        // logoutUser();
                      },
                    ),
                    const Divider(
                      color: Color.fromRGBO(195, 195, 195, 1),
                      height: 3.0,
                      thickness: 1.0,
                      indent: 68.0,
                      endIndent: 0,
                    ),
                  ],
                )),
          ],
        ));
  }

  logoutUser() {
    var sm = StorageManager();

    sm.removeData(constants.loginTokenResponse).then((val) {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainTabView()));
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginView(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    });
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  String getSubsectionTitle() {
    String title = "";
    if (isLoginEmployee) {
      title = constants.settings;
    } else {
      title = constants.oneOnOneHistory;
    }
    return title;
  }

showLogoutAlertDialog(BuildContext context, String alertText) {
    // set up the button
    Widget cancelButton = TextButton(
      child: const Text(constants.cancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = TextButton(
      onPressed: () {
        logoutUser();
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.red, // Set the text color here
        ),
      child: const Text(constants.yes),
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(alertText),
      actions: [cancelButton, yesButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
