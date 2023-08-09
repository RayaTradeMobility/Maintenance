// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maintenance/API/API.dart';
import 'package:maintenance/Models/loginModel.dart';
import 'package:maintenance/Views/homeScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Constants.dart';
import '../Services/checkNetwork.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity();
  bool _isloading =false;
  LoginModel? loginModel;
  String error = "";
  bool _passwordVisibility = true;
  API api = API();

  Future<bool> checkNetwork() async {
    bool isNetworkAvailable = await _networkConnectivity.checkConnectivity();
    if (!isNetworkAvailable) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("No Internet Connection"),
            content: const Text(
                "Please check your internet connection and try again."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return isNetworkAvailable;
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();
    String? email = prefs.getString('email');
    String? password = await storage.read(key: 'password');
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
    }
  }

  Future<void> _saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();
    await prefs.setString('email', email);
    await storage.write(key: 'password', value: password);
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }


  bool isEmailValid(String email) => email.isNotEmpty;
  bool isPasswordValid(String password) => password.length >= 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 228, 226, 20),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 95),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/raya.png',
                            width: 350.0,
                            height: 180.0,
                          ),
                          loginCard(context),
                          const SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container loginCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(.2),
          borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person_rounded),
                Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    //<-- SEE HERE
                    fillColor: Colors.white,
                    hintText: "اسم المستخدم",
                    prefixIcon: const Icon(Icons.email),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                validator: (email) {
                  if (isEmailValid(email!)) {
                    return null;
                  } else {
                    return 'برجاء ادخال الايميل الشخصي';
                  }
                },

              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: _passwordVisibility,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisibility = !_passwordVisibility;
                      });
                    },
                  ),
                  hintText: "كلمة السر",
                  prefixIcon: const Icon(Icons.password),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (password) {
                  if (isPasswordValid(password!)) {
                    return null;
                  } else {
                    return 'كلمه السر يجب ان تكون اكبر من 7 حروف او ارقام';
                  }
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                  onPressed: () async {
                    _saveCredentials(
                        emailController.text, passwordController.text);
                    bool isNetworkAvailable = await checkNetwork();
                    setState(() {
                      _isloading = true;

                    });
                    if (!isNetworkAvailable) {
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                        LoginModel user = await api.login(emailController.text, passwordController.text);

                        if(user.user!= null){
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(siteRequestId:user.user!.siteRequestId! , mobileUsername: user.user!.mobileUsername!),
                          ),
                        ); }

                      else {
                        setState((){
                          _isloading = false;

                        });
                        Fluttertoast.showToast(
                          msg: "${user.headerInfo!.message}",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: MyColorsSample.primary.withOpacity(0.8),
                    fixedSize: const Size.fromWidth(500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _isloading ? const CircularProgressIndicator(color: Colors.white,strokeWidth: 2) :const Text("تسجيل الدخول"),
                    ],
                  ),
                ),
              ),
            ),
            Center(
                child: Text(
              error,
              style: const TextStyle(color: Colors.red),
            )),
          ],
        ),
      ),
    );
  }
}
