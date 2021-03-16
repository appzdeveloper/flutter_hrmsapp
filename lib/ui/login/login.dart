import 'package:hrms/constants/strings.dart';
import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/routes.dart';
import 'package:hrms/stores/form/form_store.dart';
import 'package:hrms/widgets/app_icon_widget.dart';
import 'package:hrms/widgets/box_button_widget.dart';
import 'package:hrms/widgets/empty_app_bar_widget.dart';
import 'package:hrms/widgets/progress_indicator_widget.dart';
import 'package:hrms/widgets/rounded_button_widget.dart';
import 'package:hrms/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flushbar/flushbar_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //focus node
  FocusNode _passwordFocusNode;

  //form key
  final _formKey = GlobalKey<FormState>();

  //store
  final _store = FormStore();

  @override
  void initState() {
    super.initState();

    _passwordFocusNode = FocusNode();

    _userEmailController.addListener(() {
      //this will be called whenever user types in some value
      _store.setUserId(_userEmailController.text);
    });
    _passwordController.addListener(() {
      //this will be called whenever user types in some value
      _store.setPassword(_passwordController.text);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _store.loading ? CustomProgressIndicatorWidget() : _buildBody(),
    );
  }

  Center _buildBody() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFF60C3FF), Color(0xFF5574F7)])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            OrientationBuilder(
              builder: (context, orientation) {
                //variable to hold widget
                var child;
                //check to see whether device is in landscape or portrait
                //load widgets based on device orientation
                child = Center(child: _buildRightSide());
                return child;
              },
            ),
            Observer(
              name: 'navigate',
              builder: (context) {
                return _store.success
                    ? navigate(context)
                    : showErrorMessage(context, _store.errorStore.errorMessage);
              },
            ),
            Observer(
              name: 'loading',
              builder: (context) {
                return Visibility(
                  visible: _store.loading,
                  child: CustomProgressIndicatorWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        'assets/images/img_login.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text(
                Strings.login_page_title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'),
              )),
              SizedBox(height: 100.0),
              _buildUserIdField(),
              _buildPasswordField(),
              SizedBox(height: 50.0),
              _buildSignInButton(),
              _buildForgotPasswordButton(),
              SizedBox(height: 100.0),
              _buildRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          label: Strings.emailLabel,
          textAlignment: TextAlign.start,
          hint: Strings.email_hint,
          inputType: TextInputType.emailAddress,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          label: Strings.passwordLabel,
          textAlignment: TextAlign.start,
          hint: Strings.password_hint,
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          errorText: _store.formErrorStore.password,
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text(
          Strings.login_btn_forgot_password,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.white30),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Center(
          child: Text(
            'REGISTER',
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white, fontSize: 22.0),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.register, (Route<dynamic> route) => false);
        },
      ),
    );
  }

  Widget _buildSignInButton() {
    return BoxButtonWidget(
      buttonText: Strings.login_btn_sign_in,
      buttonColor: Colors.white,
      textColor: Color(0xFF5887F9),
      onPressed: () async {
        if (_store.canLogin) {
          _store.login();
        } else {
          showErrorMessage(context, 'Please fill in all fields');
        }
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  showErrorMessage(BuildContext context, String message) {
    if (message != null) {
      FlushbarHelper.createError(
        message: message,
        title: 'Error',
        duration: Duration(seconds: 3),
      )..show(context);
    }

    return Container();
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboard, (Route<dynamic> route) => false);
    });

    return Container();
  }
}
