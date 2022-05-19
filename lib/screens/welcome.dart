import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 1000),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
        backgroundColor: const Color(0xffFBF9F7),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 64, top: 80, ),
                child: SizedBox(
                    width: 280.w,
                    height: 48.h,
                    child: Image.asset("assets/images/Logo.png")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 74.0,top: 16.5,bottom: 344
                ),
                child: SizedBox(
                  width: 205.w,
                  height: 18,
                  child: const Text("your client | staff | customer",  style: TextStyle(
                      color: Color(0xff1D3149),
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'inter'),
                  )),
              ),

              Padding(
                padding: const EdgeInsets.only(top:140.0,left: 16,right: 16,bottom: 56),
                child: SizedBox(
                  height: 130,
                  width: 328.w,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          },
                          child: Container(
                            width: 328.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: const Color(0xff37B257)),
                            child: const Center(
                              child: Text(
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
                      InkWell(
                    onTap: () {},
                    child: Container(
                      width: 328.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff737372)),
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xffFFFFFF)),
                      child: const Center(
                        child: Text(
                          "Create an Account",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff403E3D),
                              fontFamily: 'inter'),
                        ),
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              ),

            ])));
  }
}
