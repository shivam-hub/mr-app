import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/locator.dart';
import '../screens/master_screen.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer();

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
                  Color.fromARGB(255, 114, 92, 127),
                  Color.fromARGB(255, 218, 202, 228),
                  // Colors.white30
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 245, 235, 244),
                  radius: 35.0,
                  child: Text(
                    getInitials(userName),
                    style: const TextStyle(
                      color: Color(0xFF7882A4),
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  userName,
                  style: GoogleFonts.lato(
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
              color: Color(0xFF7882A4),
              size: 28,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 127, 132, 150)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.dashboard,
              color: Color(0xFF7882A4),
              size: 28,
            ),
            title: const Text(
              'Master Screen',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 127, 132, 150)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MasterScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Color(0xFF7882A4),
              size: 28,
            ),
            title: const Text(
              'About',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 127, 132, 150)),
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
              color: Color(0xFF7882A4),
              size: 28,
            ),
            title: const Text(
              'Log Out',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 127, 132, 150)),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 134, 120, 164),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: const Text(
                      'Are you sure you want to log out?',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 127, 132, 150)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          'Log Out',
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
        ],
      ),
    );
  }

  String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String initials = '';
    int numWords = nameSplit.length < 2 ? 1 : 2;
    for (int i = 0; i < numWords; i++) {
      initials += nameSplit[i][0].toUpperCase();
    }
    return initials;
  }
}
