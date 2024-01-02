import 'package:flutter/material.dart';
import 'package:shoea_flutter/screens/authentication_screens/components/profile_picture_widget.dart';
import 'package:shoea_flutter/screens/authentication_screens/sign_in_screen.dart';
import 'package:shoea_flutter/utils/app_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Stack(
              children: [
                ProfilePicture(),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Ayush Kharwal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '+91 987654321',
              style: TextStyle(),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            CustomListTile(
              label: 'Edit Profile',
              leadingIcon: Icons.person_outline_rounded,
            ),
            CustomListTile(
              label: 'Help Center',
              leadingIcon: Icons.help_outline_rounded,
            ),
            CustomListTile(
              label: 'Invite Friends',
              leadingIcon: Icons.groups_outlined,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            const Spacer(),
            ListTile(
              onTap: () {
                AppStateManger.setAppState(1);
                Navigator.of(context)
                    .pushReplacementNamed(SignInScreen.routeName);
              },
              leading: const Icon(
                Icons.exit_to_app_rounded,
                color: Colors.red,
              ),
              title: const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  CustomListTile({
    super.key,
    required this.label,
    required this.leadingIcon,
  });

  final String label;
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
