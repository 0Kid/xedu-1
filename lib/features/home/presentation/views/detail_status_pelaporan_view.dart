import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xedu/features/home/presentation/bloc/update_status_bloc.dart';
import 'package:xedu/features/home/presentation/widgets/column_title_and_text_widget.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/widgets/custom_elevated_button_widget.dart';
import 'package:xedu/features/widgets/dialog_widget.dart';
import 'package:xedu/injection_container.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class DetailStatusPelaporaView extends StatelessWidget {
  const DetailStatusPelaporaView({super.key, required this.data});
  final LaporData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UpdateStatusBloc>(),
      child: DetailStatusPelaporanPage(
        data: data,
      ),
    );
  }
}

class DetailStatusPelaporanPage extends StatefulWidget {
  const DetailStatusPelaporanPage({super.key, required this.data});
  final LaporData data;

  @override
  State<DetailStatusPelaporanPage> createState() => _DetailStatusPelaporanPageState();
}

class _DetailStatusPelaporanPageState extends State<DetailStatusPelaporanPage> {
  final listStatus = <String>['SUBMITED', 'REVIEW', 'APPROVED'];

  String? groupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
            children: [
              containerAnonim(),
              SizedBox(height: 16),
              ColumnTitleAndTextWidget(
                text: widget.data.uraian!,
                title: 'Uraian',
              ),
              SizedBox(height: 23),
              ColumnTitleAndTextWidget(title: 'Hubungan', text: widget.data.hubungan!),
              SizedBox(height: 23),
              ColumnTitleAndTextWidget(
                  title: 'Nama pelaku', text: widget.data.namaPelaku!),
              SizedBox(height: 23),
              BlocConsumer<UpdateStatusBloc, UpdateStatusState>(
                listener: (context, state) {
                  if(state is UpdateStatusSuccess) {
                    Navigator.pop(context);
                  } else if (state is UpdateStatusFailed){
                    showDialog(
                      context: context, 
                      builder: (context) => ErrorDialog(errorValue: state.message,),
                    );
                  } else {
                    showDialog(
                      context: context, 
                      builder: (context) => LoadingDialog(),
                    );
                  }
                },
                builder: (context, state) {
                  if(state is UpdateStatusSuccess){
                    return ColumnTitleAndTextWidget(
                      title: 'status',
                      text: state.laporData.lapor.status!,
                      isStatus: true,
                    );
                  } else {
                    return ColumnTitleAndTextWidget(
                      title: 'status',
                      text: widget.data.status!,
                      isStatus: true,
                    );
                  }
                },
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: containerPelaporanWidget(context),
          ),
        ],
      ),
    );
  }

  Container containerPelaporanWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(36, 4, 36, 16),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, StateSetter setState) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24)
                      )
                    ),
                    child: Column(
                      children: [
                        CustomTextWidget(
                          text: 'Ubah staus laporan',
                          weight: FontWeight.w600,
                          size: 15,
                        ),
                        SizedBox(height: 12,),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: CustomTextWidget(
                                  text: listStatus[index],
                                ),
                              leading: Radio<String>(
                                value: listStatus[index],
                                groupValue: groupValue,
                                onChanged: (value) {
                                  setState(() {
                                    groupValue = value;
                                  });
                                },
                              ),
                            );
                          }, 
                          separatorBuilder: (_, __) => SizedBox(height: 8), 
                          itemCount: listStatus.length
                        ),
                        Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: CustomElevatedButtonWidget(
                            backgroundColor: kPrimaryColor, 
                            text: 'Ubah status', 
                            onTap: () {
                              Navigator.pop(context);
                            }, 
                            textColor: Colors.white, 
                            isBorderEnabled: false
                          ),
                        )
                      ],
                    )
                  );
                },
              );
            },
          ).then((value){
            context.read<UpdateStatusBloc>().add(UpdateStatusPatchEvent(laporId: widget.data.id.toString(), status: groupValue!));
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            padding: EdgeInsets.all(8),
            alignment: Alignment.center),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/progress.png',
              width: 26,
              height: 26,
            ),
            SizedBox(width: 7.5),
            CustomTextWidget(
              text: 'Tindaklanjuti laporan ini',
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Container containerAnonim() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 9, 24, 40),
      decoration: BoxDecoration(
          color: Color.fromRGBO(244, 246, 252, 1),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: Color.fromRGBO(62, 0, 109, 1))),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: CustomTextWidget(
              text: widget.data.tanggalKejadian!,
              weight: FontWeight.w500,
              size: 13,
              color: kPurpleColor,
            ),
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Image.asset(
                'assets/images/speak.png',
                width: 52,
                height: 52,
                color: Color.fromRGBO(66, 30, 94, 1),
              ),
              SizedBox(width: 22),
              CustomTextWidget(
                text: widget.data.isAnon! ? 'Anonim' : widget.data.namaPelaku!,
                size: 23,
                weight: FontWeight.w700,
                color: Color.fromRGBO(66, 30, 94, 1),
              )
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: const CustomTextWidget(
        text: 'Detail laporan',
        color: Colors.white,
        weight: FontWeight.w600,
        size: 24,
      ),
    );
  }
}
