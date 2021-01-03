import 'package:auth/auth.dart';
import 'package:auth/managers/auth_manager.dart';
import 'package:auth/models/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roadmap/screens/widgets/custom_flat_button.dart';
import 'package:roadmap/screens/widgets/custom_outline_button.dart';
import 'package:roadmap/screens/widgets/custom_text_field.dart';
import 'package:roadmap/state_mangement/auth/auth_cubit.dart';
import 'package:roadmap/state_mangement/auth/auth_state.dart';


class AuthPage extends StatefulWidget {
  final AuthManager _manager;
  final ISignUpService _signUpService;

  AuthPage(this._manager, this._signUpService);
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  PageController _controller = PageController();

  String _username = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false ,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _buildLogo(),
            ),
            SizedBox(height: 12.0),
            CubitConsumer<AuthCubit, AuthState>(builder: (_, state) {
              return _buildUI();
            }, listener: (context, state) {
              if (state is LoadingState) {
                _showLoader();
              }
              if (state is ErrorState) {
                Scaffold.of(context).showBottomSheet((context) => Text("error "));
                _hideLoader();
              }
            })
          ],
        ),
      ),
    );
  }

  _buildLogo() => Container(
        alignment: Alignment.center,
        child: Column(children: [
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fill,
          ),
          SizedBox(height: 10.0),
          RichText(
            text: TextSpan(
                text: 'Road',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                    text: ' Mapper',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                ]),
          )
        ]),
      );

  _buildUI() => Expanded(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            _signIn(),
            _signUp(),
          ],
        ),
      );

  _signIn() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            ..._emailAndPassword(),
            SizedBox(height: 30.0),
            CustomFlatButton(
              text: 'Sign in',
              size: Size(double.infinity, 54.0),
              onPressed: () {
                CubitProvider.of<AuthCubit>(context).signin(
                  widget._manager.email(
                    email: _email,
                    password: _password,
                  ),
                );
              },
            ),
            SizedBox(height: 30.0),
            CustomOutlineButton(
              text: 'Sign in with google',
              size: Size(double.infinity, 50.0),
              icon: SvgPicture.asset(
                'assets/google-icon.svg',
                height: 18.0,
                width: 18.0,
                fit: BoxFit.fill,
              ),
              onPressed: () {
                CubitProvider.of<AuthCubit>(context)
                    .signin(widget._manager.google);
              },
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Don\'t have an account?',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                children: [
                  TextSpan(
                    text: ' Sign up',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.elasticOut);
                      },
                  )
                ],
              ),
            )
          ],
        ),
      );

  _signUp() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            CustomTextField(
              hint: 'Username',
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              onChanged: (val) {
                _username = val;
              },
            ),
            SizedBox(height: 30.0),
            ..._emailAndPassword(),
            SizedBox(height: 30.0),
            CustomFlatButton(
              text: 'Sign up',
              size: Size(double.infinity, 54.0),
              onPressed: () {
                final user = User(
                  name: _username,
                  email: _email,
                  password: _password,
                );
                CubitProvider.of<AuthCubit>(context)
                    .signup(widget._signUpService, user);
              },
            ),
            SizedBox(height: 30.0),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'Already have an account?',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                children: [
                  TextSpan(
                    text: ' Sign in',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _controller.previousPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.elasticOut);
                      },
                  )
                ],
              ),
            )
          ],
        ),
      );

  List<Widget> _emailAndPassword() => [
        CustomTextField(
          hint: 'Email',
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          onChanged: (val) {
            _email = val;
          },
        ),
        SizedBox(height: 30.0),
        CustomTextField(
          hint: 'Password',
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          onChanged: (val) {
            _password = val;
          },
        )
      ];

  _showLoader() {
    var alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white70,
        ),
      ),
    );

    showDialog(
        context: context, barrierDismissible: true, builder: (_) => alert);
  }

  _hideLoader() {
    Navigator.of(context, rootNavigator: true).pop();
  }
}