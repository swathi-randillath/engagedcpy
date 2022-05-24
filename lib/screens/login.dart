import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import '../services/api.dart';
import 'constants/constants.dart';
import 'constants/toast.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LocationPermission permission;
  late StreamSubscription<Position> positionStream;
  late Position position;
  final myNameController = TextEditingController();
  final myPasswordController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String long = "", lat = "";
  bool serviceStatus = false;
  bool hasPermission = false;
  bool _isObscure = true;
  bool isLoading = false;

  checkGps() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("'Location permissions are permanently denied");
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        getLocation();
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint(position.longitude.toString());
    debugPrint(position.latitude.toString());

    long = position.longitude.toString();
    lat = position.latitude.toString();
  }

  void checkLogin() async {
    setState(() {
      isLoading = true;
    });

    final box = GetStorage();
    try {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        isLoading = false;
      });
      var result = await ApiService.loginAccount(myNameController.text,
          myPasswordController.text, "password", lat, long);
      box.write(ACCESS_TOKEN, result.accessToken);
      box.write(refresh_token, result.refreshToken);
      box.write(user_name, myNameController.text);
      box.write(USER_LOGGED_IN, true);

      debugPrint("safe:$USER_LOGGED_IN");

      var token = result.accessToken;
      if (token == result.accessToken) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
      }
      debugPrint(token);
    } on Exception catch (exception) {
      toastMessage("CHECK YOUR CONNECTION");

      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }
  }



  @override
  void initState() {
    checkGps();
    final storage = GetStorage();
    var userName = storage.read(user_name);
    myNameController.text = userName ?? '';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        key: scaffoldKey,
        backgroundColor: const Color(0xffFBF9F7),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 50, top: 80),
                    child: SizedBox(
                        height: 48,
                        width: 282,
                        child: Image.asset("assets/images/Logo.png")),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 100, right:15),
                    child: Text(
                      "Engage your client | staff | customer",
                      style: TextStyle(
                          color: Color(0xff737372),
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'inter'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: Center(
                              child:
                                  SvgPicture.asset("assets/images/Group21.svg"),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              "In-Field",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'inter'),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: Center(
                              child: SvgPicture.asset(
                                  "assets/images/Group 225.svg"),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              "Recruiter ",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'inter'),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: Center(
                              child:
                                  SvgPicture.asset("assets/images/Group12.svg"),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Text(
                              "e-learning",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  fontFamily: 'inter'),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16, top: 66.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Login",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff403E3D),
                              fontFamily: 'inter')),
                    ),
                  ),
                  Form(
                    key: globalFormKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("USER NAME",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff737372),
                                    fontFamily: 'inter',
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 24),
                                child: TextFormField(
                                  controller: myNameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                          color: Color(0xff2BAEB2),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                          color: Color(0xff757575),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      hintStyle:
                                          TextStyle(color: Colors.grey[800]),
                                      fillColor: const Color(0xffFFFFFF)),
                                ),
                              ),
                              const Text("PASSWORD",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff737372),
                                    fontFamily: 'inter',
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 24),
                                child: TextFormField(
                                  controller: myPasswordController,
                                  obscureText: _isObscure,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color(0xff757575),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        },
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                          color: Color(0xff2BAEB2),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(
                                          color: Color(0xff757575),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      fillColor: const Color(0xffFFFFFF)),
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 32,
                    ),
                    child: InkWell(
                      onTap: () {
                        var username = myNameController.text.toString();
                        var password = myPasswordController.text.toString();
                        if (username.isEmpty && password.isEmpty) {
                          toastMessage(
                            "Please enter your username and password",
                          );
                        } else if (username.isEmpty) {
                          toastMessage(
                            "Please enter a valid username",
                          );
                        } else if (password.isEmpty) {
                          toastMessage("Please enter a valid password");
                        } else {
                          checkLogin();
                        }
                      },
                      child: Container(
                        height: 48,
                        // width: 328.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: const Color(0xff37B257)),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'inter'),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AspectRatio(
                      aspectRatio: 50 / 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff338B4B),
                                  fontFamily: 'inter'),
                            ),
                          ),
                          InkWell(
                              child: const Text(
                                "Create an Account",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff403E3D),
                                    fontFamily: 'inter'),
                              ),
                              onTap: () {
                                /*Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const RegisterPage()));*/
                              }),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ));
  }
}
