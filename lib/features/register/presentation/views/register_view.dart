import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xedu/features/login/presentation/views/login_view.dart';
import 'package:xedu/features/register/domain/usecase/register_usecase.dart';
import 'package:xedu/features/register/presentation/bloc/register_bloc.dart';
import 'package:xedu/features/register/presentation/bloc/sekolah_bloc.dart';
import 'package:xedu/features/register/presentation/widget/dropdown_sekolah_widget.dart';
import 'package:xedu/features/widgets/dialog_widget.dart';
import 'package:xedu/injection_container.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/form_widget.dart';
import 'package:xedu/widgets/text_widget.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<RegisterBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SekolahBloc>()..add(GetSekolahEvent()),
        ),
      ],
      child: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController emailEditingController;
  late TextEditingController namaEditingController;
  late TextEditingController umurEditingController;
  late TextEditingController alamatEditingController;
  late TextEditingController telpEditingController;
  late TextEditingController passwordEditingController;
  bool isObscure = true;
  bool? isPria = false;
  bool? isWanita = false;
  String? gender;
  late int? dropdownValue;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailEditingController = TextEditingController();
    namaEditingController = TextEditingController();
    umurEditingController = TextEditingController();
    alamatEditingController = TextEditingController();
    telpEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    dropdownValue = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          children: [
            const SizedBox(height: 48),
            headingImage(),
            const SizedBox(
              height: 16,
            ),
            textTitle(),
            const SizedBox(
              height: 18,
            ),
            subtitleWidget(),
            const SizedBox(height: 21),
            textfieldEmailWidget(),
            const SizedBox(
              height: 8,
            ),
            smolTextWidget(),
            const SizedBox(
              height: 18,
            ),
            textfieldNamaWidget(),
            const SizedBox(
              height: 21,
            ),
            textfieldUmurWidget(),
            const SizedBox(
              height: 21,
            ),
            textfieldAlamatWidget(),
            const SizedBox(
              height: 21,
            ),
            textfieldTeleponWidget(),
            const SizedBox(
              height: 21,
            ),
            blocBuilderSekolah(),
            const SizedBox(
              height: 28,
            ),
            textfieldPasswordWidget(),
            const SizedBox(
              height: 28,
            ),
            rowGenderWidget(),
            const SizedBox(
              height: 24,
            ),
            blocListenerRegisterBtn(context),
            const SizedBox(
              height: 24,
            ),
            textLoginWidget()
          ],
        ),
      ),
    );
  }

  BlocListener<RegisterBloc, RegisterState> blocListenerRegisterBtn(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if(state is RegisterSuccess){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: 'Akun berhasil dibuat silahkan login!');
        } else if (state is RegisterFailed){
          showDialog(
            context: context, 
            builder: (_) => ErrorDialog(errorValue: state.message,),
          );
        } else {
          showDialog(
            context: context, 
            builder: (_) => LoadingDialog(),
          );
        }
      },
      child: elevatedButtonRegister(context),
    );
  }

  BlocBuilder<SekolahBloc, SekolahState> blocBuilderSekolah() {
    return BlocBuilder<SekolahBloc, SekolahState>(
      builder: (context, state) {
        if (state is SekolahLoaded) {
          return DropdownSekolahWidget(
            data: state.sekolahData,
            dropdownValue: dropdownValue,
            onChanged: (value) {
              setState(() {
                dropdownValue = value;
              });
            },
          );
        } else if (state is SekolahFailed) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Center textLoginWidget() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
          ),
          children: [
            const TextSpan(
              text: 'Sudah punya akun? ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: 'Masuk',
              style: const TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                fontSize: 13,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                          builder: (_) => const LoginView()),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container elevatedButtonRegister(BuildContext context) {
    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 8),
            color: Color.fromRGBO(78, 96, 255, 0.16),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<RegisterBloc>().add(
              PostRegistrationEvent(
                params: RegisterParams(
                  email: emailEditingController.text,
                  namaLengkap: namaEditingController.text,
                  umur: int.parse(umurEditingController.text),
                  alamat: alamatEditingController.text,
                  noTelp: telpEditingController.text,
                  sekolahId: dropdownValue!,
                  jenisKelamin: gender!,
                  password: passwordEditingController.text
                )
              )
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const CustomTextWidget(
          text: 'Daftar',
          size: 14,
          weight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Row rowGenderWidget() {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          activeColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
          ),
          value: isPria,
          onChanged: (value) {
            setState(() {
              isPria = value;
              isPria == true ? gender = 'pria' : gender = '';
              if (isWanita == true) isWanita = false;
            });
          },
        ),
        const CustomTextWidget(
          text: 'Laki-laki',
          size: 14,
          color: Color.fromRGBO(104, 104, 104, 1),
        ),
        const SizedBox(
          width: 28,
        ),
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          activeColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(
              color: Color.fromRGBO(112, 112, 112, 1),
            ),
          ),
          value: isWanita,
          onChanged: (value) {
            setState(() {
              isWanita = value;
              isWanita == true ? gender = 'wanita' : gender = '';
              if (isPria == true) isPria = false;
            });
          },
        ),
        const CustomTextWidget(
          text: 'Perempuan',
          size: 14,
          color: Color.fromRGBO(104, 104, 104, 1),
        )
      ],
    );
  }

  CustomFormWidget textfieldPasswordWidget() {
    return CustomFormWidget(
      textEditingController: passwordEditingController,
      hintText: 'Buat password',
      isObscure: isObscure,
      suffixIcon:
          isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      onSuffixTap: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
      errorMessage: 'password tidak boleh kosong',
    );
  }

  CustomFormWidget textfieldTeleponWidget() {
    return CustomFormWidget(
      textEditingController: telpEditingController,
      hintText: 'No Telepon',
      keyboardType: TextInputType.number,
      errorMessage: 'no telepon tidak boleh kosong',
    );
  }

  CustomFormWidget textfieldAlamatWidget() {
    return CustomFormWidget(
      textEditingController: alamatEditingController,
      hintText: 'Alamat',
      errorMessage: 'alamat tidak boleh kosong',
    );
  }

  CustomFormWidget textfieldUmurWidget() {
    return CustomFormWidget(
      textEditingController: umurEditingController,
      hintText: 'Umur',
      keyboardType: TextInputType.number,
      errorMessage: 'umur tidak boleh kosong',
    );
  }

  CustomFormWidget textfieldNamaWidget() {
    return CustomFormWidget(
      textEditingController: namaEditingController,
      hintText: 'Nama Lengkap',
      errorMessage: 'nama tidak boleh kosong',
    );
  }

  CustomTextWidget smolTextWidget() {
    return const CustomTextWidget(
      text: 'Pastika email yang kamu daftarkan adalah valid',
      size: 10,
      color: Color.fromRGBO(92, 92, 92, 1),
    );
  }

  CustomFormWidget textfieldEmailWidget() {
    return CustomFormWidget(
      textEditingController: emailEditingController,
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      errorMessage: 'email tidak boleh kosong',
    );
  }

  Center subtitleWidget() {
    return const Center(
      child: CustomTextWidget(
        text: 'Daftarkan akunmu sekarang',
      ),
    );
  }

  Center textTitle() {
    return const Center(
      child: CustomTextWidget(
        text: 'Registrasi Akun',
        weight: FontWeight.w500,
        size: 23,
      ),
    );
  }

  Image headingImage() {
    return Image.asset(
      'assets/images/logo.png',
      height: 82,
    );
  }
}
