import 'dart:async';

import 'package:flutter/material.dart';

import '../conf/auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailCtr = TextEditingController(),
      _nameCtr = TextEditingController(),
      _pwdCtr = TextEditingController();
  bool hidePassword = true, _ctrEValidate = false, _isClicked = false;
  Timer? _eTimer;

  void _eTimerFunction() {
    _eTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        if (_emailCtr.text.contains(RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
          setState(() {
            _ctrEValidate = false;
          });
        } else {
          setState(() {
            _ctrEValidate = true;
          });
        }
      });
    });
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _snackBarCustom() {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: const Text('Fitur dalam pengembangan'),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailCtr.dispose();
    _nameCtr.dispose();
    _pwdCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              Image.asset('assets/vector_1.jpg', height: 250, width: 250),
              TextFormField(
                controller: _nameCtr,
                style: const TextStyle(color: Colors.pinkAccent),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Icon(Icons.person, color: Colors.brown[300]),
                    ),
                    filled: true,
                    fillColor: Colors.brown[50],
                    hintText: 'Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50))),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailCtr,
                style: const TextStyle(color: Colors.pinkAccent),
                onChanged: (value) {
                  _eTimer != null ? _eTimer!.cancel() : null;
                  _eTimerFunction();
                },
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(18),
                      child:
                          Icon(Icons.alternate_email, color: Colors.brown[300]),
                    ),
                    suffixIcon: _ctrEValidate == true
                        ? const Padding(
                            padding: EdgeInsets.fromLTRB(0, 18, 18, 18),
                            child: Icon(Icons.priority_high_rounded,
                                color: Colors.red),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.brown[50],
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50))),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  TextFormField(
                    controller: _pwdCtr,
                    obscureText: hidePassword,
                    decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 15),
                          child: Icon(Icons.lock, color: Colors.brown[300]),
                        ),
                        suffixIcon: IconButton(
                          splashRadius: 1,
                          icon: hidePassword
                              ? Icon(Icons.visibility_off,
                                  color: Colors.brown[300])
                              : const Icon(Icons.visibility,
                                  color: Colors.pinkAccent),
                          onPressed: () =>
                              setState(() => hidePassword = !hidePassword),
                          padding: const EdgeInsets.all(18),
                        ),
                        filled: true,
                        fillColor: Colors.brown[50],
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      animationDuration: const Duration(milliseconds: 500),
                      splashFactory: InkSparkle.splashFactory,
                      primary: Colors.brown[300],
                      minimumSize: const Size(120, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_emailCtr.text == "" ||
                        _pwdCtr.text == "" ||
                        _nameCtr.text == "") {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.red,
                          content: const Text("Fill the form first!")));
                      return;
                    }
                    setState(() {
                      _isClicked = true;
                    });
                    var log = await Auth.register(
                        _emailCtr.text, _pwdCtr.text, _nameCtr.text);
                    setState(() {
                      _isClicked = false;
                    });
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            log == null ? Colors.green : Colors.red,
                        content: Text(log ?? "Registered!")));
                    if (log == null) {
                      Navigator.pushReplacementNamed(context, '/login');
                    } else {
                      print(log);
                    }
                  },
                  child: _isClicked == false
                      ? const Text('SIGN UP')
                      : const CircularProgressIndicator(color: Colors.white)),
              const SizedBox(height: 40),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account ?"),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent),
                          ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Divider(
                              thickness: 1,
                              color: Colors.brown[300],
                              indent: 20,
                              endIndent: 8)),
                      Text('or sign up using',
                          style: TextStyle(color: Colors.brown[300])),
                      Flexible(
                          child: Divider(
                              thickness: 1,
                              color: Colors.brown[300],
                              indent: 8,
                              endIndent: 20))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          splashRadius: 1,
                          onPressed: () => _snackBarCustom(),
                          icon: Image.asset('assets/imageicon_fb.png'),
                          iconSize: 40),
                      IconButton(
                          splashRadius: 1,
                          onPressed: () => _snackBarCustom(),
                          icon: Image.asset('assets/imageicon_tw.png'),
                          iconSize: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30)),
                      IconButton(
                          splashRadius: 1,
                          onPressed: () => _snackBarCustom(),
                          icon: Image.asset('assets/imageicon_gp.png'),
                          iconSize: 40),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
