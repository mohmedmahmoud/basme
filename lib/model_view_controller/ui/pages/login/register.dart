import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Basme/model_view_controller/data/model/user_model.dart';
import 'package:Basme/model_view_controller/logic/login_controller.dart';
import 'package:Basme/model_view_controller/ui/custum_widget/defaultbutton.dart';
import 'package:Basme/model_view_controller/ui/style/input_decoration.dart';
import 'package:Basme/model_view_controller/ui/style/size_config.dart';

class Register extends StatefulWidget {
  const Register({Key? key, this.userModel}) : super(key: key);
  final User? userModel;
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final LoginController _loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formSignUp = GlobalKey<FormState>();
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  late TextEditingController _nameController;
  // String? _role;
  // final List<String> _roles = ['Chauffeur', 'Medecine', 'Opérateur'];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.userModel?.phone);
    _passwordController =
        TextEditingController(text: widget.userModel?.password);

    _nameController = TextEditingController(text: widget.userModel?.name);
    // _role = widget.userModel?.role;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();

    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: getProportionateScreenWidth(5),
              top: getProportionateScreenHeight(85),
              child: Container(
                width: getProportionateScreenWidth(30),
                height: getProportionateScreenWidth(30),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(5)),
                ),
              ),
            ),
            Positioned(
              right: -getProportionateScreenWidth(5),
              top: -getProportionateScreenHeight(5),
              child: Container(
                width: getProportionateScreenWidth(60),
                height: getProportionateScreenWidth(60),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(5)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15),
              ),
              child: Form(
                  key: _formSignUp,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(Icons.arrow_back_outlined),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(50),
                        ),
                        Container(
                          padding: EdgeInsets.all(
                            getProportionateScreenHeight(20),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "S’inscrire".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Text('C’est rapide et facile.'.tr),
                              SizedBox(
                                height: getProportionateScreenHeight(50),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(50),
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: inputDecoration().copyWith(
                                    hintText: 'votre nom'.tr,
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre nom'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(50),
                                child: TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre numéro de téléphone'
                                          .tr;
                                    } else if (value.length < 8 ||
                                        value.length > 8) {
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
                                height: getProportionateScreenHeight(30),
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer mot de passe'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(40),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Defaultbutton(
                                    text: "S’inscrire".tr,
                                    width: 150,
                                    haveIcon: true,
                                    onTap: () {
                                      if (_formSignUp.currentState!
                                          .validate()) {
                                        _loginController.signUp(
                                            user: User(
                                                name:
                                                    _nameController.text.trim(),
                                                phone: _phoneController.text
                                                    .trim(),
                                                password: _passwordController
                                                    .text
                                                    .trim(),
                                                role: widget.userModel!.role,
                                                id: widget.userModel!.id,
                                                nameAgency: widget
                                                    .userModel!.nameAgency,
                                                idAgency:
                                                    widget.userModel!.idAgency,
                                                phoneId:
                                                    widget.userModel!.phoneId,
                                                idSuperUser: widget
                                                    .userModel!.idSuperUser,
                                                latitudeAgency: widget
                                                    .userModel!.latitudeAgency,
                                                longitudeAgency: widget
                                                    .userModel!.longitudeAgency,
                                                createAt:
                                                    widget.userModel!.createAt,
                                                timeWorking: widget
                                                    .userModel!.timeWorking,
                                                updateAt: DateTime.now()));
                                      }
                                    },
                                    color: Theme.of(context).primaryColor,
                                    textcolor: Colors.white,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
