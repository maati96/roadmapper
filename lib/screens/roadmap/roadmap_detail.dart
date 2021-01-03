import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/utilities/theme.dart';
import 'package:url_launcher/url_launcher.dart';


class RoadmapDetail extends StatefulWidget {
  @override
  _RoadmapDetailState createState() => _RoadmapDetailState();
}

class _RoadmapDetailState extends State<RoadmapDetail> {
  int currentStep = 0;
  List<Step> steps = [
    Step(
      isActive: true,
      title: Text("Python Basics",),
      subtitle: Text("python Track"),
      content: Container(
        child: Text("python Track"),
      ),
    ),
    Step(
      isActive: true,
      title: Text("Python Basics"),
      subtitle: Text("python Track"),
      content: Container(
        child: Text("python Track"),
      ),
    ),
    Step(
      isActive: true,
      title: Text("Python Basics"),
      subtitle: Text("python Track"),
      content: Text("more detail"),
    ),
    Step(
      isActive: true,
      state: StepState.complete,
      title: Text("Python Basics"),
      content: Container(
        child: Text("python Track"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Python Roadmap"),),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RawMaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    constraints: BoxConstraints(
                        minWidth: 40.0, maxWidth: 40.0, maxHeight: 24.0),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _navbarCard(context),
            SizedBox(
              height: 30,
            ),
            _trackSteps(),
          ],
        ),
      ),
    );
  }

  Widget _navbarCard(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/illustrations/illustration-02.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Python RoadMap",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.code, color: Colors.white),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Learn every thing About python from scratch",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trackSteps() {
         final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      child: Theme(
        data: ThemeData(
          primaryColor: Color(0xFFFD7E77),
        ),
        child: Stepper(
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: [
                FlatButton(
                  color: themeProvider.themeData().buttonColor,
                  onPressed: onStepContinue,
                  child: Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton(
                  onPressed: onStepCancel,
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white)),
                  color: Color(0xFFFD7E77),
                  onPressed: _launchURL,
                  child: Text(
                    "More Details",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
          currentStep: this.currentStep,
          steps: steps,
          type: StepperType.vertical,
          onStepTapped: (step) {
            setState(() {
              currentStep = step;
            });
          },
          onStepContinue: () {
            setState(() {
              if (currentStep < steps.length - 1) {
                currentStep++;
              } else {
                currentStep = 0;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep--;
              } else {
                currentStep = 0;
              }
            });
          },
        ),
      ),
    );
  }



  _launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}
