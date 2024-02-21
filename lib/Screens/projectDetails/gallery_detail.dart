
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:redefineerp/Screens/projectDetails/unit_galleryController.dart';
import 'package:redefineerp/themes/themes.dart';

class GalleryDetail extends StatelessWidget {
  GalleryDetail({super.key});

  List<String> images = [
    'https://imgs.search.brave.com/wWhNdAtma-V1jbGy-PRRtixgy9NPZSAoSy6aEuofBpE/rs:fit:316:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5N/OGxia3RHcHl0a0FJ/dVM4a0VBVjhnSGFM/RyZwaWQ9QXBp',
    'https://imgs.search.brave.com/keRhsOoeCB0Lrz5UQ1HtLj6en8k9CtvJnCt0bP5yA3A/rs:fit:534:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5n/a0tmWGN5SlY4Q0t6/U2tSTUdGdDZBSGFH/ayZwaWQ9QXBp',
    'https://imgs.search.brave.com/4CSQcgpx-dnGtoEF7-eZZMy9AEKaXfY4pLChJl5aBf4/rs:fit:1200:1200:1/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzJiLzM5/LzM3LzJiMzkzN2M1/NDU3M2U2NDY2ZjM3/YTRmYWU2NmI4YjJm/LmpwZw',
    'https://imgs.search.brave.com/1MMabCYg0icXJocOkFW1gmLxJkUNees1TrMzGrbkbko/rs:fit:664:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5F/ZHN0U044REtDWWxa/X1FldkswSVp3SGFG/UyZwaWQ9QXBp',
    'https://imgs.search.brave.com/gGqIQ_ij9klej_DHQYKmFaCWe3AWO5AwEUQbpbOQe0Q/rs:fit:632:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC4w/c2lIdEJ4WDM1ejhV/NGNNY2NTdktBSGFG/aiZwaWQ9QXBp'
  ];

  GalleryController galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.020,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.0250,
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Home Decor",
                              style: displayLarge,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.person_outline),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.030,
                                ),
                                Text(
                                  "User20233",
                                  style: tinyRegular,
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.more_horiz)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.010,
                  ),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.020,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(images[
                                    galleryController.selectedimg.value])),
                            color: Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(13))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.020,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Sat 03:12 PM",
                          style: titleNormal,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.share_outlined,
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.030,
                        ),
                        const Icon(Icons.star_outline),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.020,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.020,
                    ),
                    child: Text(
                      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Aliquet nec ullamcorper sit amet risus nullam eget.''',
                      style: titleNormal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.160,
              width: MediaQuery.of(context).size.width * 1,
              child: ListView.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      galleryController.selectedimg.value = index;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.020),
                      height: MediaQuery.of(context).size.height * 0.160,
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(images[index])),
                          color: Colors.black,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13))),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
