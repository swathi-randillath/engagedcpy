import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

import '../screens/login.dart';
import '../screens/myprofile.dart';

void _completeLogin(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false);
}

buildProfileDrawer(context) {
  return Align(
    alignment: Alignment.topRight,
    child: SizedBox(
      // height: 500,
      child: Drawer(
        backgroundColor: const Color(0xff1D3149),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 83.0,
              child: DrawerHeader(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/Vector_Smart_Object_xA0_Image.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'MENU',
                        style: TextStyle(
                            // letterSpacing: 0.15,
                            fontFamily: "inter",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xffFFFFFF),
                            fontStyle: FontStyle.normal),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          "assets/images/Hamburger (1).svg",
                        ),
                      )
                    ]),
                decoration: const BoxDecoration(
                  color: Color(0xff1D3149),
                ),
              ),
            ),
            const Divider(
              color: Color(0xff46607F),
              thickness: 1,
            ),
            ListTile(
              title: const Text(
                'My Profile',
                style: TextStyle(
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color(0xffFFFFFF),
                    fontStyle: FontStyle.normal),
              ),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MyProfile()));
              },
            ),
            const Divider(
              color: Color(0xff46607F),
              thickness: 1,
            ),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Color(0xffFFFFFF),
                    fontStyle: FontStyle.normal),
              ),
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to Logout?.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Logout'),
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                                (route) => false);
                        // GetStorage().erase();

                      }

                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: Color(0xff46607F),
              thickness: 1,
            ),
          ],
        ),
      ),
    ),
  );
}
