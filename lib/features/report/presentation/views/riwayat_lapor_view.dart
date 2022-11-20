import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xedu/features/report/domain/entity/lapor.dart';
import 'package:xedu/features/report/presentation/bloc/lapor_bloc.dart';
import 'package:xedu/features/report/presentation/widget/container_riwayat_lapor_widget.dart';
import 'package:xedu/widgets/text_widget.dart';

class RiwayatLaporView extends StatelessWidget {
  const RiwayatLaporView({super.key});

  @override
  Widget build(BuildContext context) {
    return RiwayatLaporPage();
  }
}

class RiwayatLaporPage extends StatelessWidget {
  const RiwayatLaporPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocBuilder<LaporBloc, LaporState>(
        builder: (context, state) {
          if(state is LaporLoaded) {
            return ContainerRiwayatLaporWidget(
              data: state.lapor,
              length: state.lapor.lapor.length, 
              isLoading: false
            );
          } else if (state is LaporFailed) {
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

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const CustomTextWidget(
        text: 'Riwayat Lapor',
        color: Colors.white,
        weight: FontWeight.w600,
        size: 24,
      ),
    );
  }
}
