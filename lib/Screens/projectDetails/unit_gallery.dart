
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redefineerp/Screens/projectDetails/gallery_detail.dart';
import 'package:redefineerp/Screens/projectDetails/unit_galleryController.dart';
import 'package:redefineerp/themes/themes.dart';

class UnitGallery extends StatelessWidget {
  UnitGallery({super.key});

  GalleryController galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => galleryController.isSelected.value == false
          ? Scaffold(
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.020,
                    horizontal: MediaQuery.of(context).size.height * 0.020,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 8,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent:
                                        MediaQuery.of(context).size.height *
                                            0.27,
                                    crossAxisSpacing:
                                        MediaQuery.of(context).size.width *
                                            0.041,
                                    crossAxisCount: 2,
                                    mainAxisSpacing:
                                        MediaQuery.of(context).size.height *
                                            0.010),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  galleryController.isSelected.value = true;
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  // height: MediaQuery.of(context).size.height * 0.8,
                                  // width: MediaQuery.of(context).size.width * 3,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(18))),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image:  AssetImage("assets/images/room.png"))),
                                      ),
                                      PhysicalModel(
                                        elevation: 0.4,
                                        color: Colors.blueGrey,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.050,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                3,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight: Radius.circular(8),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.020),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Home Decor",
                                                      style: displayMedium,
                                                    ),
                                                  ]),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.7,
                        left: MediaQuery.of(context).size.width * 0.350,
                        child: InkWell(
                          onTap: () {
                            _request(context);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.060,
                            width: MediaQuery.of(context).size.width * 0.24,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                border: Border.all(
                                    width: 2,
                                    color: appLightTheme.primaryColor)),
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.add,
                                  color: appLightTheme.primaryColor,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.010,
                                ),
                                Text(
                                  "Add",
                                  style: GoogleFonts.inter(
                                      color: appLightTheme.primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Spacer()
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            )
          : GalleryDetail(),
    );
  }

  _request(BuildContext context) {
    Get.defaultDialog(
        title: 'Choose an option',
        titleStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: appLightTheme.primaryColor),
        contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.020,
            horizontal: MediaQuery.of(context).size.width * 0.020),
        content: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.020),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.020,
                vertical: MediaQuery.of(context).size.height * 0.020),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    galleryController.getImage(ImageSource.camera);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Icon(Icons.camera),
                      Spacer(),
                      Text(
                        "Camera",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: appLightTheme.primaryColor),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.020,
                ),
                Divider(
                  thickness: MediaQuery.of(context).size.width * 0.002,
                  color: appLightTheme.primaryColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.020,
                ),
                GestureDetector(
                  onTap: () {
                    galleryController.getImage(ImageSource.gallery);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Icon(Icons.photo),
                      Spacer(),
                      Text(
                        "Gallery",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: appLightTheme.primaryColor),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
