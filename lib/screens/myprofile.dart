import 'dart:async';
import 'dart:io';

import 'package:engaged/screens/ProfileValue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/EmployeeInfoModel.dart';
import '../services/api.dart';
import 'chart.dart';
import 'package:intl/intl.dart';

import 'constants/constants.dart';
import 'constants/loader.dart';
import 'constants/toast.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<EmployeeInfo> _list = [];
  String? _timeString;
  bool isload = true;
  final ApiService _apiService = ApiService();

  @override
  void initState()  {
    // TODO: implement initState
    getDetailsWrapper();
    _getTime();
     imageStore();
    super.initState();


  }
  void imageStore() {
    final box = GetStorage();
    final imageTmp = box.read(IMAGE_PATH) ?? "";
    if (imageTmp == "") return;
    final imageNew = File(
        imageTmp);
      image = imageNew;

  }
  void getDetailsWrapper() async {
    var isLoadTemp = await getDetails();
    if (!mounted) return;
    setState(() {
      isload = isLoadTemp;
    });
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('MMM- yyyy').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  Future<bool> getDetails() async {
    try {
      print("reached getDetails");

      var result = await _apiService.getInfo();
      print("result");
      print(result);
      debugPrint("Size:: ${result.length}");
      // if(result.isEmpty){
      //   //call getDetails again after refresh token
      //   getDetails();
      // }
      setState(() {
        _list = result;
      });
     return false;
    } on Exception catch (exception) {
      print(exception);
      print("failed")  ;    return true;
      // only executed if error is of type Exception
    } catch (error) {
      toastMessage("UNKNOWN ERROR");
      return true;
    }
  }

  File? image;
  final box = GetStorage();

  Future picImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(
        image.path,

      );
      box.write(IMAGE_PATH, image.path);
      setState(() {
        this.image = imageTemp;
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      debugPrint("failed to pick image:$e");
    }
  }
  showDialog() {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: 200,
                child: Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Upload image\nSelect Source',
                        style: TextStyle(
                            color: Color(0xFF0D1B38),
                            fontFamily: "inter",
                            fontSize: 15),
                      ),
                    ),
                    const Divider(),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        picImage(ImageSource.gallery);
                      },
                      child: const Text(
                        'Gallery',
                        style: TextStyle(
                            color: Color(0xff228BDB),
                            fontSize: 15,
                            fontFamily: "inter"),
                      ),
                    ),
                    const Divider(),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        picImage(ImageSource.camera);
                      },
                      child: const Text(
                        'Camera',
                        style: TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 15,
                            fontFamily: "inter"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: 200,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Color(0xFF0D1B38),
                          fontSize: 18,
                          fontFamily: "inter"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    showDialog() {
      return showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  width: 200,
                  child: Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Upload image\nSelect Source',
                          style: TextStyle(
                              color: Color(0xFF0D1B38),
                              fontFamily: "inter",
                              fontSize: 15),
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          picImage(ImageSource.gallery);
                        },
                        child: const Text(
                          'Gallery',
                          style: TextStyle(
                              color: Color(0xff228BDB),
                              fontSize: 15,
                              fontFamily: "inter"),
                        ),
                      ),
                      const Divider(),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          picImage(ImageSource.camera);
                        },
                        child: const Text(
                          'Camera',
                          style: TextStyle(
                              color: Color(0xFF2196F3),
                              fontSize: 15,
                              fontFamily: "inter"),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  width: 200,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(0xFF0D1B38),
                            fontSize: 18,
                            fontFamily: "inter"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }


    return isload
        ? const Loader()
        : Scaffold(
            backgroundColor: const Color(0xffFBF9F7),
            appBar: AppBar(
              backgroundColor: const Color(0xff1D3149),
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 8,
                ),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "assets/images/arrow-left.svg",
                    )),
              ),
              title: const Padding(
                padding: EdgeInsets.only(bottom: 24.5, top: 24.5),
                child: Center(
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                        letterSpacing: 0.15,
                        fontFamily: "inter",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xffFFFFFF),
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    /*  onTap: _completeLogin,*/
                    child: SvgPicture.asset(
                      "assets/images/Notifications.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: SvgPicture.asset(
                    "assets/images/Hamburger.svg",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            body:
            _layoutDetails(),
          );

  }
  Widget _layoutDetails(){
    Orientation orientation=MediaQuery.of(context).orientation;
    if(orientation==Orientation.portrait){
      return _portraitProfile();
    }
    else{
      return _landScapeProfile();

    }

  }
  Widget _portraitProfile(){
  return  Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                showDialog();
              },
              child: image != null
                  ? Image.file(
                image!,
                height: 96.0,
                width: 96.0,
                fit: BoxFit.cover,
              )
                  : SizedBox(
                height: 96.0,
                width: 96.0,
                child:
                Image.asset("assets/images/Rectangle 5.png"),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _list[0].fullName,
                      style: const TextStyle(
                          fontFamily: 'inter',
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff1D3149)),
                    ),
                  ),
                  Text(
                    _list[0].idNumber,
                    style: const TextStyle(
                        fontFamily: 'inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff8697AC)),
                  ),
                  _list[0].email.isEmpty?Container():
                  Padding(
                    padding: const EdgeInsets.only(left: 80,right: 0, top: 27),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                                "assets/images/mail.svg")),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            _list[0].email,
                            style: const TextStyle(
                                color: Color(
                                  0xff403E3D,
                                ),
                                fontSize: 14,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                  _list[0].phoneNumber.isEmpty?Container():
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 120.0, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                                "assets/images/Vector (8).svg")),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Text(
                            _list[0].phoneNumber,
                            style: const TextStyle(
                                color: Color(
                                  0xff403E3D,
                                ),
                                fontSize: 14,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 160,
                child: const EmployeeProfileValue()),
            Padding(
              padding:
              const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sales Report",
                    style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff403E3D)),
                  ),
                  Text(
                    _timeString.toString(),
                    style: const TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff737372)),
                  )
                ],
              ),
            ),
            const SizedBox(width: 700, height: 270, child: MyChartPage()),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 15.0, left: 65, top: 5),
              child: Row(
                children: [
                  Container(
                      height: 10,
                      width: 10,
                      color: const Color(0xff8697AC)),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 12),
                    child: Text(
                      "Actual Value",
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8697AC)),
                    ),
                  ),
                  Container(
                      height: 10,
                      width: 10,
                      color: const Color(0xff37B257)),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 12),
                    child: Text(
                      "Target Value",
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8697AC)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


  }
  Widget _landScapeProfile(){
    return  SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  showDialog();
                },
                child: image != null
                    ? Image.file(
                  image!,
                  height: 96.0,
                  width: 96.0,
                  fit: BoxFit.cover,
                )
                    : SizedBox(
                  height: 96.0,
                  width: 96.0,
                  child:
                  Image.asset("assets/images/Rectangle 5.png"),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _list[0].fullName,
                        style: const TextStyle(
                            fontFamily: 'inter',
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1D3149)),
                      ),
                    ),
                    Text(
                      _list[0].idNumber,
                      style: const TextStyle(
                          fontFamily: 'inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8697AC)),
                    ),
                    _list[0].email.isEmpty?Container():

                    Padding(
                      padding: const EdgeInsets.only(left: 300, top: 27,right: 0),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                  "assets/images/mail.svg")),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _list[0].email,
                              style: const TextStyle(
                                  color: Color(
                                    0xff403E3D,
                                  ),
                                  fontSize: 14,
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                    _list[0].phoneNumber.isEmpty?Container():

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 290.0, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                  "assets/images/Vector (8).svg")),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: Text(
                              _list[0].phoneNumber,
                              style: const TextStyle(
                                  color: Color(
                                    0xff403E3D,
                                  ),
                                  fontSize: 14,
                                  fontFamily: 'inter',
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  child: const EmployeeProfileValue()),
              Padding(
                padding:
                const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sales Report",
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff403E3D)),
                    ),
                    Text(
                      _timeString.toString(),
                      style: const TextStyle(
                          fontFamily: 'inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff737372)),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 700, height: 270, child: MyChartPage()),
              Padding(
                padding:
                const EdgeInsets.only(bottom: 15.0, left: 65, top: 5),
                child: Row(
                  children: [
                    Container(
                        height: 10,
                        width: 10,
                        color: const Color(0xff8697AC)),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 12),
                      child: Text(
                        "Actual Value",
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8697AC)),
                      ),
                    ),
                    Container(
                        height: 10,
                        width: 10,
                        color: const Color(0xff37B257)),
                    const Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 12),
                      child: Text(
                        "Target Value",
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8697AC)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}
