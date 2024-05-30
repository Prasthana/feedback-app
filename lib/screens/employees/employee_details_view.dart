import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/api_services/models/employeedetailsresponse.dart';
import 'package:feedbackapp/api_services/models/logintoken.dart';
import 'package:feedbackapp/api_services/models/one_on_one_create_response.dart';
import 'package:feedbackapp/api_services/models/one_on_ones_list_response.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/date_formaters.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:feedbackapp/theme/theme_constants.dart' as themeconstants;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeDetailsView extends StatefulWidget {
  const EmployeeDetailsView({super.key, required this.mEmployee});

  final Employee mEmployee;

  @override
  State<EmployeeDetailsView> createState() => _EmployeeDetailsViewState();
}

class _EmployeeDetailsViewState extends State<EmployeeDetailsView> {
  Future<EmployeeDetailsResponse>? employeeFuture;
  Future<OneOnOnesListResponse>? oneOnOneFuture;
  bool isLoginEmployee = false;
  bool isUpdating = false;

  Employee? mEmployee;

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
      final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 70,
      );

      File file1 = File(result!.path);
      print(file.lengthSync());
      print(file1.lengthSync());

      var employeeFuture = ApiManager.authenticated
          .updateEmployeesDetails(mEmployee?.id ?? 0, file1);

      setEmployeeFuture(employeeFuture);
    }
  }

  void setEmployeeFuture(Future<EmployeeDetailsResponse>? newValue) {
    setState(() {
      this.employeeFuture = newValue;
      this.isUpdating = true;
    });
  }

  void setIsLoginEmployee(bool newValue) {
    setState(() {
      isLoginEmployee = newValue;
    });
  }

  @override
  void initState() {
    this.mEmployee = widget.mEmployee;
    checkLoginstatus(mEmployee?.id ?? 0);
    employeeFuture = ApiManager.authenticated.fetchEmployeesDetails(mEmployee?.id ?? 0);

    super.initState();
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
          oneOnOneFuture = ApiManager.authenticated.fetchEmployeePastOneOnOns(constants.historyOneOnOnes, mEmployee?.id ?? 0);
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
        // title: Text(mEmployee.name ?? ""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(0, 0, 0, 1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
          child: Column( 
        children: [ 
         FutureBuilder<EmployeeDetailsResponse>(
          future: employeeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return isUpdating
                  ? buildEmployeeDetailsView(mEmployee)
                  : const CircularProgressIndicator();
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
              return const CircularProgressIndicator();
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
        ]
        ) 
        ),
    );
  }


  Widget buildOneOnOnesView(List<OneOnOneCreate>? oneOnOneList) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: oneOnOneList?.length,
        itemBuilder: (BuildContext context, int index) {
          var oneOnOne = oneOnOneList?[index];
          String startTime = getFormatedDateConvertion(oneOnOne?.startDateTime ?? "", "dd-MM-yyyy");
          // String endTime = getFormatedTime(oneOnOne.endDateTime ?? "", "dd-MM-yyyy");
          // var yet_to_improve_points = oneOnOne?.yetToImprovePoints?.length ?? 0;
          return Column(
            children: <Widget>[
              ListTile(
                trailing: const Icon(Icons.chevron_right),
                title: Text(
                  "$startTime",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                subtitle: Text(
                  "$oneOnOne.startTime",
                  style: const TextStyle(
                      fontFamily: constants.uberMoveFont,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                // onTap: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employeeList![index])),);
                // }, 
              ),
              const Divider(
                color: Color.fromRGBO(195, 195, 195, 1),
                height: 3.0,
                thickness: 1.0,
                indent: 12.0,
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
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text(constants.camera),
                                onTap: () => {
                                  getImage(constants.camera),
                                  // this is how you dismiss the modal bottom sheet after making a choice
                                  Navigator.pop(context),
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text(constants.gallery),
                                onTap: () => {
                                  getImage(constants.gallery),
                                  // dismiss the modal sheet
                                  Navigator.pop(context),
                                },
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
              child: 
              CircleAvatar(
                backgroundColor: themeconstants.colorPrimary,
                maxRadius: 64.0,
                // backgroundImage: NetworkImage(employee?.avatarAttachmentUrl ?? ""),

                child: Stack(children: [
                  Visibility(
                    visible: employee?.avatarAttachmentUrl != null,
                    child: ClipOval(
                      child: Align(
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: employee?.avatarAttachmentUrl ?? "",
                          fit: BoxFit.contain,
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
              visible: isLoginEmployee,
              child: const Center(
                child: Text(
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
            addVerticalSpace(8),
            Visibility(
              visible: isLoginEmployee,
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
                          onPressed: () {},
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
                      SizedBox(
                        width: 144.0,
                        height: 40.0,
                        child: TextButton(
                          onPressed: () {},
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
            Visibility(
                visible: isLoginEmployee,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Image.asset('assets/icApplock.png', height: 38),
                      trailing: const Icon(Icons.chevron_right),
                      title: const Text(
                        constants.appLock,
                        style: TextStyle(
                            fontFamily: constants.uberMoveFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employeeList![index])),);
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
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeDetailsView(mEmployee: employeeList![index])),);
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
                )
              ),

          ],
        ));
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

  String getInitials(String string, [int limitTo = 2]) {
    if (string.isEmpty) {
      return '';
    }

    var buffer = StringBuffer();
    var split = string.split(' ');

    //For one word
    if (split.length == 1) {
      return string.substring(0, 1);
    }

    for (var i = 0; i < (limitTo); i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }
}
