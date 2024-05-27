import 'package:feedbackapp/api_services/models/oneonones.dart';
import 'package:feedbackapp/managers/apiservice_manager.dart';
import 'package:feedbackapp/screens/oneOnOne/oneonone_from_date_view.dart';
import 'package:feedbackapp/utils/helper_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainHomePageView extends StatefulWidget {
  const MainHomePageView({super.key});

  @override
  State<MainHomePageView> createState() => _MainHomePageViewState();
}

class _MainHomePageViewState extends State<MainHomePageView> {
  // variable to call and store future list of posts
  Future<List<OneOnOne>> oneOnOnesFuture =
      ApiManager.authenticated.fetchOneOnOnesList();

/*
  // function to fetch data from api and return future list of posts
  static Future<List<OneOnOne>> getOneOnOnes() async {
    // var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
    // final response = await http.get(url, headers: {"Content-Type": "application/json"});
    // final List body = json.decode(response.body);
    // return body.map((e) => OneOnOne.fromJson(e)).toList();

    ApiManager.authenticated.fetchOneOnOnesList().then((oneOnOnesList) {
      // do some operation
      return oneOnOnesList;  
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<OneOnOne>>(
          future: oneOnOnesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final oneOnOnesList = snapshot.data!;
              return buildoneOnOnesList(oneOnOnesList);
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
        builder: (context) => const OneOnOneDateView(),
        enableDrag: true,
      );  


        },
        shape: const CircleBorder(),
        child: const Icon(Icons.calendar_month_outlined),
      ),
    );
  }

  Widget buildoneOnOnesList(List<OneOnOne> oneOnOnesList) {
    return ListView.builder(
      itemCount: oneOnOnesList.length,
      itemBuilder: (context, index) {
        final oneOnOne = oneOnOnesList[index];
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
                  flex: 3, child: Text(oneOnOne.participant?.name ?? "DUMMY")),
            ],
          ),
        );
      },
    );
  }
}
