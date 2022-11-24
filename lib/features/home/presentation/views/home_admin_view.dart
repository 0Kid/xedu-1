import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/features/home/presentation/bloc/status_pelaporan_bloc.dart';
import 'package:xedu/features/home/presentation/views/detail_status_pelaporan_view.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/presentation/views/auth_view.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/presentation/widget/container_riwayat_lapor_widget.dart';
import 'package:xedu/injection_container.dart';
import 'package:xedu/widgets/text_widget.dart';

import '../../../login/domain/entity/user.dart';

class HomeAdminView extends StatefulWidget {
  const HomeAdminView({super.key});

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {

  late SharedPreferences prefs;
  late UserData user;

  @override
  void initState() {
    prefs = sl<SharedPreferences>();
    _getUser();
    super.initState();
  }

  void _getUser() async {
    user =
        UserDataModel.fromJson(jsonDecode(prefs.getString(CACHED_USER_DATA)!));
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<StatusPelaporanBloc>()..add(StatusPelaporanGetEvent(sekolahId: user.data.id.toString())),
      child: HomeAdminPage(preferences: prefs),
    );
  }
}

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key, required this.preferences});
  final SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: appBar(context),
      body: BlocBuilder<StatusPelaporanBloc, StatusPelaporanState>(
        builder: (context, state) {
          if(state is StatusPelaporanLaporLoaded) {
            return ContainerRiwayatLaporWidget(
              data: state.lapor,
              length: state.lapor.lapor.length, 
              isLoading: false,
              onTap: (index) {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => DetailStatusPelaporaView(data: state.lapor.lapor[index],))
                );
              },
            );
          } else if (state is StatusPelaporanLaporFailed) {
            return Text(state.message);
          } else {
            return ContainerRiwayatLaporWidget(
              data: Lapor(
                lapor: [
                  LaporData(id: 1, namaPelaku: 'namaPelaku', tempatKejadian: 'tempatKejadian', tanggalKejadian: 'tanggalKejadian', hubungan: 'hubungan', uraian: 'uraian', isAnon: false, status: 'SUBMITED', createdAt: DateTime.now(), authId: 1, sekoalhId: 1),
                  LaporData(id: 1, namaPelaku: 'namaPelaku', tempatKejadian: 'tempatKejadian', tanggalKejadian: 'tanggalKejadian', hubungan: 'hubungan', uraian: 'uraian', isAnon: false, status: 'SUBMITED', createdAt: DateTime.now(), authId: 1, sekoalhId: 1)
                ]
              ),
              length: 2, 
              isLoading: true
            );
          }
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const CustomTextWidget(
        text: 'Status Pelaporan',
        color: Colors.white,
        weight: FontWeight.w600,
        size: 24,
      ),
      actions: [
        IconButton(
          onPressed: () {
            preferences.remove(CACHED_USER_DATA);
            Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => AuthView(),)
          );
          }, 
          icon: Icon(Icons.logout, color: Colors.white,)
        )
      ],
    );
  }
}