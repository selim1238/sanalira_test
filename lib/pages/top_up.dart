import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanalira_test/utility/colors.dart';
import 'package:sanalira_test/utility/custom_icons.dart';

class TopUpMenu extends StatelessWidget {
  const TopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: topupBackgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 36,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                onTap: () {
                                  //Will be a back button
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  color: Colors.white,
                                  child: Icon(
                                    CustomIcons.customBackArrow,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                //Will be a notification dropdown menu
                              },
                              child: Container(
                                height: 36,
                                width: 36,
                                color: Colors.white,
                                child: Icon(
                                  CustomIcons.customNotification,
                                  size: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: InkWell(
                                onTap: () {
                                  //Will be a settings menu button
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  color: Colors.white,
                                  child: Icon(
                                    CustomIcons.customSettings,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SizedBox(
                                    height: 36,
                                    width: 36,
                                    child: SvgPicture.asset(
                                      "lib/assets/images/svg/turkey.svg",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                  child: Text(
                                                "Türk Lirası",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: "Inter",
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              )),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                  child: Text(
                                                "TL",
                                                style: TextStyle(
                                                    color: customGrey,
                                                    fontSize: 12,
                                                    fontFamily: "Inter",
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FontStyle.normal),
                                              )),
                                            )
                                          ],
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                  child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "234 ₺",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      color: Colors.blue,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
