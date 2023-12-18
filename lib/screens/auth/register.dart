import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_tracker/colors.dart';
import 'package:expenses_tracker/screens/auth/login.dart';
import 'package:expenses_tracker/screens/auth/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _name = TextEditingController();
  TextEditingController _emailControl = TextEditingController();

  TextEditingController _f_name = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _age = TextEditingController();

  TextEditingController _passwordControl = TextEditingController();
  TextEditingController _ConfirmPasswordControl = TextEditingController();

  bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    signup() async {
      try {
        isSignUp = true;
        setState(() {});
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailControl.text,
          password: _passwordControl.text,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'name': _name.text,
          'Father name': _f_name.text,
          'email': credential.user!.email,
          'gender': _gender.text,
          'age': _age.text,
          // 'uid': credential.user!.uid,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Account created successfuly'),
          backgroundColor: AppColor.green,
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } catch (e) {
        isSignUp = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')));

        print('I am error ============$e===========');
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              SizedBox(height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'sign up to Flutter',
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
              Row(
                children: [
                  Flexible(
                      child: CustomTextField(
                    controller: _name,
                    icon: Icon(Icons.person),
                    labeltext: 'First name',
                    size: 12,
                  )),
                  SizedBox(width: 15),
                  Flexible(
                      child: CustomTextField(
                    controller: _f_name,
                    icon: Icon(Icons.person_3),
                    labeltext: 'Last name',
                    size: 12,
                  ))
                ],
              ),
              SizedBox(height: 15),
              CustomTextField(
                  controller: _emailControl,
                  labeltext: 'Email',
                  icon: Icon(Icons.alternate_email),
                  size: 12),
              SizedBox(height: 15),
              CustomTextField(
                  controller: _passwordControl,
                  labeltext: 'Password',
                  icon: Icon(Icons.password_rounded),
                  size: 12),
              SizedBox(height: 15),
              CustomTextField(
                  controller: _ConfirmPasswordControl,
                  labeltext: 'Confirm Password',
                  icon: Icon(Icons.lock_reset_rounded),
                  size: 12),
              SizedBox(height: 15),
              Row(
                children: [
                  Flexible(
                      child: CustomTextField(
                    controller: _gender,
                    icon: Icon(Icons.person),
                    labeltext: 'Gender',
                    size: 12,
                  )),
                  SizedBox(width: 15),
                  Flexible(
                      child: CustomTextField(
                    controller: _age,
                    icon: Icon(Icons.person_3),
                    labeltext: 'Age',
                    size: 12,
                  ))
                ],
              ),
              SizedBox(height: 15),
              Hero(
                tag: 'auth',
                child: ElevatedButton(
                    onPressed: signup,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: Size(width * 0.85, 60)),
                    child: isSignUp
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Register',
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
                    'By registering, you agree to our terms and conditions',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff808080)),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Registered?",
                    style: GoogleFonts.poppins(
                        color: Color(0xff5A5B5B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) => Login())));
                    },
                    child: Text(
                      'Sign In',
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
