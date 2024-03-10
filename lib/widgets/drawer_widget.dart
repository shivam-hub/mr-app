// ignore_for_file: use_build_context_synchronously

import 'package:Nurene/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/locator.dart';
import '../screens/master_screen/master_screen.dart';
import '../screens/products_screen/products_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final pref = locator<SharedPreferences>();
    String userName = pref.getString('userName') ?? '';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.appThemeDarkShade3,
                  AppColors.appThemeDarkShade4,
                  AppColors.appThemeLightShade1,
                  AppColors.appThemeLightShade3
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35.0,
                  child: Text(
                    getInitials(userName),
                    style: GoogleFonts.montserrat(
                      color: AppColors.appThemeDarkShade1,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  userName,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 245, 229, 251),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: AppColors.appThemeDarkShade2,
              size: 28,
            ),
            title: Text(
              'Home',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17, color: Colors.grey.shade600),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.dashboard,
              color: AppColors.appThemeDarkShade2,
              size: 28,
            ),
            title: Text(
              'Master Screen',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17, color: Colors.grey.shade600),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MasterScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.medication,
              color: AppColors.appThemeDarkShade2,
              size: 28,
            ),
            title: Text(
              'Products',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17, color: Colors.grey.shade600),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: AppColors.appThemeDarkShade2,
              size: 28,
            ),
            title: Text(
              'About',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17, color: Colors.grey.shade600),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('About',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 134, 120, 164),
                        )),
                    content: const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Nurene Lifesciences pvt ltd.',
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
                          style: TextStyle(
                              color: Color.fromARGB(255, 134, 120, 164)),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppColors.appThemeDarkShade2,
              size: 28,
            ),
            title: Text(
              'Log Out',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 17, color: Colors.grey.shade600),
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    title: Text(
                      'Log Out',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 17, color: Colors.grey.shade600),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to log out?',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: Colors.grey.shade600),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(color: Colors.redAccent),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final pref = locator<SharedPreferences>();
                          pref.clear();
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          'Log Out',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: AppColors.appThemeDarkShade2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  String getInitials(String name) {
    if (name.isEmpty) {
      return name;
    }
    List<String> nameSplit = name.split(" ");
    String initials = '';
    int numWords = nameSplit.length < 2 ? 1 : 2;
    for (int i = 0; i < numWords; i++) {
      initials += nameSplit[i][0].toUpperCase();
    }
    return initials;
  }
}
