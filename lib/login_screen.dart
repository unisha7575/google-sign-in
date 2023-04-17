import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn(
      // scopes: <String>[
      //   'email',
      // ],
      );

  //final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      debugPrint("Access Token: ${googleAuth.accessToken}");
      debugPrint("Display Name: ${googleUser.displayName}");
      debugPrint("Email: ${googleUser.email}");
      setState(() {
        emailController.text = googleUser.email;
        nameController.text = googleUser.displayName.toString();
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "username"),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Email"),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await signInWithGoogle();
                    } catch (e) {}
                  },
                  child: const Text('Sign in with Google'),
                ))
          ]),
        ),
      ),
    );
  }
}
