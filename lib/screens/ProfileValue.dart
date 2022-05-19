import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/employeeProfileValue.dart';
import '../services/api.dart';
import 'constants/toast.dart';

class EmployeeProfileValue extends StatefulWidget {
  const EmployeeProfileValue({Key? key}) : super(key: key);

  @override
  _EmployeeProfileValueState createState() => _EmployeeProfileValueState();
}

class _EmployeeProfileValueState extends State<EmployeeProfileValue> {
  List<ProfileValue> _data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileValue();
  }

  void getProfileValue() async {
    try {
      ApiService _apiService = ApiService();
      var res = await _apiService.getProfileValue();
      debugPrint("Size:: ${res.length}");
      setState(() {
        _data = res;
      });
    } on Exception catch (exception) {
      // only executed if error is of type Exception
    } catch (error) {
      // executed for errors of all types other than Exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBF9F7),

      body:
      Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return Align(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 103.h,
                      width: 103.w,
                      child: Card(
                        shadowColor: const Color(0xff1D3149),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _data[index].value.toString(),
                              style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff228BDB)
                              ),
                            ),
                            Text(
                              _data[index].description,
                              style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8F8F8F)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            );
          },
        ),
      ),
    );
  }
}
