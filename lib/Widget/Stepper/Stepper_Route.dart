import 'package:flutter/material.dart';
import 'package:smartkit/Constant/SmartKitColor.dart';
import 'package:smartkit/SmartkitScreen/Screen/SmartKitAppbar.dart';

class Stepper_Route extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppScreenMode();
  }
}

class MyData {
  String name = '';
  String phone = '';
  String email = '';
  String age = '';
}

class MyAppScreenMode extends State<Stepper_Route> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: SmartKitAppbar(
            title: "Flutter UI Component",
          )),
      body: new StepperBody(),
    );
  }
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
      // print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    super.dispose();
  }

  List<Step> steps = [
    new Step(
        title: const Text('Name'),
        //subtitle: const Text('Enter your name'),
        isActive: true,
        //state: StepState.error,
        state: StepState.indexed,
        content: new TextFormField(
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          autocorrect: false,
          onSaved: (String value) {
            data.name = value;
          },
          maxLines: 1,
          //initialValue: 'Aseem Wangoo',
          validator: (value) {
            if (value.isEmpty || value.length < 1) {
              return 'Please enter name';
            }
          },
          decoration: new InputDecoration(
              labelText: 'Enter your name',
              hintText: 'Enter a name',
              //filled: true,
              icon: const Icon(Icons.person),
              labelStyle: new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
    new Step(
        title: const Text('Phone'),
        //subtitle: const Text('Subtitle'),
        isActive: true,
        //state: StepState.editing,
        state: StepState.indexed,
        content: new TextFormField(
          keyboardType: TextInputType.phone,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || value.length < 10) {
              return 'Please enter valid number';
            }
          },
          onSaved: (String value) {
            data.phone = value;
          },
          maxLines: 1,
          decoration: new InputDecoration(labelText: 'Enter your number', hintText: 'Enter a number', icon: const Icon(Icons.phone), labelStyle: new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
    new Step(
        title: const Text('Email'),
        // subtitle: const Text('Subtitle'),
        isActive: true,
        state: StepState.indexed,
        // state: StepState.disabled,
        content: new TextFormField(
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || !value.contains('@')) {
              return 'Please enter valid email';
            }
          },
          onSaved: (String value) {
            data.email = value;
          },
          maxLines: 1,
          decoration: new InputDecoration(labelText: 'Enter your email', hintText: 'Enter a email address', icon: const Icon(Icons.email), labelStyle: new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
    new Step(
        title: const Text('Age'),
        // subtitle: const Text('Subtitle'),
        isActive: true,
        state: StepState.indexed,
        content: new TextFormField(
          keyboardType: TextInputType.number,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || value.length > 2) {
              return 'Please enter valid age';
            }
          },
          maxLines: 1,
          onSaved: (String value) {
            data.age = value;
          },
          decoration: new InputDecoration(labelText: 'Enter your age', hintText: 'Enter age', icon: const Icon(Icons.ac_unit), labelStyle: new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
    // new Step(
    //     title: const Text('Fifth Step'),
    //     subtitle: const Text('Subtitle'),
    //     isActive: true,
    //     state: StepState.complete,
    //     content: const Text('Enjoy Step Fifth'))
  ];

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message, [MaterialColor color = Colors.red]) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();

        showDialog(
            builder: (context) => new AlertDialog(
                  title: new Text("Details"),
                  //content: new Text("Hello World"),
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: <Widget>[
                        new Text("Name : " + data.name),
                        new Text("Phone : " + data.phone),
                        new Text("Email : " + data.email),
                        new Text("Age : " + data.age),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new TextButton(
                      child: new Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
            context: context);
      }
    }

    return new Container(
        child: new Form(
      key: _formKey,
      child: new ListView(children: <Widget>[
        new Stepper(
          physics: ClampingScrollPhysics(),
          steps: steps,
          type: StepperType.vertical,
          currentStep: this.currStep,
          onStepContinue: () {
            setState(() {
              if (currStep < steps.length - 1) {
                currStep = currStep + 1;
              } else {
                currStep = 0;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currStep > 0) {
                currStep = currStep - 1;
              } else {
                currStep = 0;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              currStep = step;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: smarKitcolor2,
            ),
            child: new Text(
              'Save',
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: _submitDetails,
          ),
        ),
      ]),
    ));
  }
}
