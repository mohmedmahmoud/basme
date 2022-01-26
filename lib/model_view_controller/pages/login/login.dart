import 'package:Basme/model_view_controller/logic/lang_controller.dart';
import 'package:Basme/model_view_controller/style/size_config.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import 'package:Basme/model_view_controller/logic/login_controller.dart';
import 'package:Basme/model_view_controller/pages/custum_widget/defaultbutton.dart';

import 'package:Basme/model_view_controller/style/input_decoration.dart';

import 'package:Basme/model_view_controller/style/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formSignIn = GlobalKey<FormState>();
  final GlobalKey<FormState> _formSignUp = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _codeController;
  late PanelController _panelController;
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _panelController = PanelController();
    _codeController = TextEditingController();
    // _panelController.open();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    _codeController.dispose();

    super.dispose();
  }

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      initState: (_) {},
      builder: (_loginController) {
        return Scaffold(
          backgroundColor: Colors.white70,
          body: SlidingUpPanel(
            controller: _panelController,
            maxHeight: getProportionateScreenHeight(360),
            minHeight: 60,
            parallaxEnabled: false,
            parallaxOffset: 1,
            onPanelClosed: () => _panelController.open(),
            body: _body(),
            panelBuilder: (sc) => _panel(),
          ),
        );
      },
    );
  }

  Widget _panel() {
    return Column(
      children: [
        _header(),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: getProportionateScreenHeight(235),
          child: PageView(
            onPageChanged: (index) {
              _loginController.toggleSignUpOrSignIn();
            },
            controller: _loginController.pageController,
            children: [
              _signUp(),
              _signIn(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Defaultbutton(
            text: "S’inscrire".tr,
            color: (_loginController.isSignUp) ? Colors.white : greyColor,
            border: BorderDirectional(
              top: const BorderSide(color: greyColor, width: 2),
              bottom: BorderSide(
                  color: (_loginController.isSignUp) ? Colors.white : greyColor,
                  width: 2),
              start: const BorderSide(color: greyColor, width: 2),
              end: const BorderSide(color: greyColor, width: 2),
            ),
            onTap: () {
              _loginController.toSignUp();
            },
            textcolor:
                (_loginController.isSignUp) ? Colors.black : Colors.black54,
            height: getProportionateScreenHeight(65),
          ),
        ),
        Expanded(
          child: Defaultbutton(
            text: "Se connecter".tr,
            textcolor:
                (_loginController.isSignUp) ? Colors.black54 : Colors.black,
            height: getProportionateScreenHeight(65),
            color: (_loginController.isSignUp) ? greyColor : Colors.white,
            border: BorderDirectional(
              top: const BorderSide(color: greyColor, width: 2),
              bottom: BorderSide(
                  color: (_loginController.isSignUp) ? greyColor : Colors.white,
                  width: 2),
              start: const BorderSide(color: greyColor, width: 2),
              end: const BorderSide(color: greyColor, width: 2),
            ),
            onTap: () {
              _loginController.toSignIn();
            },
          ),
        ),
      ],
    );
  }

  Widget _signUp() {
    _panelController.open();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formSignUp,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Defaultbutton(
                  text: 'Scan Qr Code'.tr,
                  haveIcon: true,
                  icon: Icons.qr_code,
                  onTap: () {
                    _loginController.qrCodeAuthentification();
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Colors.white,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Expanded(
                          child: Divider(
                        thickness: 2,
                      )),
                      Text(
                        "où".tr,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      const Expanded(
                          child: Divider(
                        thickness: 2,
                      )),
                    ]),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Container(
                  height: getProportionateScreenHeight(50),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          child: TextFormField(
                            obscureText: true,
                            controller: _codeController,
                            validator: (value) {
                              return (value!.isEmpty)
                                  ? " le champ est necessaire *".tr
                                  : null;
                            },
                            decoration: inputDecoration().copyWith(
                              hintText: 'Entrez le code'.tr,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formSignUp.currentState!.validate()) {
                            // Get.to(() => const Register());
                            _loginController.codeAuthentification(
                                code: _codeController.text.trim());
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1)),
                          child: const Icon(Icons.arrow_forward,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text.rich(TextSpan(
                    text: 'En continuant, vous acceptez \n'.tr,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'les conditions'.tr,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: ' et '.tr,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: 'la confidentialité'.tr,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ])),
              ]),
        ));
  }

  Widget _body() {
    return Container(
      decoration: const BoxDecoration(
        color: greyColor,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/backgroud_1155.jpg'),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white.withOpacity(0.9),
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.05),
                  Colors.white.withOpacity(0.015),
                  Colors.white.withOpacity(0.001),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Container(
                  width: 100,
                  height: 35,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.6),
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.05),
                        Colors.white.withOpacity(0.015),
                        Colors.white.withOpacity(0.001),
                      ],
                    ),
                  ),
                  child: GetBuilder<LangController>(
                    init: LangController(),
                    builder: (langController) {
                      return DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.language_outlined,
                            color: Colors.grey,
                            size: 15,
                          ),
                          value: langController.lang,
                          onChanged: (value) {
                            langController.changeLang(value ?? 'fr');
                          },
                          underline: Container(
                            color: Colors.white,
                          ),
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'fr',
                              child: Text(
                                'Francais',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            DropdownMenuItem<String>(
                                value: 'ar',
                                child: Text(
                                  'العربية',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ))
                          ]);
                    },
                  ),
                ),
                SvgPicture.asset('assets/icons/logo.svg',
                    height: getProportionateScreenHeight(125)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xff00C569),
                      // border: Border.all(color: Colors.white60, width: 8),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'BASME'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _signIn() {
    _panelController.open();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formSignIn,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone'.tr;
                      } else if (value.length < 8 || value.length > 8) {
                        return 'Veuillez entrer un numéro de téléphone valide'
                            .tr;
                      }
                      return null;
                    },
                    decoration: inputDecoration().copyWith(
                      hintText: 'téléphone'.tr,
                      prefixIcon: const Icon(
                        Icons.phone,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: inputDecoration().copyWith(
                      hintText: 'mot de passe'.tr,
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 20,
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer mot de passe'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Defaultbutton(
                  text: 'Connexion'.tr,
                  haveIcon: true,
                  onTap: () {
                    if (_formSignIn.currentState!.validate()) {
                      _loginController.signIn(
                          phone: _phoneController.text.trim(),
                          password: _passwordController.text.trim());
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Colors.white,
                ),
              ]),
        ));
  }
}
