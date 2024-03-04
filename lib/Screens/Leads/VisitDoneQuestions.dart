import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redefineerp/themes/customTheme.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';

class VisitDoneExamScreen extends StatefulWidget {
  @override
  _VisitDoneExamScreenState createState() => _VisitDoneExamScreenState();
}

class _VisitDoneExamScreenState extends State<VisitDoneExamScreen> {
  late CustomTheme customTheme;

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
     customTheme = CustomTheme.lightCustomTheme;
     theme = ThemeData.from(
      colorScheme: ColorScheme.light(
      ),
      // Customize other theme properties here if needed
    );
  }

  bool isPlaying = false;

  int repeatType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          margin: FxSpacing.fromLTRB(
              24, FxSpacing.safeAreaTop(context) + 20, 24, 0),
          padding: FxSpacing.all(16),
          decoration: BoxDecoration(
              color: customTheme.card,
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: customTheme.border, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FxText.bodyMedium("Scores",
                      color: theme.colorScheme.onBackground, fontWeight: 600),
                  Container(
                    margin: FxSpacing.top(8),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withAlpha(40),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Center(
                      child: FxText.bodyLarge("10",
                          color: theme.colorScheme.primary, fontWeight: 700),
                    ),
                  )
                ],
              ),
                ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: FxSpacing.zero,
            children: <Widget>[
              Container(
                margin: FxSpacing.fromLTRB(24, 16, 24, 0),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: FxSpacing.left(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.bodyLarge("Property Visit Review",
                              color: theme.colorScheme.onBackground,
                              fontWeight: 600),
                          Container(
                            margin: FxSpacing.top(2),
                            child: FxText.bodySmall("2 Questions",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500,
                                muted: true),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: FxSpacing.fromLTRB(24, 24, 24, 0),
                child: Column(
                  children: <Widget>[
                    SingleQuestion(
                      qNumber: 1,
                      question: "Property location",
                      options: const [
                        "Good",
                        "Satisfied",
                        "Not Satisfied",
                        "Can be better"
                      ],
                    ),
                    Container(
                      margin: FxSpacing.top(16),
                      child: SingleQuestion(
                        qNumber: 2,
                        question:
                            "Overall Site Visit Feeback",
                        options: const [
                          "Good",
                          "Satisfied",
                           "Not Satisfied",
                        "Can be better",
                        "Need more options"
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class SingleQuestion extends StatefulWidget {
  final int? qNumber;
  final String? question;
  final List<String>? options;

  const SingleQuestion({Key? key, this.qNumber, this.question, this.options})
      : super(key: key);

  @override
  _SingleQuestionState createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestion> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = CustomTheme.lightCustomTheme;
 
theme = ThemeData.from(
      colorScheme: ColorScheme.light(
        // Add other colors as needed
      ),
      // Customize other theme properties here if needed
    );
  }

  int selectedOption = -1;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);

    Widget buildOptions() {
      List<Widget> list = [];
      for (int i = 0; i < widget.options!.length; i++) {
        list.add(Container(
          margin: FxSpacing.bottom(12),
          child: InkWell(
            onTap: () {
              setState(() {
                selectedOption = i;
              });
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      color: selectedOption == i
                          ? customTheme.colorSuccess
                          : customTheme.card,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4,
                      ))),
                  child: Center(
                    child: selectedOption == i
                        ? Icon(
                            MdiIcons.check,
                            size: 16,
                            color: customTheme.onSuccess,
                          )
                        : Container(),
                  ),
                ),
                Container(
                  margin: FxSpacing.left(16),
                  child: FxText.titleSmall(widget.options![i],
                      color: theme.colorScheme.onBackground, fontWeight: 500),
                )
              ],
            ),
          ),
        ));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: FxSpacing.all(8),
          decoration: BoxDecoration(
              color: customTheme.card,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: FxText.bodyMedium("Q.${widget.qNumber}",
              color: theme.colorScheme.onBackground, fontWeight: 600),
        ),
        Expanded(
          child: Container(
            margin: FxSpacing.left(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FxText.bodyLarge(widget.question.toString(),
                    color: theme.colorScheme.onBackground, fontWeight: 600),
                Container(
                  margin: FxSpacing.top(16),
                  child: Column(
                    children: <Widget>[buildOptions()],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
