import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prearticle/Configuration/app_config.dart';
import 'package:prearticle/Widgets/Loading.dart';
import 'package:prearticle/helpers/Validator.dart';
import 'package:prearticle/localizations.dart';
import 'package:prearticle/services/auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {



  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isButtonDisabled = false;
  String email = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    bool _loading = false;
/*     email = ModalRoute.of(context).settings.arguments;
    _email.text = email; */

    final logocontent = Stack(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: SizeConfig.blockSizeVertical * 47,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: SizeConfig.blockSizeVertical * 13.7),
            ),
            Hero(
              tag: widget.hashCode,
              child: Column(
                children: <Widget>[
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 26.7,
                    height: SizeConfig.blockSizeHorizontal * 36.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Pre ',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 7,
                          color: Color(0xff6e9bdf),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Article',
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 7,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Book Store',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                      letterSpacing: 3.6,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -30,
          right: -30,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 40,
            height: SizeConfig.blockSizeHorizontal * 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Color(0xffe7f0ff),
            ),
          ),
        ),
        Positioned(
          top: 300,
          left: -10,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 12.5,
            height: SizeConfig.blockSizeHorizontal * 12.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Color(0xffc6d2e3), Color(0xff6e9bdf)]),
            ),
          ),
        ),
      ],
    );

    final email = Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 15,
          right: SizeConfig.blockSizeHorizontal * 15,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: Icon(
                Icons.email,
              ),
            ),
            hintText: 'Email address',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 15,
                right: SizeConfig.blockSizeHorizontal * 15),
          ),
          autofocus: false,
          controller: _email,
          validator: Validator(labels).email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => null,
          onSaved: (value) => _email.text = value,
        ));

    final resetButton = GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          setState(() => _isButtonDisabled = !_isButtonDisabled);
          AuthService _auth = AuthService();
          await _auth.sendPasswordResetEmail(_email.text);

          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(labels.auth.resetPasswordNotice),
          ));
        }
      },
      child: Container(
        height: SizeConfig.blockSizeHorizontal * 15,
        width: SizeConfig.blockSizeHorizontal * 15,
        decoration: BoxDecoration(
            color: Color(0xff6e9bdf), borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 30,
        ),
      ),
    );

    final loginLevel = Container(
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: SizeConfig.safeBlockHorizontal * 10,
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final forgotPassword = Container(
      child: Text('Forgot Password'),
    );

    final signIn = Container(
        child: GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushReplacementNamed(context, '/signin');
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Text(
            'Already have an account ',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          )),
          Container(child: Text('SignIn?')),
        ],
      ),
    ));

    final signUp = Container(
        child: GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushReplacementNamed(context, '/signup');
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Text(
            'Don\'t have an account: ',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          )),
          Container(child: Text('SignUp?')),
        ],
      ),
    ));

    return Scaffold(
      key: _scaffoldKey,
      body: LoadingScreen(
        inAsyncCall: _loading,
        child: Form(
            key: _formKey,
            /* autovalidate: _autoValidate, */
            child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: 300,
                      minHeight: SizeConfig.blockSizeVertical * 100),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        logocontent,
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                loginLevel,
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 4.3,
                                ),
                                email,
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 4.3,
                                ),
                                resetButton,
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 1.7,
                                ),
                              ],
                            )),
                        signIn,
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        signUp,
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                      ],
                    ),
                  )),
            )),
      ),
    );
  }
/* 
  appBar() {
    final labels = AppLocalizations.of(context);
    if ((email == '') || (email == null)) {
      return null;
    }
    return AppBar(title: Text(labels.auth.resetPasswordTitle));
  }

  signInLink() {
    final labels = AppLocalizations.of(context);
    if ((email == '') || (email == null)) {
      return LabelButton(
        labelText: labels.auth.signInonResetPasswordLabelButton,
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
      );
    }
    return Container(width: 0, height: 0);
  } */



}