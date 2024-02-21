
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redefineerp/Screens/projectDetails/unit_screen.dart';
import 'package:redefineerp/themes/themes.dart';

class ProjectUnitScreen extends StatelessWidget {
  const ProjectUnitScreen({required this.projectDetails, super.key});
  final projectDetails;
  @override
  Widget build(BuildContext context) {
    print('data1 ${projectDetails.data()}');
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.005,
              horizontal: MediaQuery.of(context).size.width * 0.050,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back_ios), iconSize: 16,),
                    
                  
                    const Spacer()
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.075,
                      width: MediaQuery.of(context).size.width * 0.20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/projectImage.png")),
                        borderRadius: BorderRadius.all(
                          Radius.circular(19),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.040,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${projectDetails['projectName']}",
                          style: headline2,
                        ),
                      
                           RichText(
                          text: TextSpan(children: [
                          
                            TextSpan(
                                text: "${projectDetails?['totalUnitCount']}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.8,
                                    color: Color(0xFF303437))),
                                      TextSpan(
                                text: "-${projectDetails?['projectType']['name']} ",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.8,
                                    color: Color(0xFF72777A))),
                          ]),
                        ),
                        
                          ],
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                LinearProgressIndicator(
                  backgroundColor: const Color(0xFFE3E5E5),
                  color: appLightTheme.primaryColorDark,
                  value: 0.6,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
          


                const TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
            
                    tabs: [
                      Tab(
                        text: 'Units',

                      ),
                      Tab(
                        text: 'Customisations',
                      ),
                      Tab(
                        text: 'Club House',
                      ),
                    ]),
                          StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('spark_units')
          .where("pId", isEqualTo: projectDetails['uid'])
          // .orderBy("unit_no")
          .snapshots(),
      builder:
          (BuildContext context,snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
        
  var totalTasks = snapshot.data!.docs.toList();

  // Sort the list based on the 'unit_no' field.
  totalTasks.sort((a, b) {
    final numA = num.tryParse(a['unit_no']?.toString() ?? '');
    final numB = num.tryParse(b['unit_no']?.toString() ?? '');

    if (numA == null && numB == null) {
      return 0; // Both values are not parseable, consider them equal.
    }

    if (numA == null) {
      return 1; // a is not parseable, so b comes first.
    }

    if (numB == null) {
      return -1; // b is not parseable, so a comes first.
    }

    return numA.compareTo(numB);
  });

                  return   SizedBox(
                  height: MediaQuery.of(context).size.height * 0.63,
                  child: TabBarView(children: [
                    for (int i = 0; i < 1; i++) UnitScreen( unitArrayPayload: totalTasks,),
                  ]),
                );
                    return Text('obj ${totalTasks.length}');
        }

        return Text('obj');
          }),
              
              ],
            ),
          ),
        )),
      ),
    );
  }
}
