import 'package:flutter/material.dart';
import 'package:tres_det/authentication/authentication_services.dart';

const appName = "TresDet";
const appTagLine = "Got you";

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SignInPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isSignUp = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    authFunction(value) {
      if (value == 'login successfull' || value == 'signup successfull') {
        setState(() {
          errorMessage = '';
        });

        Navigator.of(context).pushReplacementNamed('home_page');
      } else {
        setState(() {
          errorMessage = value;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text(
              appName,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              appTagLine,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              child: SafeArea(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 65),
                    child: SizedBox(
                        // child: Image.asset(
                        //   'assets/images/food_image_login_screen.png',
                        //   color: Colors.white30,
                        //   height: 150,
                        // ),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _isSignUp ? 'CREATE ACCOUNT' : 'SIGN IN',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 21,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _isSignUp
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter name';
                              }
                              if (value.toString().length < 3) {
                                return 'Too small';
                              }
                              return null;
                            },
                          ),
                        )
                      : Container(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        labelText: 'Email Id',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email id';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        if (value.toString().length < 6) {
                          return 'Password should have atleast 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  !_isSignUp
                      ? TextButton(
                          child: Text('Forgot Password'),
                          onPressed: () {
                            //forgot password screen
                          },
                        )
                      : Container(),
                  errorMessage != ''
                      ? SizedBox(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            final email = emailController.value.text.trim();
                            final password = passwordController.value.text;
                            final name = nameController.value.text;
                            _isSignUp
                                ? signUp(
                                        email: email,
                                        password: password,
                                        name: name)
                                    .then((value) => authFunction(value))
                                : signIn(email: email, password: password)
                                    .then((value) => authFunction(value));
                          }
                        },
                        child: Text(
                          _isSignUp ? 'Sign Up' : 'Sign In',
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          _isSignUp
                              ? 'Already have account? Sign In'
                              : 'Does not have account? Sign Up',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _isSignUp = _isSignUp ? false : true;
                            errorMessage = '';
                          });
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
