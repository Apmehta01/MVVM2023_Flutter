import 'package:flutter/material.dart';
import 'package:mydemomvvm/res/appColors.dart';
import 'package:mydemomvvm/utils/Constants.dart';
import 'package:mydemomvvm/utils/routes/routes_name.dart';
import 'package:mydemomvvm/viewmodel/home_screen_view_model.dart';
import 'package:mydemomvvm/viewmodel/user_view_model.dart';
import 'package:mydemomvvm/web/model/base/api_response.dart';
import 'package:mydemomvvm/web/model/base/status.dart';
import 'package:mydemomvvm/web/model/response/homeScreenResponse.dart';
import 'package:provider/provider.dart';

import '../utils/uiUtils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel homeScreenViewModel = HomeScreenViewModel();

  @override
  void initState() {
    homeScreenViewModel.fetchHomeScreeenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.COLORS_PRIMARY_ONE,
                  AppColors.COLORS_PRIMARY_ONE,
                ], // Define your gradient colors here
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(Constants.APP_NAME,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
          actions: [
            InkWell(
              onTap: () {
                userPreference.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: Center(
                  child: (Text(Constants.LOGOUT,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 18)))),
            ),
            const SizedBox(
              width: 30,
            )
          ],
        ),
        body: ChangeNotifierProvider<HomeScreenViewModel>(
          create: (BuildContext context) => homeScreenViewModel,
          child: Consumer<HomeScreenViewModel>(
            builder: (context, value, _) {
              switch (value.homeScreenUserList.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(backgroundColor: Colors.white,
                      color: AppColors.COLORS_PRIMARY_ONE,
                      strokeWidth: 5),
                  );
                case Status.COMPLETED:
                  return showHomeScreenUserList(value.homeScreenUserList);
                case Status.ERROR:
                  return Center(child: Text(Constants.NO_DATA_FOUND));
                default:
                  return Container();
              }
            },
          ),
        ));
  }

  Widget showHomeScreenUserList(
      APIResponse<HomeScreenResponse> homeScreenUserList) {
    return ListView.builder(
        itemCount: homeScreenUserList.data!.results!.length,
        itemBuilder: (context, index) {
          return setUpTitle(
              homeScreenUserList.data!.results![index].name!.title.toString(),
              homeScreenUserList.data!.results![index].email!.toString(),
              homeScreenUserList.data!.results![index].phone!.toString(),
              homeScreenUserList.data!.results![index].location!.city.toString(),
              homeScreenUserList.data!.results![index].gender!.toString(),
              homeScreenUserList.data!.results![index].picture!.large!.toString()

          );
        });
  }

  /**
   * Name : setUpTitle
   * Purpose : This method will sets up listtitle of listview.
   */
  ListTile setUpTitle(String name, String email, String phone, String city,
      String website,String imagePath) =>
      ListTile(
        title: Text(name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(email),
        leading: Image.network(imagePath),
        onTap: () {
          openUserInformationDialog(name, email, phone, website, city);
        },
      );

  /**
   * Name : openUserInformationDialog
   * Purpose : This method is will open dialog on listview click for showing information of the user.
   */
  openUserInformationDialog(String name, String email, String phone,
      String website, String city) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: 350.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Employee Details',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 5.0,
                  ), Container(
                    margin: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                    child: Column(
                      children: [
                        Text(
                          'Name: ${name}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 15.0
                          ),
                        ), const SizedBox(
                          height: 5.0,
                        ), Text(
                          'E-Mail: ${email}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 15.0
                          ),
                        ), const SizedBox(
                          height: 5.0,
                        ), Text(
                          'Website: ${website}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 15.0
                          ),
                        ), const SizedBox(
                          height: 5.0,
                        ), Text(
                          'Phone: ${phone}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 15.0
                          ),
                        ), const SizedBox(
                          height: 5.0,
                        ), Text(
                          'City: ${city}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 15.0
                          ),
                        ), const SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
