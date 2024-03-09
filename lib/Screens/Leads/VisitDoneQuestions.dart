import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redefineerp/Screens/Leads/LeadDetailsController.dart';
import 'package:redefineerp/themes/customTheme.dart';
import 'package:redefineerp/themes/spacing.dart';
import 'package:redefineerp/themes/textFile.dart';
import 'package:redefineerp/themes/textStyle_theme.dart';

class VisitDoneExamScreen extends StatefulWidget {
  @override
  _VisitDoneExamScreenState createState() => _VisitDoneExamScreenState();
}

class _VisitDoneExamScreenState extends State<VisitDoneExamScreen> {
  late CustomTheme customTheme;
  LeadDetailsController leadController = Get.put(LeadDetailsController());
  late ThemeData theme;
int selectedEmote = 2;
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
   appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              MdiIcons.chevronLeft,
              size: 24,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          // title: FxText.titleMedium("Visit Done", fontWeight: 600),
        ),
        body: Column(
      children: <Widget>[
     
        Expanded(
          child: ListView(
            padding: FxSpacing.zero,
            children: <Widget>[
           Center(
              child: FxText.titleMedium("How was Site Visit Journey?",
                  color: theme.colorScheme.onBackground, fontWeight: 600),
            ),
            Container(
              margin: EdgeInsets.only(top: 24, left: 24, right: 24),
              child: feedbackEmote(),
            ),
           
              Container(
                margin: FxSpacing.fromLTRB(24, 24, 24, 0),
                child: Column(
                  children: <Widget>[
                 
                    Container(
                      margin: FxSpacing.top(16),
                      child: SingleQuestion(
                        qNumber: 1,
                        question:
                            "Site Visit Feedback",
                        options:   [
                            { 'label': 'Happy', 'value': 'happy' },
  {
    'label': 'Sad',
    'value': 'sad',
  },
  { 'label': 'Neutral', 'value': 'neutral' },
  { 'label': 'Want more options', 'value': 'more_options' },

  const { 'label': 'Others', 'value': 'others' },
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
           
                   Container(  margin: FxSpacing.fromLTRB(24, 24, 24, 0),
          padding: FxSpacing.all(8),
          decoration: BoxDecoration(
              color: customTheme.card,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: TextFormField(
                     controller:
                                                        leadController.siteVisitNotes,
                                                        
                    style: FxTextStyle.bodyMedium(
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500,
                        letterSpacing: 0,
                        muted: true),
                    decoration: InputDecoration(
                      hintText: "Type & make additional notes",
                      hintStyle: FxTextStyle.bodyMedium(
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600,
                          letterSpacing: 0,
                          xMuted: true),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color:
                                Colors.transparent,),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color:
                                theme.colorScheme.onBackground.withAlpha(50)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color:
                                theme.colorScheme.onBackground.withAlpha(50)),
                      ),
                    ),
                    maxLines: 6,
                    minLines: 4,
                    autofocus: false,
                    textCapitalization: TextCapitalization.sentences,
                  ),
        ),


 

                         ],
          ),
        ),
     
      Container(
            color: customTheme.card,
            padding: FxSpacing.fromLTRB(24, 16, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(children: <TextSpan>[
                  
                    TextSpan(
                        text: "Set lead status",
                        style: FxTextStyle.bodySmall(
                          fontWeight: 600,
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                        )),
                  ]),
                ),
                InkWell(
                  onTap: () => {
                    leadController.updateSiteVisitDone()
                  },
                  child: Container(
                    padding: FxSpacing.fromLTRB(8, 8, 8, 8),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Row(
                      children: [
                        Container(
                          margin: FxSpacing.left(12),
                          child: FxText.bodySmall("Visit Done".toUpperCase(),
                              fontSize: 12,
                              letterSpacing: 0.7,
                              color: theme.colorScheme.onPrimary,
                              fontWeight: 600),
                        ),
                        Container(
                          margin: FxSpacing.left(16),
                          padding: FxSpacing.all(4),
                          decoration: BoxDecoration(
                              color: theme.colorScheme.onPrimary,
                              shape: BoxShape.circle),
                          child: Icon(
                            MdiIcons.chevronRight,
                            size: 20,
                            color: theme.colorScheme.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
       
      ],
    ));
  }
   Widget feedbackEmote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              selectedEmote = 0;
            });
          },
          child: Icon(
            selectedEmote == 0
                ? MdiIcons.emoticonSad
                : MdiIcons.emoticonSadOutline,
            color: selectedEmote == 0
                ? theme.colorScheme.primary
                : theme.colorScheme.onBackground,
            size: 40,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedEmote = 1;
            });
          },
          child: Icon(
            selectedEmote == 1
                ? MdiIcons.emoticonNeutral
                : MdiIcons.emoticonNeutralOutline,
            color: selectedEmote == 1
                ? theme.colorScheme.primary
                : theme.colorScheme.onBackground,
            size: 40,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedEmote = 2;
            });
          },
          child: Icon(
            selectedEmote == 2
                ? MdiIcons.emoticonHappy
                : MdiIcons.emoticonHappyOutline,
            color: selectedEmote == 2
                ? theme.colorScheme.primary
                : theme.colorScheme.onBackground,
            size: 40,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedEmote = 3;
            });
          },
          child: Icon(
            selectedEmote == 3 ? MdiIcons.emoticon : MdiIcons.emoticonOutline,
            color: selectedEmote == 3
                ? theme.colorScheme.primary
                : theme.colorScheme.onBackground,
            size: 40,
          ),
        ),
      ],
    );
  }

}

class SingleQuestion extends StatefulWidget {
  final int? qNumber;
  final String? question;
  final  options;

  const SingleQuestion({Key? key, this.qNumber, this.question, this.options})
      : super(key: key);

  @override
  _SingleQuestionState createState() => _SingleQuestionState();
}

class _SingleQuestionState extends State<SingleQuestion> {
  late CustomTheme customTheme;
  late ThemeData theme;
  LeadDetailsController leadController = Get.put(LeadDetailsController());
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

  int selectedOption = 0;

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
              leadController.siteVisitFeedback.value = widget.options![i]['value'];
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
                      color:  leadController.siteVisitFeedback.value == widget.options![i]['value']
                          ? customTheme.colorSuccess
                          : customTheme.card,
                      borderRadius: BorderRadius.all(Radius.circular(
                        4,
                      ))),
                  child: Center(
                    child: leadController.siteVisitFeedback.value == widget.options![i]['value']
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
                  child: FxText.titleSmall(widget.options![i]['label'],
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
