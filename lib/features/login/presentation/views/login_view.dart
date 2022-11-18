import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xedu/features/login/presentation/bloc/login_bloc.dart';
import 'package:xedu/features/login/presentation/views/auth_view.dart';
import 'package:xedu/features/register/presentation/views/register_view.dart';
import 'package:xedu/features/report/widgets/dialog_widget.dart';
import 'package:xedu/injection_container.dart';
import 'package:xedu/themes/color.dart';
import 'package:xedu/widgets/form_widget.dart';
import 'package:xedu/widgets/text_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailEditingController;
  late TextEditingController passwordEditingController;
  bool isObscure = true;
  bool? isBoxChecked = false;

  @override
  void initState() {
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            const SizedBox(
              height: 65,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 129,
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 21),
                    child: titleText(),
                  ),
                  subtitleWidget(),
                  const SizedBox(
                    height: 21,
                  ),
                  textfieldEmailWidget(),
                  const SizedBox(
                    height: 24,
                  ),
                  textFieldPasswordWidget(),
                  const SizedBox(
                    height: 21,
                  ),
                  rowRememberMe(),
                  const SizedBox(
                    height: 24,
                  ),
                  _blocListernerLogin(context),
                  const SizedBox(
                    height: 24,
                  ),
                  registerText(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  BlocListener<LoginBloc, LoginState> _blocListernerLogin(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginSuccess){
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (_) => AuthView()), 
            (route) => false
          );
        } else if (state is LoginFailed) {
          showDialog(context: context, builder: (_)=> ErrorDialog(errorValue: state.message,));
        } else {
          showDialog(context: context, builder: (_)=> LoadingDialog());
        }
      },
      child: elevatedButtonMasuk(context),
    );
  }

  Center registerText() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14,
          ),
          children: [
            const TextSpan(
              text: 'Belum punya akun? ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            TextSpan(
              text: 'Buat akun',
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
                        builder: (_) => const RegisterView(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Container elevatedButtonMasuk(BuildContext context) {
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
        onPressed: () => context.read<LoginBloc>().add(PostLoginEvent(email: emailEditingController.text, password: passwordEditingController.text)
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const CustomTextWidget(
          text: 'Masuk',
          size: 14,
          weight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Row rowRememberMe() {
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
          value: isBoxChecked,
          onChanged: (value) {
            setState(() {
              isBoxChecked = value;
            });
          },
        ),
        const CustomTextWidget(
          text: 'Ingat saya',
          size: 14,
        )
      ],
    );
  }

  CustomFormWidget textFieldPasswordWidget() {
    return CustomFormWidget(
      textEditingController: passwordEditingController,
      hintText: 'Password',
      isObscure: isObscure,
      suffixIcon:
          isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      onSuffixTap: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
    );
  }

  CustomFormWidget textfieldEmailWidget() {
    return CustomFormWidget(
      textEditingController: emailEditingController,
      hintText: 'Email',
    );
  }

  CustomTextWidget subtitleWidget() {
    return const CustomTextWidget(
      text:
          'Masuk degan No.Tlp dan password yang telah kamu buat disaat registrasi',
      color: Color.fromRGBO(43, 43, 67, 1),
    );
  }

  CustomTextWidget titleText() {
    return const CustomTextWidget(
      text: 'Masuk',
      color: Color.fromRGBO(43, 43, 67, 1),
      weight: FontWeight.w500,
      size: 23,
    );
  }

  Container divider() {
    return Container(
      height: 4,
      margin: const EdgeInsets.only(top: 24),
      color: Colors.grey[200],
    );
  }
}
