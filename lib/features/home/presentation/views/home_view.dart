import 'dart:convert';
import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xedu/features/home/domain/entity/banner.dart' as entity;
import 'package:xedu/features/home/domain/entity/news.dart';
import 'package:xedu/features/home/presentation/bloc/banner_bloc.dart';
import 'package:xedu/features/home/presentation/bloc/news_bloc.dart';
import 'package:xedu/features/home/presentation/widgets/icon_and_app_name_widget.dart';
import 'package:xedu/features/home/presentation/widgets/icon_and_text_widget.dart';
import 'package:xedu/features/home/presentation/widgets/listview_berita_widget.dart';
import 'package:xedu/features/home/presentation/widgets/sizedbox_carousel_widget.dart';
import 'package:xedu/features/login/data/datasources/login_local_data_source.dart';
import 'package:xedu/features/login/data/model/user_model.dart';
import 'package:xedu/features/login/domain/entity/user.dart';
import 'package:xedu/injection_container.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/text_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<BannerBloc>()..add(getBannerEvent()),
        ),
        BlocProvider(
          create: (context) => sl<NewsBloc>()..add(GetNewsEvent()),
        ),
      ],
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollMatrix = 0;
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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: kPrimaryColor,
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        body: NotificationListener<ScrollUpdateNotification>(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                appBar(),
                SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            purpleBoxWidget(context),
                            containerUserDataWidget()
                          ],
                        ),
                      )
                    ]),
                  ),
                )
              ];
            },
            body: ListView(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              children: [
                rowSubAppWidget(),
                const SizedBox(
                  height: 32,
                ),
                blocBuilderBanner(),
                const SizedBox(
                  height: 25,
                ),
                containerBerita(context)
              ],
            ),
          ),
          onNotification: (notification) {
            setState(() {
              _scrollMatrix = notification.metrics.pixels;
            });
            return true;
          },
        ),
      ),
    );
  }

  BlocBuilder<BannerBloc, BannerState> blocBuilderBanner() {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerLoaded) {
          return SizedBoxCarouselWidget(
            length: state.banner.banner.length, 
            data: state.banner, 
            isLoading: false
          );
        } else if (state is BannerFailed) {
          return Text(state.message);
        } else {
          return SizedBoxCarouselWidget(
            length: 2, 
            data: entity.Banner(banner: [entity.BannerData(id: 1, image: 'image'), entity.BannerData(id: 1, image: 'image')]), 
            isLoading: true
          );
        }
      },
    );
  }

  Container containerBerita(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Color.fromRGBO(242, 224, 255, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextWidget(
            text: 'Berita Terbaru',
            color: kPurpleTextColor,
            weight: FontWeight.w600,
            size: 18,
          ),
          const SizedBox(
            height: 18,
          ),
          blocBuilderNews()
        ],
      ),
    );
  }

  BlocBuilder<NewsBloc, NewsState> blocBuilderNews() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          return ListViewBeritaWidget(
            length: state.news.data.length, 
            data: state.news, 
            isLoading: false
          );
        } else if(state is NewsFailed) {
          return Text(state.message);
        } else {
          return ListViewBeritaWidget(
            length: 2, 
            data: News(data: [NewsData(id: 1, judul: 'judul', image: 'image', content: 'content', createdAt: DateTime.now()),NewsData(id: 1, judul: 'judul', image: 'image', content: 'content', createdAt: DateTime.now())]), 
            isLoading: true
          );
        }
      },
    );
  }

  Row rowSubAppWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconAndAppNameWidget(
          image: 'assets/images/book.png',
          name: 'Xedu Belajar',
          onIconTap: () {},
        ),
        IconAndAppNameWidget(
          image: 'assets/images/video.png',
          name: 'Xedu Video',
          onIconTap: () async {
            await _launchURL();
          },
        ),
        IconAndAppNameWidget(
          image: 'assets/images/health.png',
          name: 'Xedu Health',
          onIconTap: () {},
        ),
      ],
    );
  }

  Future<void> _launchURL() async {
    await AppCheck.launchApp("com.google.android.youtube");
  }

  Container containerUserDataWidget() {
    return Container(
      width: 317,
      padding: const EdgeInsets.fromLTRB(15, 9, 15, 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 3),
            color: Color.fromRGBO(149, 149, 149, .25),
          )
        ],
      ),
      child: Row(
        children: [
          RowImageAndTextWidget(
            image: 'assets/images/user.png',
            subtitleText: '17 Tahun',
            titleText: 'Pelajar',
          ),
          SizedBox(
            width: 32,
          ),
          RowImageAndTextWidget(
            image: 'assets/images/school.png',
            subtitleText: user.data.sekolah!.namaSekolah.substring(8),
            titleText: user.data.sekolah!.namaSekolah.substring(0, 7),
            subtitleColor: Color.fromRGBO(97, 97, 97, 1),
          ),
        ],
      ),
    );
  }

  Container purpleBoxWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 15,
      margin: EdgeInsets.zero,
      color: kPrimaryColor,
    );
  }

  SliverAppBar appBar() {
    return SliverAppBar(
      expandedHeight: Platform.isIOS ? 220 : 250,
      pinned: true,
      elevation: 0,
      title: Visibility(
        visible: _scrollMatrix >= 180 && true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo_primary_bg.png',
              height: 40,
            ),
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 26,
            )
          ],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(8, 80, 27, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo_primary_bg.png',
                    width: 163,
                  ),
                  const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 32,
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 22, 0, 0),
                  child: CustomTextWidget(
                    text: 'Hai ${user.data.namaLengkap},',
                    weight: FontWeight.w500,
                    size: 17,
                    color: Colors.white,
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: CustomTextWidget(
                  text: 'Bagaimana Kabarmu?',
                  weight: FontWeight.w500,
                  size: 17,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
