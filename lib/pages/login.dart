import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sanalira_test/utility/colors.dart';

import '../utility/country_data.dart';
import '../utility/firebase/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginBackgroundImage = "lib/assets/images/png/login_background.png";
  final sanaLiraLogo = "lib/assets/images/png/sanalira_logo.png";
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _surnameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneNumberFormKey = GlobalKey<FormState>();
  final _countryCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseLoginProvider _auth = FirebaseLoginProvider();
  String defaultCountryCode = "+90";
  String defaultCountrySvgValue = "lib/assets/images/svg/turkey.svg";
  bool formErrorCheck = false;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  List<String> countryCodeList = [];

  bool _contractCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    loginBackgroundImage,
                  ),
                  fit: BoxFit.fill,
                )),
              ),
              //Background Filter
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    customBackgroundFilter1.withOpacity(0.8),
                    customBackgroundFilter2.withOpacity(0.8),
                  ],
                )),
              ),
              //Content
              Column(
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                          child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                  sanaLiraLogo,
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text("SanaLira",
                                style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ))),

                  //LoginForm
                  Flexible(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            color: loginFormBackground.withOpacity(0.75)),
                        child: LoginForm(_contractCheck),
                      )),
                ],
              ),
            ]),
          ),
        ));
  }

  Column LoginForm(bool _contractCheck) {
    final passwordField = Form(
      key: _passwordFormKey,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _obscureText,
            style: TextStyle(color: Colors.white),
            controller: _passwordController,
            autofocus: false,
            validator: (value) {
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
              if (value == null || value.trim().isEmpty) {
                return 'Lütfen bir şifre belirleyin';
              } else if (!regex.hasMatch(value)) {
                return "Şifreniz küçük harf, büyük harf, sayı ve özel karakter içermelidir.";
              } else if (value.trim().length < 6) {
                return 'Şifreniz en az 6 karakter uzunluğunda olmalıdır.';
              }
              if (value.trim().length > 20) {
                return 'Şifreniz en fazla 20 karakter uzunluğunda olmalıdır.';
              } else
                return null;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                hintText: "Lütfen şifre belirleyin",
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)))),
      ),
    );
    final emailField = Form(
      key: _emailFormKey,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailController,
            autofocus: false,
            validator: (value) {
              if (value != null) {
                if (value.contains('@') && value.endsWith('.com')) {
                  return null;
                }
                return 'Lütfen doğru bir e-posta adresi kullanın.';
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              hintText: "esrefyasa@monegon.com",
            )),
      ),
    );

    final nameField = Form(
      key: _nameFormKey,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _nameController,
            autofocus: false,
            validator: (value) {
              if (value != null) {
                if (value.length > 3 && value.length < 50) {
                  return null;
                }
                return 'İsminiz en az 3 karakter olmalıdır!';
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              hintText: "Eşref IBAN",
            )),
      ),
    );

    final surnameField = Form(
      key: _surnameFormKey,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _surnameController,
            autofocus: false,
            validator: (value) {
              if (value != null) {
                if (value.length > 3 && value.length < 50) {
                  return null;
                }
                return 'Soyisminiz en az 3 karakter olmalıdır!';
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              hintText: "Yaşa",
            )),
      ),
    );

    final phoneNumberfield = Form(
      key: _phoneNumberFormKey,
      child: SizedBox(
        height: 60,
        child: TextFormField(
            style: TextStyle(color: Colors.white),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            autofocus: false,
            maxLength: 10,
            validator: (value) {
              if (value != null) {
                if (value.length == 10) {
                  return null;
                }
                return 'Telefon numaranızı kontrol ediniz !';
              }
            },
            decoration: InputDecoration(
              counterText: "", //Disabling the counter under the form ( 0/10 )
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              hintText: "(535) 123 45 67",
            )),
      ),
    );

    final countryCodeField = SizedBox(
      height: 60,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _countryCodeController,
        keyboardType: TextInputType.phone,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.length > 3) {
              return null;
            }
            return 'Hatalı Ülke Kodu!';
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          hintText: "+90",
          prefixIcon: Padding(
            padding: const EdgeInsets.all(7.0),
            child: SvgPicture.asset("lib/assets/images/svg/turkey.svg"),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: const <TextSpan>[
                          TextSpan(
                              text: "SanaLira'ya ",
                              style: TextStyle(
                                  color: sanaLiraGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "Yeni Üyelik",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16))
                        ]),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text("Bilgilerinizi girip sözleşmeyi onaylayın.",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14))
                    ]),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Ad",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12),
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Form(child: nameField),
                    ],
                  ),
                )),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "Soyad",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12),
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      surnameField,
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                emailField,
              ],
            ),
          )),
        ),
        Flexible(
          flex: 3,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Şifre",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                passwordField,
              ],
            ),
          )),
        ),
        Flexible(
          flex: 3,
          child: Container(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Cep Telefonu Numaranız",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 12),
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                  ),
                                  builder: (BuildContext context) {
                                    return Card();
                                  });
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: SvgPicture.asset(
                                        defaultCountrySvgValue,
                                        width: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      defaultCountryCode,
                                      style: TextStyle(
                                        color: customGrey,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        )),
                    Spacer(flex: 1),
                    Expanded(flex: 22, child: phoneNumberfield),
                  ],
                ),
              ],
            ),
          )),
        ),
        Flexible(
          flex: 2,
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    child: new Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        value: this._contractCheck,
                        onChanged: (bool? value) {
                          setState(() {
                            this._contractCheck = value!;
                          });
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: RichText(
                          text: TextSpan(children: const <TextSpan>[
                            TextSpan(
                                text: "Hesabınızı oluştururken",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            TextSpan(
                                text: " sözleşme ve koşulları ",
                                style: TextStyle(
                                    color: sanaLiraGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "kabul etmeniz gerekir.",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14))
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {
                  final provider = Provider.of<FirebaseLoginProvider>(context,
                      listen: false);

                  if (_passwordFormKey.currentState!.validate() &&
                      _emailFormKey.currentState!.validate() &&
                      _nameFormKey.currentState!.validate() &&
                      _surnameFormKey.currentState!.validate() &&
                      _phoneNumberFormKey.currentState!.validate() == true) {}
                  provider
                      .registerWithEmail(
                        email: _emailController.text.toString(),
                        password: _passwordController.text.toString(),
                      )
                      .whenComplete(() => provider.firestoreUserCreation(
                            userId: FirebaseAuth.instance.currentUser!.uid
                                .toString(),
                            email: _emailController.text.toString(),
                            creationDate: DateTime.now().toString(),
                            name: _nameController.text.toString(),
                            countryCode: defaultCountryCode.toString(),
                            surname: _surnameController.text.toString(),
                            phoneNumber: _phoneNumberController.text.toString(),
                          ));
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: sanaLiraGreen,
                    textStyle: const TextStyle(fontSize: 18)),
                child: const Text(
                  'Kayıt Ol',
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
