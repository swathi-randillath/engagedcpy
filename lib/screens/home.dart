
import 'package:engaged/screens/constants/loader.dart';
import 'package:engaged/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../models/homePageResponse.dart';
import '../utils/drawer.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PageAccessModel> _listData = [];
  String? _timeString;
  bool _loading = true;
  final ApiService _apiService = ApiService();

  GlobalKey<ScaffoldState> _key = GlobalKey(); // add this

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHome();
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

  void getHome() async {
    setState(() {
      _loading = false;
    });
    try {
      setState(() {
        _loading = true;
      });


      var result = await _apiService.getData();
      debugPrint("Size:: ${result.length}");
      if(result.isEmpty){
       //call getData again after refresh token
        getHome();
        return;
      }
      setState(() {
        _listData = result;
      });
      setState(() {
        _loading = false;
      });
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }
  }

  @override
  Widget build(BuildContext context) {

    return
      _loading
        ? const Loader()
        : Scaffold(
      drawerScrimColor: Colors.transparent.withOpacity(.80),

      key: _key,
            // set it here
            endDrawer: buildProfileDrawer(context),
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
              padding: const EdgeInsets.only(
                  left: 16, top: 20, bottom: 20, right: 16),
              child: SizedBox(
                height: 800,
                child: ListView.builder(
                  itemCount: _listData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                        child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFFFFFF),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 8),
                                    color: Color.fromRGBO(20, 32, 62, 0.24),
                                    blurRadius: 18.0,
                                    spreadRadius: -6),
                              ],
                            ),
                            height: 70,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 18,
                                  top: 16,
                                  bottom: 16,
                                  child: SvgPicture.asset(
                                    "assets/images/${_listData[index].iconDescription}",
                                    // color: Color(0xff228BDB),
                                  ),
                                ),
                                Positioned(
                                  left: 70,
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
                                  left: 70,
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
                                  top: 10,
                                  bottom: 10,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color(0xff737372),
                                      )),
                                ),
                              ],
                            )));
                  },
                ),
              ),
            ),
          );
  }
}