import 'package:event_app/providers/userProvider.dart';
import 'package:event_app/screens/auth/login.dart';
import 'package:event_app/screens/auth/verifyEmail.dart';
import 'package:event_app/services/auth.dart';
import 'package:event_app/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static String id = "Register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmpasswordFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _auth = Auth();

  bool _passwordVisible = false;
  bool _confpasswordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
    _confpasswordVisible = false;
    Geolocator.requestPermission();
  }

  bool validateNumber(String input) {
    RegExp pattern = RegExp(r'^0\d+$');
    return pattern.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color(0xff827397),
                    Theme.of(context).primaryColor,
                  ],
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      "Please enter your details to register on the app",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _globalKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40.0),
                              TextFormField(
                                controller: _nameController,
                                focusNode: _nameFocusNode,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_emailFocusNode),
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter your Name!';
                                  } else if (!RegExp(r'^[a-zA-Z ]+$')
                                      .hasMatch(val)) {
                                    return 'Invalid name. Only letters and spaces are allowed.';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    FontAwesomeIcons.user,
                                    size: 25,
                                  ),
                                  labelText: 'Name',
                                  hintText: 'Enter your Name!',
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 34.0),
                              TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_addressFocusNode),
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter your email!';
                                  } else if (!RegExp(
                                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                      .hasMatch(val)) {
                                    return 'Invalid email address';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    size: 25,
                                  ),
                                  labelText: 'Email',
                                  hintText: 'Enter your email!',
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 34.0),
                              TextFormField(
                                controller: _addressController,
                                focusNode: _addressFocusNode,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode),
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.text,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter your address!';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.home,
                                    size: 25,
                                  ),
                                  labelText: 'Address',
                                  hintText: 'Enter your Address!',
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 34.0),
                              TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                validator: (val) => val!.isEmpty
                                    ? 'Please enter your password!'
                                    : null,
                                obscureText: !_passwordVisible,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.lock,
                                    size: 25,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  labelText: 'Password',
                                  hintText: 'Enter your pasword!',
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 34.0),
                              TextFormField(
                                controller: _confirmpasswordController,
                                focusNode: _confirmpasswordFocusNode,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please confirm password!';
                                  } else if (val != _passwordController.text) {
                                    return 'Passwords do not match!';
                                  }
                                  return null;
                                },
                                obscureText: !_confpasswordVisible,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    FontAwesomeIcons.lock,
                                    size: 25,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _confpasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _confpasswordVisible =
                                            !_confpasswordVisible;
                                      });
                                    },
                                  ),
                                  labelText: 'Confirm Password',
                                  hintText: 'Confirm your password!',
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, Login.id);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              MainButton(
                                text: "Register",
                                hasCircularBorder: true,
                                onTap: () async {
                                  if (_globalKey.currentState!.validate()) {
                                    _globalKey.currentState!.save();
                                    try {
                                      final authresult = await _auth.signUp(
                                        _emailController.text,
                                        _passwordController.text,
                                        _nameController.text,
                                        _addressController.text,
                                      );
                                      print(authresult.user!.email);
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.toString(),
                                          ),
                                        ),
                                      );
                                    }
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                  create: (_) => UserProvider(),
                                                  child:
                                                      const EmailVerifyScreen()),
                                        ));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
