import 'package:expenses_tracker/colors.dart';
import 'package:expenses_tracker/screens/auth/register.dart';
import 'package:expenses_tracker/screens/auth/widgets/custom_textfield.dart';
import 'package:expenses_tracker/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _userIdControl = TextEditingController();

  TextEditingController _passwordControl = TextEditingController();
  bool isLogingIn = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    login() async {
      try {
        isLogingIn = true;
        setState(() {});

        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _userIdControl.text, password: _passwordControl.text);
        await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Login Successful!'),
        ));
        print('============${credential.user!.uid}========');

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeView(
                      uid: credential.user!.uid,
                    )));
        print('============${credential.user!.uid}========');
      } catch (e) {
        isLogingIn = false;
        setState(() {});

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Wrong Password or Email'),
        ));
        print('I am error ============$e===========');
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'sign in to Flutter',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AppColor.blue,
                          fontSize: 25,
                        ),
                      ),
                      Container(
                          width: 20,
                          height: 20,
                          child: Icon(
                            Icons.flutter_dash_rounded,
                            color: AppColor.green,
                          )),
                    ],
                  ),
                  Text(
                    'To get update and\nspecial offers',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              CustomTextField(
                  controller: _userIdControl,
                  labeltext: 'Email',
                  icon: Icon(Icons.alternate_email),
                  size: 12),
              SizedBox(height: 15),
              CustomTextField(
                  controller: _passwordControl,
                  labeltext: 'Password',
                  icon: Icon(Icons.password_rounded),
                  size: 12),
              SizedBox(height: 30),
              Hero(
                tag: 'auth',
                child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: Size(width * 0.85, 70)),
                    child: isLogingIn
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          )),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,

                    // );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.normal,
                        color: Color(0xffC1272D)),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: GoogleFonts.poppins(
                        color: Color(0xff5A5B5B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Signup())));
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                          color: AppColor.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
