import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybim/data/model/user_model.dart';
import 'package:mybim/logic/login_controller.dart';
import 'package:mybim/pages/custum_widget/defaultbutton.dart';
import 'package:mybim/style/input_decoration.dart';
import 'package:mybim/style/size_config.dart';

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
                              const Text(
                                "S’inscrire",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                              Text('C’est rapide et facile.'),
                              SizedBox(
                                height: getProportionateScreenHeight(50),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(50),
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: inputDecoration().copyWith(
                                    hintText: 'votre nom',
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      size: 20,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre nom';
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
                                      return 'Veuillez entrer votre numéro de téléphone';
                                    } else if (value.length < 8 ||
                                        value.length > 8) {
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
                                height: getProportionateScreenHeight(30),
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer mot de passe';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(30),
                              ),
                              // SizedBox(
                              //   height: getProportionateScreenHeight(50),
                              //   child: DropdownButtonFormField<String>(
                              //     icon: const Icon(Icons.arrow_downward,
                              //         size: 16),
                              //     // isExpanded: true,
                              //     decoration: inputDecoration().copyWith(
                              //       prefixIcon: const Icon(
                              //         Icons.person_add,
                              //         size: 20,
                              //       ),
                              //     ),
                              //     validator: (value) {
                              //       if (value == null) {
                              //         return 'Veuillez choisir votre role';
                              //       }
                              //       return null;
                              //     },
                              //     value: _role,
                              //     hint: Text(
                              //       _role ?? 'Choissisez votre role',
                              //       style: TextStyle(
                              //           fontSize:
                              //               getProportionateScreenWidth(14)),
                              //     ),
                              //     items: _roles.map((String value) {
                              //       return DropdownMenuItem<String>(
                              //         value: value,
                              //         child: Text(
                              //           value,
                              //           style: TextStyle(
                              //               fontSize:
                              //                   getProportionateScreenWidth(
                              //                       14)),
                              //         ),
                              //       );
                              //     }).toList(),
                              //     onChanged: (value) {
                              //       setState(() {
                              //         _role = value;
                              //       });
                              //     },
                              //   ),
                              // ),
                              SizedBox(
                                height: getProportionateScreenHeight(40),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Defaultbutton(
                                    text: "S’inscrire",
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
