import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/login/presentation/views/auth_view.dart';
import 'package:xedu/features/profile/presentation/widget/disabled_textfiled_with_label_widget.dart';
import 'package:xedu/injection_container.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController namaEditingController;
  late TextEditingController noHpEditingController;
  late TextEditingController sekolahEditingController;
  late SharedPreferences prefs;
  late UserData user;

  void _getUser() async {
    user = UserDataModel.fromJson(jsonDecode(prefs.getString(CACHED_USER_DATA)!));
  }

  @override
  void initState() {
    prefs = sl<SharedPreferences>();
    _getUser();
    namaEditingController = TextEditingController(text: user.data.namaLengkap);
    noHpEditingController = TextEditingController(text: user.data.notelp);
    sekolahEditingController = TextEditingController(text: user.data.sekolah!.namaSekolah);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: appBar(),
      body: Container(
        margin: EdgeInsets.only(top: 12),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            children: [
              containerProfileImage(),
              SizedBox(height: 20,),
              divider(),
              SizedBox(height: 20,),
              textFieldAndLabelName(),
              SizedBox(height: 36,),
              textFieldAndLabelNoHp(),
              SizedBox(height: 36),
              textFieldAndLabelSchool(),
              Spacer(),
              elevatedBtnLogout()
            ],
          ),
        ),
      )
    );
  }

  Container elevatedBtnLogout() {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100)

      ),
      child: ElevatedButton(
        onPressed: () {
          prefs.remove(CACHED_USER_DATA);
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => AuthView(),)
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
          ),
          backgroundColor: kPrimaryColor,
          shadowColor: kPrimaryColor
        ), 
        child: CustomTextWidget(
          text: 'Logout',
          weight: FontWeight.w600,
          size: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  DisabledTexfieldWithLabel textFieldAndLabelSchool() {
    return DisabledTexfieldWithLabel(
      label: 'Alamat Sekolah', 
      isFilled: false, 
      controller: sekolahEditingController
    );
  }

  DisabledTexfieldWithLabel textFieldAndLabelNoHp() {
    return DisabledTexfieldWithLabel(
      label: 'Nomor HP', 
      isFilled: false, 
      controller: noHpEditingController
    );
  }

  DisabledTexfieldWithLabel textFieldAndLabelName() {
    return DisabledTexfieldWithLabel(
      label: 'Nama',
      isFilled: true,
      controller: namaEditingController,
    );
  }

  Divider divider() {
    return Divider(
      color: Color.fromRGBO(202, 202, 202, 1),
      thickness: 1.5,
    );
  }

  Container containerProfileImage() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[400]
      ),
      child: Icon(
        Icons.person,
        size: 80,
        color: Colors.grey[600],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const CustomTextWidget(
        text: 'Profil',
        color: Colors.white,
        weight: FontWeight.w600,
        size: 24,
      ),
      elevation: 0,
    );
  }
}
