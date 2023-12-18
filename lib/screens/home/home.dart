import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_tracker/colors.dart';
import 'package:expenses_tracker/screens/home/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  final uid;
  HomeView({super.key, required this.uid});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController expenseTitleController = TextEditingController();
  TextEditingController expenseAmmountController = TextEditingController();
  TextEditingController expenseDateController = TextEditingController();

  AddExpense() async {
    CircularProgressIndicator();

    await FirebaseFirestore.instance.collection('expenses').add({
      'title': expenseTitleController.text,
      'ammount': expenseAmmountController.text,
      'Date': expenseDateController.text
    });
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Task added!'),
      backgroundColor: AppColor.black,
    ));
    expenseTitleController.clear();
    expenseAmmountController.clear();

    expenseDateController.clear();
  }

  final ImagePicker picker = ImagePicker();

  File? profile;

  pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profile = File(image.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FutureBuilder data() {
      return FutureBuilder(
        future: users.doc(widget.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${data['name']} ${data['Father name']}',
                  style: GoogleFonts.comicNeue(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
                Text(
                  '${data['email']}',
                  style: GoogleFonts.comicNeue(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ],
            );
          }

          return Text("loading");
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff202020),
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/Rectangle 49.svg',
              width: MediaQuery.sizeOf(context).width,
              // height: MediaQuery.sizeOf(context).height * 0.35,
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Expense Tracker',
                      style: GoogleFonts.comicNeue(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                    height: 70,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    child: Stack(
                      children: [
                        profile == null
                            ? CircleAvatar(
                                child: Icon(Icons.add),
                                // : Container(
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(50)),
                                //     child: Image.file(profile!,
                                //         fit: BoxFit.fitHeight)),
                                backgroundColor: Color(0xff434343),
                                radius: 55,
                                foregroundColor: Colors.black,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  profile!,
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.fill,
                                  height: 85,
                                  width: 85,
                                )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(0xff202020),
                              radius: 22,
                              child: CircleAvatar(
                                backgroundColor: Color(0xff434343),
                                radius: 15,
                                child: Icon(
                                  Icons.mode_edit_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  data(),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomCard(
                        mainText: 'Add Expenses',
                        onpressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Flexible(
                                  child: AlertDialog(
                                    title: Text('Add Expense'),
                                    titleTextStyle:
                                        TextStyle(color: AppColor.blue),
                                    actions: [
                                      TextField(
                                        controller: expenseTitleController,
                                        decoration: InputDecoration(
                                          hintText: 'Title',
                                        ),
                                      ),
                                      TextField(
                                        controller: expenseAmmountController,
                                        decoration: InputDecoration(
                                          hintText: 'Ammount',
                                        ),
                                      ),
                                      TextField(
                                        controller: expenseDateController,
                                        decoration: InputDecoration(
                                          hintText: 'Date',
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            AddExpense();
                                          },
                                          icon: Icon(Icons.done)),
                                    ],
                                    backgroundColor: AppColor.darkGrey,
                                  ),
                                );
                              });
                        },
                      ),
                      CustomCard(mainText: 'View Expenses'),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomCard(mainText: 'Expense Statistics'),
                      CustomCard(mainText: 'Signup'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
