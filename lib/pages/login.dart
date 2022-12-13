import 'package:dropdown_button2/dropdown_button2.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final _countryCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseLoginProvider _auth = FirebaseLoginProvider();
  bool formErrorCheck = false;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

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
                                    fontFamily: "Inter",
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
      child: TextFormField(
          obscureText: _obscureText,
          style: TextStyle(color: Colors.white),
          controller: _passwordController,
          autofocus: false,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Lütfen bir şifre belirleyin';
            }
            if (value.trim().length < 6) {
              return 'Şifreniz en az 6 karakter uzunluğunda olmalıdır.';
            }
            if (value.contains("?=.*[a-z]")) return null;
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
    );
    final emailField = Form(
      key: _formKey,
      child: TextFormField(
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
    );

    final nameField = TextFormField(
        controller: _nameController,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.length < 3 && value.length > 50) {
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
        ));

    final surnameField = TextFormField(
        controller: _surnameController,
        autofocus: false,
        validator: (value) {
          if (value != null) {
            if (value.length < 3 && value.length > 50) {
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
        ));

    final phoneNumberfield = TextFormField(
        controller: _phoneNumberController,
        keyboardType: TextInputType.phone,
        autofocus: false,
        maxLength: 10,
        validator: (value) {
          if (value != null) {
            if (value.length < 9 && value.length > 11) {
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
        ));

    final countryCodeField = TextFormField(
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
                        text: TextSpan(
                            style: TextStyle(fontFamily: "Inter"),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: "SanaLira'ya ",
                                  style: TextStyle(
                                      color: sanaLiraGreen,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "Yeni Üyelik",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))
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
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
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
                  padding: const EdgeInsets.fromLTRB(5, 5, 15, 0),
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
                    Expanded(flex: 8, child: (countryCodeField)),
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
                    child: Text(
                      "Hesabınızı oluştururken sözleşme ve koşulları kabul etmeniz gerekir.",
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontSize: 14),
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

                  if (_passwordFormKey.currentState!.validate()) ;

                  provider.signIn(
                    email: _emailController.text.toString(),
                    password: _passwordController.text.toString(),
                  );
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: sanaLiraGreen,
                    textStyle:
                        const TextStyle(fontSize: 18, fontFamily: "Inter")),
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
