import 'dart:async';

import 'package:engaged/screens/constants/loader.dart';
import 'package:engaged/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

import '../models/homePageResponse.dart';
import 'constants/toast.dart';
import 'login.dart';
import 'myprofile.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PageAccessModel> _listData = [];
  String? _timeString;
  bool _loading=true;

  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
    _getTime();
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('MMM dd, yyyy').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
      print(_timeString);
    });
  }

  void checkLogin() async {

    setState(() {
      _loading=false;
    });
    try  {
      setState(() {
        _loading=true;
      });


      ApiService _apiService = ApiService();
      var result = await _apiService.getData();
      debugPrint("Size:: ${result.length}");
      setState(() {
        _listData = result;
      });
        setState(() {
          _loading=false;
        });
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        ),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return _loading?Loader(): Scaffold(
      key: _key,
      // set it here
      endDrawer: buildProfileDrawer(),
      backgroundColor: const Color(0xffFBF9F7),
      appBar: AppBar(
        backgroundColor: const Color(0xff1D3149),
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 12,
            bottom: 12,
          ),
          child: Center(
            child: Image.asset(
              "assets/images/Vector_Smart_Object_xA0_Image.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 24.5, top: 24.5),
          child: Center(
            child: Center(
              child: Text(
                _timeString.toString(),
                style: const TextStyle(
                    letterSpacing: 0.15,
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xffFFFFFF),
                    fontStyle: FontStyle.normal),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              child: SvgPicture.asset(
                "assets/images/Notifications.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: () {
                _key.currentState?.openEndDrawer();
              },
              child: SvgPicture.asset(
                "assets/images/Hamburger.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, top: 20, bottom: 20, right: 16),
        child: SizedBox(
          height: 800.h,
          child: ListView.builder(
            itemCount: _listData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                child: SizedBox(
                  height: 85.h,
                  child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      shadowColor: const Color(0xff14203E),
                      child: Stack(children: [
                        Positioned(
                          left: 20,
                          top: 16,
                          bottom: 16,
                          right: 298,
                          child: SvgPicture.asset(
                            "assets/images/${_listData[index].iconDescription}",
                            // color: Color(0xff228BDB),
                          ),
                        ),
                        Positioned(
                      left: 68,
                      top: 15,
                      child: Text(_listData[index].description,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1D3149),
                              fontFamily: 'inter')),
                        ),
                        Positioned(
                          left: 68,
                          top: 40,
                          child: Text(_listData[index].subDescription,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff9B9EAD),
                                  fontFamily: 'inter')),
                        ),
                        Positioned(
                          right: 5,
                          top: 16,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Color(0xff737372),
                              )),
                        ),


                      ],)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _completeLogin() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false);
  }

  buildProfileDrawer() {
    return Align(alignment: Alignment.topRight,
      child: SizedBox(
        // height: 500,
        child: Drawer(
          backgroundColor: const Color(0xffFBF9F7),

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 83.0,
                child: DrawerHeader(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Menu',style:
                        TextStyle(
                            letterSpacing: 0.15,
                            fontFamily: "inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color(0xffFFFFFF),
                            fontStyle: FontStyle.normal),
                  ),),
                  decoration: BoxDecoration(
                    color: Color(0xff1D3149),
                  ),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(10.0),
                ),
              ),
              ListTile(
                title: const Text('PROFILE', style: TextStyle(
                    letterSpacing: 0.15,
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff228BDB),
                    fontStyle: FontStyle.normal),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const MyProfile()));
                },
              ),
              ListTile(
                title: const Text('LOGOUT', style: TextStyle(
                    letterSpacing: 0.15,
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff228BDB),
                    fontStyle: FontStyle.normal),),
                onTap: _completeLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
