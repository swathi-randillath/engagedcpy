import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool validateStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Column(children: [
          const Text(
            "Register",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: Color(0xff403E3D),
                fontFamily: 'inter'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 285,
                ),
                child: Text("USER NAME",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737372),
                      fontFamily: 'inter',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 16),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter an username';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff2BAEB2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff757575),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      fillColor: const Color(0xffFFFFFF)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 285,
                ),
                child: Text("PASSWORD",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737372),
                      fontFamily: 'inter',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 24),
                child: TextFormField(
                  validator: (value) {
                    RegExp regex =
                    RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    else {
                      if (!regex.hasMatch(value)) {
                        return "enter a valid password";
                      }
                      else {
                        return null;
                      }
                    }


                    /* if (value == null || value.isEmpty) {
                      return 'Please enter the password';
                    } else if (value.length < 6) {
                      return 'password must be 6 letter';
                    } else {
                      return null;
                    }*/
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff2BAEB2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff757575),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFFFFF)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 285,
                ),
                child: Text("PASSWORD",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff737372),
                      fontFamily: 'inter',
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8, 16, 24),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the password';
                    } else if (value.length < 6) {
                      return 'password must be 6 letter';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff2BAEB2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Color(0xff757575),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xffFFFFFF)),
                ),
              ),
              InkWell(
                onTap: () {
                  // _getCurrentLocation();
                  if (_key.currentState!.validate()) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                            (route) => false);
                  }
                  /*if (ValidateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        Api api = Api();
                        api.login(request!).then((value) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          if (value.token!.isNotEmpty) {
                            _getCurrentLocation();*/

                  //     } else {
                  //       final snackBar =
                  //           SnackBar(content: Text(value.error.toString()));
                  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //     }
                  //   });
                  // }
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    12,
                    16,
                    32,
                  ),
                  child: Container(
                    height: 48.h,
                    width: 328.w,
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
            ],
          ),
        ]),
      ),
    );
  }

  static String? passwordConfirm(value, TextEditingController controller) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }

    if (value.toString() != controller.text) {
      return 'Required';
    }

    return null;
  }
/*static String? password(String? value) {
    if (empty(value, 'Required') != null) {
      return empty(value, 'Required');
    }

    RegExp regEx = RegExp(r"(?=.*[A-Z])\w+");

    if (value!.length < 8 || !regEx.hasMatch(value)) {
      return 'Please enter password';
    }

    return null;
  }
}
*/
}