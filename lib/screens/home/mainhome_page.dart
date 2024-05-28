import 'package:feedbackapp/api_services/models/oneononesresponse.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/managers/storage_manager.dart';
import 'package:feedbackapp/screens/login/login_view.dart';
import 'package:feedbackapp/screens/oneOnOne/create_1on1_view.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:network_logger/network_logger.dart';
import 'package:feedbackapp/utils/constants.dart' as constants;

class MainHomePageView extends StatefulWidget {
  const MainHomePageView({super.key});

  @override
  State<MainHomePageView> createState() => _MainHomePageViewState();
}

class _MainHomePageViewState extends State<MainHomePageView> {
  // variable to call and store future list of posts
  Future<OneOnOnesResponse> oneOnOnesFuture =
      ApiManager.authenticated.fetchOneOnOnesList();

  @override
  void initState() {
    NetworkLoggerOverlay.attachTo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(constants.oneOneOnScreenTitle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
                logoutUser();
              },
            )
          ]),
      body: Center(
        child: FutureBuilder<OneOnOnesResponse>(
          future: oneOnOnesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final oneOnOnesResponse = snapshot.data;
              var listCount = oneOnOnesResponse?.oneononesList?.length ?? 0;
              if (listCount > 0) {
                return buildoneOnOnesList(oneOnOnesResponse);
              } else {
                return buildEmptyListView();
              }
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('clickeed on calender ------>>>');
      // used modal_bottom_sheet - to model present
      showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => const CreateOneOnOneView(),
        enableDrag: true,
      );  


        },
        shape: const CircleBorder(),
        child: const Icon(Icons.calendar_month_outlined),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget buildoneOnOnesList(OneOnOnesResponse? OneOnOnesResponse) {
    return ListView.builder(
      itemCount: OneOnOnesResponse?.oneononesList?.length ?? 0,
      itemBuilder: (context, index) {
        final oneOnOne = OneOnOnesResponse?.oneononesList?[index];
        return Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Image.asset('assets/splash-image.png')),
              addHorizontalSpace(10),
              Expanded(
                  flex: 3, child: Text(oneOnOne?.participant?.name ?? "DUMMY")),
            ],
          ),
        );
      },
    );
  }

  Widget buildEmptyListView() {
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
                'No 1-on-1 Meetings scheduled',
                style: TextStyle(
                  fontFamily: constants.uberMoveFont,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
              addVerticalSpace(20),
              const Text(
                'You can create a 1-on-1 meeting by clicking on the calendar icon below.',
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
}
