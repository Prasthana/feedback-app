import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:feedbackapp/api_services/models/employee.dart';
import 'package:feedbackapp/main.dart';
import 'package:feedbackapp/screens/oneOnOne/select_employee_view.dart';
import 'package:feedbackapp/theme/theme_constants.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:feedbackapp/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CreateEployeeView extends StatefulWidget {
  CreateEployeeView({super.key});

  @override
  State<CreateEployeeView> createState() => _CreateEployeeViewState();
}

class _CreateEployeeViewState extends State<CreateEployeeView> {
  String? _enteredEmail;
  var isEmailValidated = false;
  Employee selectedEmployee = Employee();

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
                      minLines: 1,
                      maxLines: 1,
                      maxLength: 30,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: constants.dummyName,
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            fontSize: 14),
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
                        fontWeight: FontWeight.w500,
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
                              minLines: 1,
                              maxLines: 1,
                              maxLength: 20,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                hintText: constants.dummyRole,
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(111, 111, 111, 1),
                                    fontSize: 14),
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
                                fontWeight: FontWeight.w500,
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
                              minLines: 1,
                              maxLines: 1,
                              maxLength: 10,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                hintText: constants.dummyEmpId,
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(111, 111, 111, 1),
                                    fontSize: 14),
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
                                fontWeight: FontWeight.w500,
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
                          autofocus: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: null,
                            errorStyle: TextStyle(
                              fontFamily: constants.uberMoveFont,
                            ),
                            hintText: constants.dummyEmailId,
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
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (email) {
                            setState(() {
                              isEmailValidated = EmailValidator.validate(email);
                            });
                            _enteredEmail = email;
                          },
                          validator: (email) {
                            if (email != null &&
                                EmailValidator.validate(email)) {
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
                      minLines: 1,
                      maxLines: 1,
                      maxLength: 10,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: constants.dummyMobileNumber,
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(111, 111, 111, 1),
                            fontSize: 14),
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
                        fontWeight: FontWeight.w500,
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
                                      : constants.searchEmployeeText,
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
                ]))));
  }

  Widget showEmployeeAvatar() {
    return CircleAvatar(
      backgroundColor: colorPrimary,
      maxRadius: 18.0,
      foregroundImage: CachedNetworkImageProvider(selectedEmployee.avatarAttachmentUrl ?? ""),
      child: Text(
        getInitials(selectedEmployee.name?.toUpperCase() ?? "", 2),
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
