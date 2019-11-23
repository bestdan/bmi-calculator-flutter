import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_content.dart';
import 'reusableCard.dart';
import 'constants.dart';

enum Gender { male, female }
enum Direction { up, down }

double calculateBMI(double height, int weight) {
  return weight / (height / 100 * height / 100);
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleCardColor = kInactiveCardColor;
  Color femaleCardColor = kInactiveCardColor;
  Gender gender = Gender.male;
  double height = 170.0;
  int weight = 60;
  int age = 38;
  Function oneDown(value) {
    return value--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        gender = Gender.male;
                      });
                    },
                    color: gender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.mars,
                      label: "Male",
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        gender = Gender.female;
                      });
                    },
                    color: gender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    cardChild: IconContent(
                      icon: FontAwesomeIcons.venus,
                      label: "Female",
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("BMI", style: kLabelTextStyle),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          calculateBMI(height, weight).toInt().toString(),
                          style: kNumberTextStyle,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ReusableCard(
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Height",
                        style: kLabelTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            height.toString(),
                            style: kNumberTextStyle,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'cm',
                            style: kLabelTextStyle,
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.blue,
                            thumbColor: kBottomContainerColor,
                            overlayColor: kBottomContainerColor.withAlpha(100),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 15.0,
                            ),
                            overlayShape: RoundSliderOverlayShape(
                              overlayRadius: 25.0,
                            )),
                        child: Slider(
                          min: 100.0,
                          max: 200.0,
                          value: height.toDouble(),
                          onChanged: (double newHeight) {
                            setState(() {
                              height = newHeight.roundToDouble();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  color: kActiveCardColor)),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    cardChild: IntegerUpdDownWidget(
                      label: "Weight",
                      value: weight,
                      oneDown: () {
                        setState(() {
                          weight--;
                        });
                      },
                      oneUp: () {
                        setState(() {
                          weight++;
                        });
                      },
                    ),
                    color: kActiveCardColor,
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: kActiveCardColor,
                    cardChild: IntegerUpdDownWidget(
                      label: "Age",
                      value: age,
                      oneDown: () {
                        setState(() {
                          age--;
                        });
                      },
                      oneUp: () {
                        setState(() {
                          age++;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              color: kBottomContainerColor,
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              height: kBottomContainerHeight)
        ],
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, @required this.onPressed});
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: onPressed,
        elevation: 0.0,
        constraints: BoxConstraints.tightFor(
          width: 56.0,
          height: 56.0,
        ),
        shape: CircleBorder(),
        fillColor: kRoundButtonColor,
        child: Icon(icon));
  }
}

class IntegerUpdDownWidget extends StatelessWidget {
  IntegerUpdDownWidget({this.label, this.value, this.oneUp, this.oneDown});

  final String label;
  final int value;
  final Function oneUp;
  final Function oneDown;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: kLabelTextStyle,
        ),
        Text(value.toString(), style: kNumberTextStyle),
        Row(
          children: <Widget>[
            Expanded(
              child: RoundIconButton(
                icon: FontAwesomeIcons.minus,
                onPressed: oneDown,
              ),
            ),
            Expanded(
              child: RoundIconButton(
                icon: FontAwesomeIcons.plus,
                onPressed: oneUp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
