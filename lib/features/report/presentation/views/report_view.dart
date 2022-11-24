import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/features/report/domain/usecase/post_lapor_usecase.dart';
import 'package:xedu/features/report/presentation/bloc/lapor_bloc.dart';
import 'package:xedu/features/report/presentation/views/riwayat_lapor_view.dart';
import 'package:xedu/features/report/presentation/views/success_report_view.dart';
import 'package:xedu/features/widgets/custom_elevated_button_widget.dart';
import 'package:xedu/features/widgets/dialog_widget.dart';
import 'package:xedu/features/widgets/radio_with_label_widget.dart';
import 'package:xedu/features/widgets/textfield_with_label_widget.dart';
import 'package:xedu/injection_container.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LaporBloc>(),
      child: ReportScreen(),
    );
  }
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late bool groupValue;
  late SharedPreferences prefs;
  late UserData user;
  late TextEditingController pelakuTextEditingController;
  late TextEditingController tglEditingController;
  late TextEditingController hubunganEditingController;
  late TextEditingController uraianEditingController;
  late TextEditingController lokasiEditingController;
  final _formReportKey = GlobalKey<FormState>();

  void _getUserData() async {
    user =
        UserDataModel.fromJson(jsonDecode(prefs.getString(CACHED_USER_DATA)!));
  }

  @override
  void initState() {
    groupValue = false;
    prefs = sl<SharedPreferences>();
    _getUserData();
    pelakuTextEditingController = TextEditingController();
    tglEditingController = TextEditingController();
    hubunganEditingController = TextEditingController();
    uraianEditingController = TextEditingController();
    lokasiEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromRGBO(235, 243, 254, 1),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(18, 51, 19, 18),
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 22),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(.25),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Form(
            key: _formReportKey,
            child: Column(
              children: [
                const CustomTextWidget(
                  text: 'Pelaporan tindak',
                  weight: FontWeight.w600,
                  size: 23,
                ),
                const CustomTextWidget(
                  text: 'kekerasan seksual',
                  weight: FontWeight.w600,
                  size: 23,
                ),
                const SizedBox(
                  height: 36,
                ),
                TextFieldWithLabelWidget(
                  label: 'Nama Pelaku: ',
                  controller: pelakuTextEditingController,
                  errorMessage: 'nama pelaku tidak boleh kosong',
                  hintText: 'nama pelaku pelecehan',
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWithLabelWidget(
                  label: 'Lokasi kejadian',
                  controller: lokasiEditingController,
                  errorMessage: 'lokasi tidak boleh kosong',
                  hintText: 'lokasi terjadinya pelecehan',
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  child: TextFieldWithLabelWidget(
                    label: 'Tangal kejadian:',
                    controller: tglEditingController,
                    errorMessage: 'Tanggal tidak boleh kosong',
                    isEnabled: false,
                    hintText: 'tanggal kejadian pelecehan',
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context, 
                      initialDate: DateTime.now(), 
                      firstDate: DateTime(2010), 
                      lastDate: DateTime(2030),
                      locale: Locale('id', 'ID'),
                    );
                    if(selectedDate != null) {
                      tglEditingController.text = DateFormat('dd MMMM yyyy').format(selectedDate);
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWithLabelWidget(
                  label: 'Hubunga degan pelaku:',
                  controller: hubunganEditingController,
                  errorMessage: 'hubungan tidak boleh kosong',
                  hintText: 'teman, saudara, guru',
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWithLabelWidget(
                  label: 'Peristiwa yang terjadi',
                  controller: uraianEditingController,
                  errorMessage: 'Koronologi tidak boleh kosong',
                  hintText: 'Kronologi peristiwa pelecehan',
                ),
                const SizedBox(
                  height: 15,
                ),
                radioTitle(),
                const SizedBox(
                  height: 8,
                ),
                radioAnonim(),
                const SizedBox(
                  height: 28,
                ),
                blocListenerLapor()
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocListener<LaporBloc, LaporState> blocListenerLapor() {
    return BlocListener<LaporBloc, LaporState>(
      listener: (context, state) {
        if(state is LaporSuccess) {
          setState(() {
            pelakuTextEditingController.clear();
            lokasiEditingController.clear();
            tglEditingController.clear();
            hubunganEditingController.clear();
            uraianEditingController.clear();
          });
          Navigator.pop(context);
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => SuccessReportView())
          );
        } else if (state is LaporFailed) {
          showDialog(
            context: context, 
            builder: (_) => ErrorDialog(errorValue: state.message)
          );
        } else {
          showDialog(
            context: context, 
            builder: (_) => LoadingDialog(),
          );
        }
      },
      child: rowButtoWidget(),
    );
  }

  Row rowButtoWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomElevatedButtonWidget(
          backgroundColor: Colors.white,
          isBorderEnabled: true,
          text: 'Batal',
          textColor: kPrimaryColor,
          shadowColor: kPrimaryColor.withOpacity(0.16),
          onTap: () {
            pelakuTextEditingController.clear();
            lokasiEditingController.clear();
            tglEditingController.clear();
            hubunganEditingController.clear();
            uraianEditingController.clear();
            _formReportKey.currentState!.reset();
          },
        ),
        CustomElevatedButtonWidget(
          backgroundColor: kPrimaryColor,
          isBorderEnabled: false,
          text: 'Kirim',
          textColor: Colors.white,
          shadowColor: kPrimaryColor.withOpacity(0.16),
          onTap: () {
            if(_formReportKey.currentState!.validate()) {
              context.read<LaporBloc>().add(
                PostLaporEvent(
                  params: LaporParams(
                    namaPelaku: pelakuTextEditingController.text,
                    tempatKejadian: lokasiEditingController.text,
                    tanggalKejadian: tglEditingController.text,
                    hubungan: hubunganEditingController.text,
                    uraian: uraianEditingController.text,
                    isAnon: groupValue,
                    authId: user.data.id!,
                    sekoalhId: user.data.sekolah!.id,
                    status: 'SUBMITED'
                  )
                )
              );
            }
          },
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const CustomTextWidget(
        text: 'Lapor',
        color: Colors.white,
        weight: FontWeight.w600,
        size: 24,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (_)=> BlocProvider(
                create: (context) => sl<LaporBloc>()..add(GetLaporEvent(auhtId: user.data.id.toString())),
                child: RiwayatLaporView(),
              ))
            );
          }, 
          icon: Icon(Icons.history)
        )
      ],
    );
  }

  Row radioAnonim() {
    return Row(
      children: [
        RadioWithLabelWidget(
          value: true,
          label: 'Ya',
          groupValue: groupValue,
          onTap: (value) {
            setState(() {
              groupValue = value!;
            });
          },
        ),
        RadioWithLabelWidget(
          value: false,
          label: 'Tidak',
          groupValue: groupValue,
          onTap: (value) {
            setState(() {
              groupValue = value!;
            });
          },
        ),
      ],
    );
  }

  Align radioTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: CustomTextWidget(
        text: 'Lapor secara anonim',
        size: 15,
        weight: FontWeight.w500,
      ),
    );
  }
}
