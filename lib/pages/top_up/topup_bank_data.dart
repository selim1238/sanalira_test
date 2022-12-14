import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sanalira_test/api/sanalira_request.dart';
import 'package:sanalira_test/models/sanalira_model.dart';
import 'package:flutter/services.dart';

import '../../utility/colors.dart';

class TopupBankData extends StatefulWidget {
  const TopupBankData({super.key});

  @override
  State<TopupBankData> createState() => _TopupBankDataState();
}

class _TopupBankDataState extends State<TopupBankData> {
  late Future<SanaliraModel> _sanaliraModel;

  @override
  void initState() {
    _sanaliraModel = SanaliraRequest().getSanaliraData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _sanaliraModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //BankData item
              var item = snapshot.data!.data;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25)),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Container(
                                          color: Colors.black,
                                          height: 3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 0, 15, 0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text("Hesap Adı",
                                                      style: TextStyle(
                                                          color: customGrey))),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 5, 15, 5),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    14,
                                                decoration: BoxDecoration(
                                                    color: customContainerGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15, 0, 0, 0),
                                                        child: Text(
                                                            item[index]
                                                                .bankAccountName,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 15, 0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Clipboard.setData(
                                                                ClipboardData(
                                                                    text: item[
                                                                            index]
                                                                        .bankAccountName
                                                                        .toString()));
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Panoya Kopyalandı",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          child: Icon(
                                                            Icons.content_copy,
                                                            color:
                                                                sanaLiraGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 0, 15, 0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text("IBAN",
                                                      style: TextStyle(
                                                          color: customGrey))),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 5, 15, 5),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    12,
                                                decoration: BoxDecoration(
                                                    color: customContainerGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15, 0, 0, 0),
                                                        child: Text(
                                                            item[index]
                                                                .bankIban,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 15, 0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Clipboard.setData(
                                                                ClipboardData(
                                                                    text: item[
                                                                            index]
                                                                        .bankAccountName
                                                                        .toString()));
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Panoya Kopyalandı",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          child: Icon(
                                                            Icons.content_copy,
                                                            color:
                                                                sanaLiraGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 0, 15, 0),
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: Text("Açıklama",
                                                      style: TextStyle(
                                                          color: customGrey))),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 5, 15, 5),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    12,
                                                decoration: BoxDecoration(
                                                    color: customContainerGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15, 0, 0, 0),
                                                        child: Text(
                                                            item[index]
                                                                .descriptionNo,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    "Inter",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 15, 0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            await Clipboard.setData(
                                                                ClipboardData(
                                                                    text: item[
                                                                            index]
                                                                        .bankAccountName
                                                                        .toString()));
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Panoya Kopyalandı",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          child: Icon(
                                                            Icons.content_copy,
                                                            color:
                                                                sanaLiraGreen,
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              14,
                                          decoration: BoxDecoration(
                                              color: customContainerGrey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 15, 0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Center(
                                                child: Text(
                                                    "Lütfen havale yaparken açıklama alanına yukarıdaki kodu yazmayı unutmayın.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: customTextGrey,
                                                        fontSize: 12,
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 5),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              14,
                                          decoration: BoxDecoration(
                                              color: customContainerRed,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 15, 0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Center(
                                                child: Text(
                                                    "Eksik bilgi girilmesi sebebiyle tutarın askıda kalması durumunda, ücret kesintisi yapılacaktır.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: customTextRed,
                                                        fontSize: 12,
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height / 8,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                if (item[index].bankName ==
                                    "T.C. ZİRAAT BANKASI A.Ş.")
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(10),
                                          color: Colors.black,
                                          dashPattern: [3, 6, 3, 6],
                                          strokeWidth: 0.5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: Image.asset(
                                                  "lib/assets/images/png/ziraat_logo.png"),
                                            ),
                                          ),
                                        ),
                                      )),
                                if (item[index].bankName ==
                                    "ALBARAKA TÜRK KATILIM BANKASI A.Ş.")
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              color: Colors.black,
                                              dashPattern: [3, 6, 3, 6],
                                              strokeWidth: 0.5,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    child: Image.asset(
                                                      "lib/assets/images/png/albaraka_logo.png",
                                                    ),
                                                  ))))),
                                if (item[index].bankName ==
                                    "TÜRKİYE VAKIFLAR BANKASI T.A.O.")
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              color: Colors.black,
                                              dashPattern: [3, 6, 3, 6],
                                              strokeWidth: 0.5,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    child: Image.asset(
                                                      "lib/assets/images/png/vakifbank_logo.png",
                                                    ),
                                                  ))))),
                                if (item[index].bankName == "AKBANK T.A.Ş.")
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              color: Colors.black,
                                              dashPattern: [3, 6, 3, 6],
                                              strokeWidth: 0.5,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    child: Image.asset(
                                                      "lib/assets/images/png/akbank_logo.png",
                                                    ),
                                                  ))))),
                                if (item[index].bankName ==
                                    "KUVEYT TÜRK KATILIM BANKASI A.Ş.")
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              color: Colors.black,
                                              dashPattern: [3, 6, 3, 6],
                                              strokeWidth: 0.5,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    child: Image.asset(
                                                      "lib/assets/images/png/kuveytturk_logo.png",
                                                    ),
                                                  ))))),
                                if (item[index].bankName ==
                                    "TÜRKİYE GARANTİ BANKASI A.Ş.")
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              color: Colors.black,
                                              dashPattern: [3, 6, 3, 6],
                                              strokeWidth: 0.5,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    child: Image.asset(
                                                      "lib/assets/images/png/garanti_logo.png",
                                                    ),
                                                  ))))),
                                if (item[index].bankName ==
                                    "QNB FİNANSBANK A.Ş.")
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              radius: Radius.circular(10),
                                              color: Colors.black,
                                              dashPattern: [3, 6, 3, 6],
                                              strokeWidth: 0.5,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            8,
                                                    child: Image.asset(
                                                      "lib/assets/images/png/qnb_logo.png",
                                                    ),
                                                  ))))),
                                Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                      child: Text(
                                                    item[index].bankName,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Inter",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FontStyle.normal),
                                                  )),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Container(
                                                      child: Text(
                                                    "Havale / EFT ile para gönderin.",
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
                                    )),
                              ],
                            )),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
