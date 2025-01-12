import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:notification_center/notification_center.dart';
import 'package:oneononetalks/api_services/models/employee.dart';
import 'package:oneononetalks/api_services/models/employee_create_request.dart';
import 'package:oneononetalks/main.dart';
import 'package:oneononetalks/managers/apiservice_manager.dart';
import 'package:oneononetalks/managers/environment_manager.dart';
import 'package:oneononetalks/screens/oneOnOne/select_employee_view.dart';
import 'package:oneononetalks/theme/theme_constants.dart';
import 'package:oneononetalks/utils/helper_widgets.dart';
import 'package:oneononetalks/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:oneononetalks/utils/notification_constants.dart'
    as notificationconstants;

class CreateEmployeeView extends StatefulWidget {
  const CreateEmployeeView({super.key});

  @override
  State<CreateEmployeeView> createState() => _CreateEmployeeViewState();
}

class _CreateEmployeeViewState extends State<CreateEmployeeView> {
  String? _enteredName;
  var isNameValidated = false;
  String? _enteredRole;
  var isRoleValidated = false;
  String? _enteredEmpId;
  var isEmpIdValidated = false;
  String? _enteredMobile;
  var isMobileValidated = false;
  String? _enteredEmail;
  var isEmailValidated = false;

  Employee selectedEmployee = Employee();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: EnvironmentManager.isProdEnv == true ? colorProductionHeader : colorStagingHeader,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: colorText),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            constants.addEmployee,
            style: TextStyle(
              fontFamily: constants.uberMoveFont,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  addVerticalSpace(10.0),
                  addEmployeeImage(),
                  Column(children: [
                    const Row(
                      children: [
                        Text(
                          constants.name,
                          style: TextStyle(
                            fontFamily: constants.uberMoveFont,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    addVerticalSpace(8),
                    TextFormField(
                      autofocus: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      minLines: 1,
                      maxLines: 1,
                      maxLength: 30,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      onChanged: (name) {
                        setState(() {
                          isNameValidated = name.isNotEmpty;
                        });
                        _enteredName = name;
                      },
                      validator: (name) {
                        if (name!.isNotEmpty) {
                          return null;
                        } else if (name.isEmpty){
                          return null;
                        } else {
                          return constants.nameValidMsg;
                        }
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: constants.dummyName,
                        hintStyle: TextStyle(
                                    fontFamily: constants.uberMoveFont,
                                    color: Color.fromRGBO(111, 111, 111, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                    ),
                  ]),
                  addVerticalSpace(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                constants.role,
                                style: TextStyle(
                                  fontFamily: constants.uberMoveFont,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          addVerticalSpace(8),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 28,
                            child: TextFormField(
                              autofocus: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              minLines: 1,
                              maxLines: 1,
                              maxLength: 20,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              onChanged: (role) {
                                setState(() {
                                  isRoleValidated = role.isNotEmpty;
                                });
                                _enteredRole = role;
                              },
                              validator: (role) {
                                if (role!.isNotEmpty) {
                                  return null;
                                } else if(role.isEmpty){
                                  return null;
                                }
                                else {
                                  return constants.roleValidMsg;
                                }
                              },
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                hintText: constants.dummyRole,
                                hintStyle: TextStyle(
                                    fontFamily: constants.uberMoveFont,
                                    color: Color.fromRGBO(111, 111, 111, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
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
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                            ),
                          ),
                        ],
                      ),
                      addHorizontalSpace(16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                constants.empId,
                                style: TextStyle(
                                  fontFamily: constants.uberMoveFont,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          addVerticalSpace(8),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 2) - 28,
                            child: TextFormField(
                              autofocus: false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              minLines: 1,
                              maxLines: 1,
                              maxLength: 10,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              onChanged: (empId) {
                                setState(() {
                                  isEmpIdValidated = empId.isNotEmpty;
                                });
                                _enteredEmpId = empId;
                              },
                              validator: (empId) {
                                if (empId!.isNotEmpty || empId.isEmpty) {
                                  return null;
                                } else {
                                  return constants.empIdValidMsg;
                                }
                              },
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                hintText: constants.dummyEmpId,
                                hintStyle: TextStyle(
                                    fontFamily: constants.uberMoveFont,
                                    color: Color.fromRGBO(111, 111, 111, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
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
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  addVerticalSpace(8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            constants.emailId,
                            style: TextStyle(
                              fontFamily: constants.uberMoveFont,
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      addVerticalSpace(8),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width),
                        child: TextFormField(
                          autofocus: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelText: null,
                            errorStyle: TextStyle(
                              fontFamily: constants.uberMoveFont,
                            ),
                            hintText: constants.dummyEmailId,
                            hintStyle: TextStyle(
                                    fontFamily: constants.uberMoveFont,
                                    color: Color.fromRGBO(111, 111, 111, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 18, 17, 17),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 18, 17, 17),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 18, 17, 17),
                              ),
                            ),
                          ),
                          style: const TextStyle(
                                fontFamily: constants.uberMoveFont,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1)
                          ),
                          onChanged: (email) {
                            setState(() {
                              isEmailValidated = EmailValidator.validate(email);
                            });
                            _enteredEmail = email;
                          },
                          validator: (email) {
                            if (email?.isEmpty == true || (email != null && EmailValidator.validate(email))) {
                              return null;
                            } 
                            return constants.enterValidEmailText;
                          },
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(24),
                  Column(children: [
                    const Row(
                      children: [
                        Text(
                          constants.mobileNumber,
                          style: TextStyle(
                            fontFamily: constants.uberMoveFont,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    addVerticalSpace(8),
                    TextFormField(
                      autofocus: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      minLines: 1,
                      maxLines: 1,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (mobile) {
                        setState(() {
                          isMobileValidated = mobile.isValidPhone;
                        });
                        _enteredMobile = mobile;
                      },
                      validator: (mobile) {
                        if (mobile?.isEmpty == true ||(mobile != null && mobile.isValidPhone)) {
                          return null;
                        } else {
                          return constants.mobileValidMsg;
                        }
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: constants.dummyMobileNumber,
                        hintStyle: TextStyle(
                                    fontFamily: constants.uberMoveFont,
                                    color: Color.fromRGBO(111, 111, 111, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                    ),
                  ]),
                  addVerticalSpace(8),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            constants.selectReportingManager,
                            style: TextStyle(
                              fontFamily: constants.uberMoveFont,
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpace(8.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 51.0,
                        child: TextButton(
                          onPressed: () async {
                            // if(isEmployeeEdite == true) {
                            final result = await showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) => const SelectEmployeeView(),
                            );
                            setState(() {
                              if (result != null) {
                                selectedEmployee = result as Employee;
                              }
                            });
                            logger.e("result - ${selectedEmployee.name}");
                            // }
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            side:
                                const BorderSide(color: colorText, width: 1.0),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                (selectedEmployee.name != null)
                                    ? showEmployeeAvatar()
                                    : const Text(''),
                                addHorizontalSpace(5),
                                Text(
                                  selectedEmployee.name != null
                                      ? selectedEmployee.name ?? ""
                                      : constants.serachManager,
                                  style: const TextStyle(
                                    color: colorText,
                                    fontFamily: constants.uberMoveFont,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpace(24),
                  Column(
                    children: [
                      const Center(
                        child: Text(
                          constants.screenDiscription,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: constants.uberMoveFont,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      addVerticalSpace(8.0),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 51.0,
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 58.0,
                            onPressed: () {
                              debugPrint("clicked on create ----->>>>");
                              if (_formKey.currentState!.validate()) {
                                // Navigator.of(context).push();
                                 showLoader(context);
                                 _createEmployeeRequest(context);
                              }
                            },
                            // ignore: sort_child_properties_last
                            child: const Text(constants.add),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            color: const Color.fromRGBO(0, 0, 0, 1),
                            textColor: Colors.white,
                          )),
                    ],
                  ),
                  addVerticalSpace(12),
                ])),
          ),
        ));
  }

   _createEmployeeRequest(BuildContext context) async {

    var employeeObj = Employee(
        name: _enteredName,
        designation: _enteredRole,
        employeeNo: _enteredEmpId,
        email: _enteredEmail,
        mobileNumber: _enteredMobile);

        if(selectedEmployee.id != null){
          employeeObj.reportingManagerId = selectedEmployee.id;
        }

    var request = EmployeeCreateRequest(employee: employeeObj);
    ApiManager.authenticated.createEmployee(request).then((val) {
      hideLoader();
      logger.e('createOneOnOne response -- ${val.toJson()}');
      NotificationCenter().notify(notificationconstants.updatingNewEmployee);
      Navigator.pop(context);
    }).catchError((obj) {
      hideLoader();
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

  Widget showEmployeeAvatar() {
    return CircleAvatar(
      backgroundColor: colorPrimary,
      maxRadius: 18.0,
      foregroundImage:  selectedEmployee.getAvatarImage(),
      child: Text(
        getInitials(selectedEmployee.name ?? "", 2),
        style: const TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(255, 255, 255, 1)),
      ),
    );
  }

  Padding addEmployeeImage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 54.0),
        child: Image.asset(
          'assets/addEmployee.png',
        ) // Image.asset
        );
  }
}

extension validateFormStrings on String {
  bool get isNotNull {
    return this != null;
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
