import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybim/data/model/user_model.dart';
import 'package:mybim/logic/admin_controller.dart';
import 'package:mybim/logic/login_controller.dart';
import 'package:mybim/pages/custum_widget/defaultbutton.dart';
import 'package:mybim/style/input_decoration.dart';
import 'package:mybim/style/size_config.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({Key? key, this.userModel}) : super(key: key);
  final User? userModel;
  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  String? _role;
  final List<String> _roles = ['Chauffeur', 'Medecine', 'Opérateur'];
  AdminController adminController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.screenHeight! * 0.8,
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
                left: -getProportionateScreenWidth(20),
                bottom: getProportionateScreenHeight(1),
                child: Container(
                  width: getProportionateScreenWidth(100),
                  height: getProportionateScreenWidth(100),
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
                              "Créer un compte",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Text('C’est rapide et facile.'),
                            SizedBox(
                              height: getProportionateScreenHeight(50),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(30),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(50),
                              child: DropdownButtonFormField<String>(
                                icon:
                                    const Icon(Icons.arrow_downward, size: 16),
                                // isExpanded: true,
                                decoration: inputDecoration().copyWith(
                                  prefixIcon: const Icon(
                                    Icons.person_add,
                                    size: 20,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Veuillez choisir votre role';
                                  }
                                  return null;
                                },
                                value: _role,
                                hint: Text(
                                  _role ?? 'Choissisez votre role',
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(14)),
                                ),
                                items: _roles.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(14)),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _role = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(40),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Defaultbutton(
                                  text: "Créer ",
                                  width: 150,
                                  haveIcon: true,
                                  onTap: () {
                                    adminController.addUser(
                                        role: _role!,
                                        userModel: widget.userModel!);
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
