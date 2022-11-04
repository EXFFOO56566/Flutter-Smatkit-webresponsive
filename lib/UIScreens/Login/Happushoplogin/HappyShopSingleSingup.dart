import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopColor.dart';
import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopString.dart';
import 'package:smartkit/FullApp/HappyShop/widget/HappyShopbtn.dart';
import 'package:smartkit/SmartkitScreen/Screen/AppSplash.dart';
import 'package:smartkit/UIScreens/Login/LoginRoute.dart';

class HappyShopSingleSingup extends StatefulWidget {
  HappyShopSingleSingup({Key key}) : super(key: key);

  @override
  _HappyShopSingleSingupState createState() => _HappyShopSingleSingupState();
}

class _HappyShopSingleSingupState extends State<HappyShopSingleSingup> with TickerProviderStateMixin {
  bool _showPassword = false;
  bool visible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final ccodeController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String name, email, password, mobile, id, countrycode, countryName;

  Animation buttonSqueezeanimation;

  AnimationController buttonController;

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      validatanimations();
    }
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  Future<void> validatanimations() async {
    await buttonController.reverse();
    Future.delayed(Duration(milliseconds: 500)).then((_) async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginRoute()));
    });
  }

  bool validateAndSave() {
    return true;
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginRoute(),
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: back(),
          child: Center(
            child: Column(
              children: <Widget>[
                expandedBottomView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  back() {
    return BoxDecoration(
      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primaryLight2, primaryLight3], stops: [0, 1]),
    );
  }

  subLogo() {
    return Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Center(
        child: new SvgPicture.network(
          'https://smartkit.wrteam.in/smartkit/images/happyshopwhitelogo.svg',
          width: 80.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  registerTxt() {
    return Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: Center(
          child: new Text(USER_REGISTRATION, style: Theme.of(context).textTheme.headline6.copyWith(color: lightblack)),
        ));
  }

  setUserName() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: nameController,
        onSaved: (String value) {
          name = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            hintText: NAMEHINT_LBL,
            prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  setCountryCode() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.9;
    return Padding(
        padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
        child: Container(
          width: width,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.0), border: Border.all(color: darkgrey)),
          child: CountryCodePicker(
              showCountryOnly: false,
              searchDecoration: InputDecoration(
                hintText: COUNTRY_CODE_LBL,
                fillColor: primary,
              ),
              showOnlyCountryWhenClosed: false,
              initialSelection: 'IN',
              dialogSize: Size(width, height),
              alignLeft: true,
              builder: _buildCountryPicker,
              onChanged: (CountryCode countryCode) {
                countrycode = countryCode.toString().replaceFirst("+", "");
                print("New Country selected: " + countryCode.toString());
                countryName = countryCode.name;
              },
              onInit: (code) {
                print("on init ${code.name} ${code.dialCode} ${code.name}");
                countrycode = code.toString().replaceFirst("+", "");
                print("New Country selected: " + code.toString());
              }),
        ));
  }

  Widget _buildCountryPicker(CountryCode country) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Image.asset(
                country.flagUri,
                package: 'country_code_picker',
                height: 40,
                width: 20,
              ),
            ),
          ),
          new Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Text(country.dialCode),
            ),
          ),
          new Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: new Text(
                country.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );

  setMobileNo() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: mobileController,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onSaved: (String value) {
          mobile = value;
          // print('Mobile no:$mobile');
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.call_outlined),
            hintText: MOBILEHINT_LBL,
            prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  setEmail() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        onSaved: (String value) {
          email = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            hintText: EMAILHINT_LBL,
            prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  setPass() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: !this._showPassword,
        controller: passwordController,
        onSaved: (val) => password = val,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            hintText: PASSHINT_LBL,
            prefixIconConstraints: BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  showPass() {
    return Padding(
        padding: EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Checkbox(
              value: _showPassword,
              onChanged: (bool value) {
                setState(() {
                  _showPassword = value;
                });
              },
            ),
            Text(SHOW_PASSWORD, style: Theme.of(context).textTheme.bodyText1.copyWith(color: lightblack2))
          ],
        ));
  }

  verifyBtn() {
    return AppBtn(
      title: VERIFY_MOBILE_NUMBER,
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () async {
        // validateAndSubmit();
      },
    );
  }

  loginTxt() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(ALREADY_A_CUSTOMER, style: Theme.of(context).textTheme.bodyText1.copyWith(color: lightblack)),
          InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (BuildContext context) => HappyShopSingleLogin(),
                // ));
              },
              child: Text(
                LOG_IN_LBL,
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: primary, decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }

  expandedBottomView() {
    double width = MediaQuery.of(context).size.width;
    return Expanded(
        child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  subLogo(),
                  Container(
                    width: width,
                    padding: EdgeInsets.only(top: 20.0),
                    child: Form(
                      key: _formkey,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            registerTxt(),
                            setUserName(),
                            setCountryCode(),
                            setMobileNo(),
                            setEmail(),
                            setPass(),
                            showPass(),
                            verifyBtn(),
                            loginTxt(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  @override
  void initState() {
    super.initState();
    buttonController = new AnimationController(duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: devicewidth * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
  }
}
