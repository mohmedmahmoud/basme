import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:mybim/logic/login_controller.dart';
import 'package:mybim/pages/custum_widget/defaultbutton.dart';

import 'package:mybim/style/input_decoration.dart';
import 'package:mybim/style/size_config.dart';
import 'package:mybim/style/theme.dart';
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
          backgroundColor: Theme.of(context).backgroundColor,
          body: SlidingUpPanel(
            controller: _panelController,
            maxHeight: getProportionateScreenHeight(330),
            minHeight: 60,
            parallaxEnabled: false,
            parallaxOffset: 1,
            onPanelClosed: () => _panelController.open(),
            body: const _body(),
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
            text: "S’inscrire",
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
            text: "Se connecter",
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  text: 'Scan Qr Code',
                  haveIcon: true,
                  icon: Icons.qr_code,
                  onTap: () {
                    _loginController.qrCodeAuthentification();
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Colors.white,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Expanded(
                          child: Divider(
                        thickness: 2,
                      )),
                      Text(
                        "où",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 2,
                      )),
                    ]),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Container(
                  height: getProportionateScreenHeight(50),
                  decoration: BoxDecoration(

                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.green,
                      //     Color(0xFF00b712),
                      //     Color(0xFF0bab64),
                      //   ],
                      // ),
                      // border: Border.all(color: Colors.grey.shade300, width: 2),
                      borderRadius: BorderRadius.circular(10)),
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
                              hintText: 'Entrez le code',
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
                const Text.rich(TextSpan(
                    text: 'En continuant, vous acceptez \n',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'les conditions',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: ' et ',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: 'la confidentialité',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ])),
              ]),
        ));
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
                        return 'Veuillez entrer votre numéro de téléphone';
                      } else if (value.length < 8 || value.length > 8) {
                        return 'Veuillez entrer un numéro de téléphone valide';
                      }
                      return null;
                    },
                    decoration: inputDecoration().copyWith(
                      hintText: 'téléphone',
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
                      hintText: 'mot de passe',
                      prefixIcon: const Icon(
                        Icons.lock,
                        size: 20,
                      ),
                    ),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Veuillez entrer mot de passe';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Defaultbutton(
                  text: 'Connexion',
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

class _body extends StatelessWidget {
  const _body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: greyColor,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/backgroud_1155.jpg'))),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          // 1155

          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          //   decoration: BoxDecoration(
          //       color: Colors.green.withOpacity(0.7),
          //       // border: Border.all(color: Colors.white60, width: 8),
          //       borderRadius: BorderRadius.circular(10)),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     // ignore: prefer_const_literals_to_create_immutables
          //     children: [
          //       const Icon(
          //         Icons.phone,
          //         color: Colors.white,
          //         size: 45,
          //       ),
          //       const Text(
          //         '1155',
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 35,
          //             fontWeight: FontWeight.w900),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
