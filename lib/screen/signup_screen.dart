import 'dart:async';

import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _ctrE = TextEditingController(),
      _ctrU = TextEditingController(),
      _ctrP = TextEditingController();
  bool hidePassword = true, _ctrEValidate = false;

  Timer? _eTimer;

  void _eTimerFunction() {
    _eTimer = Timer(const Duration(seconds: 1), () {
      setState(() {
        if (_ctrE.text.contains(RegExp(
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _ctrE.dispose();
    _ctrP.dispose();
    _ctrU.dispose();
    _eTimer!.cancel();
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              Image.asset(
                'assets/vector_1.jpg',
                height: 250,
                width: 250,
              ),
              TextFormField(
                controller: _ctrE,
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
              TextFormField(
                controller: _ctrU,
                style: const TextStyle(color: Colors.pinkAccent),
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Icon(Icons.person, color: Colors.brown[300]),
                    ),
                    filled: true,
                    fillColor: Colors.brown[50],
                    hintText: 'Username',
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50))),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  TextFormField(
                    controller: _ctrP,
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
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      animationDuration: const Duration(milliseconds: 500),
                      splashFactory: InkSparkle.splashFactory,
                      primary: Colors.brown[300],
                      minimumSize: const Size(120, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: const Text(
                    'SIGNUP',
                    style: TextStyle(fontSize: 18),
                  )),
              const SizedBox(height: 50),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an Account ?"),
                      TextButton(
                          onPressed: () {},
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
                      Text('OR', style: TextStyle(color: Colors.brown[300])),
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
                          onPressed: () {},
                          icon: Image.asset('assets/imageicon_fb.png'),
                          iconSize: 40),
                      IconButton(
                          splashRadius: 1,
                          onPressed: () {},
                          icon: Image.asset('assets/imageicon_tw.png'),
                          iconSize: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30)),
                      IconButton(
                          splashRadius: 1,
                          onPressed: () {},
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
