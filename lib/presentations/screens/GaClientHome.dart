import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:gajiku/presentations/model/GaModel.dart';
import 'package:gajiku/presentations/utils/GaColors.dart';
import 'package:gajiku/presentations/utils/GaDataGenerator.dart';
import 'package:gajiku/presentations/utils/GaImages.dart';
import 'package:gajiku/presentations/utils/GaWidget.dart';

import 'BankingPaymentDetails.dart';

class GaClientHome extends StatefulWidget {
  @override
  GaClientHomeState createState() => GaClientHomeState();
}

class GaClientHomeState extends State<GaClientHome> {
  late SharedPreferences prefs;
  String name = "";
  String groupName = "";

  getPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = _prefs;
      name = prefs.getString("name").toString();
      groupName = prefs.getString("group_name").toString();
    });
  }

  int currentIndexPage = 0;
  int? pageLength;

  late List<BankingPaymentModel> clientGajiList;
  late List<BankingPaymentModel> laporanGajiList;
  late List<BankingPaymentModel> masterGajiList;
  late List<BankingHomeModel> mList1;
  late List<BankingHomeModel2> mList2;

  @override
  void initState() {
    setStatusBarColor(Banking_palColor);
    super.initState();
    getPrefs();
    currentIndexPage = 0;
    pageLength = 3;
    clientGajiList = gajikuClientGajiList();
    masterGajiList = gajikuMasterGajiList();
    laporanGajiList = gajikuLaporanGajiList();
    mList1 = bankingHomeList1();
    mList2 = bankingHomeList2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 330,
              floating: false,
              pinned: true,
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              backgroundColor: innerBoxIsScrolled ? Banking_Primary : context.cardColor,
              actionsIconTheme: const IconThemeData(opacity: 0.0),
              title: Container(
                padding: const EdgeInsets.fromLTRB(16, 42, 16, 32),
                margin: const EdgeInsets.only(bottom: 8, top: 8),
                child: Row(
                  children: [
                    const CircleAvatar(backgroundImage: AssetImage(Banking_ic_user1), radius: 24),
                    10.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: primaryTextStyle(color: Banking_TextColorWhite),
                        ),
                        Text(
                          "($groupName)",
                          style: primaryTextStyle(color: Banking_TextColorWhite),
                        ),
                      ],
                    ).expand(),
                    const Icon(Icons.notifications, size: 30, color: Banking_whitePureColor)
                  ],
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topLeft,
                          colors: <Color>[Banking_blueColor, Banking_palColor],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 80, 16, 8),
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: defaultBoxShadow(),
                        backgroundColor: context.cardColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 130,
                            child: PageView(
                              children: [
                                ProjectCard(name: "Project 1", projectName: "Global Institute", responsible: "Miftah"),
                                ProjectCard(name: "Project 2", projectName: "Sekolah Tinggi Ilmu Pelayaran", responsible: "Selan Lingam"),
                                ProjectCard(name: "Project 3", projectName: "Kelas IDEA", responsible: "Setiadi"),
                              ],
                              onPageChanged: (value) {
                                setState(() => currentIndexPage = value);
                              },
                            ),
                          ),
                          8.height,
                          Align(
                            alignment: Alignment.center,
                            child: DotsIndicator(
                              dotsCount: 3,
                              position: currentIndexPage.toDouble(),
                              decorator: const DotsDecorator(
                                size: Size.square(8.0),
                                activeSize: Size.square(8.0),
                                color: Banking_view_color,
                                activeColor: Banking_TextColorPrimary,
                              ),
                            ),
                          ),
                          10.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                decoration: boxDecorationWithRoundedCorners(
                                  backgroundColor: Banking_Primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_circle, color: Banking_TextColorWhite, size: 24),
                                    10.width,
                                    Text('New Project', style: boldTextStyle(color: Banking_TextColorWhite)),
                                  ],
                                ),
                              ).expand(),
                              10.width,
                              Container(
                                padding: const EdgeInsets.only(top: 8, bottom: 8),
                                decoration: boxDecorationWithRoundedCorners(
                                  backgroundColor: Banking_Primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_circle, color: Banking_TextColorWhite, size: 24),
                                    10.width,
                                    Text('Subscribe', style: boldTextStyle(color: Banking_TextColorWhite)),
                                  ],
                                ),
                              ).expand(),
                            ],
                          ).paddingAll(16)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Client", style: primaryTextStyle()),
                    4.height,
                    Text("Project & Subscribe", style: secondaryTextStyle()),
                  ],
                ),
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: clientGajiList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                      decoration: boxDecorationWithShadow(
                        backgroundColor: context.cardColor,
                        boxShadow: defaultBoxShadow(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(clientGajiList[index].img!, height: 35, width: 35, color: clientGajiList[index].color),
                          15.height,
                          Text(
                            clientGajiList[index].title!,
                            style: primaryTextStyle(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ).onTap(
                          () {
                        BankingPaymentDetails(headerText: clientGajiList[index].title).launch(context);
                      },
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                ),
                16.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Master", style: primaryTextStyle()),
                    4.height,
                    Text("Pengaturan data gaji", style: secondaryTextStyle()),
                  ],
                ),
                Divider(),
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: masterGajiList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                      decoration: boxDecorationWithShadow(
                        backgroundColor: context.cardColor,
                        boxShadow: defaultBoxShadow(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(masterGajiList[index].img!, height: 35, width: 35, color: masterGajiList[index].color),
                          15.height,
                          Text(
                            masterGajiList[index].title!,
                            style: primaryTextStyle(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ).onTap(
                          () {
                        BankingPaymentDetails(headerText: masterGajiList[index].title).launch(context);
                      },
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                ),
                16.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Gaji", style: primaryTextStyle()),
                    4.height,
                    Text("Laporan gaji pegawai", style: secondaryTextStyle()),
                  ],
                ),
                Divider(),
                GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: laporanGajiList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                      decoration: boxDecorationWithShadow(
                        backgroundColor: context.cardColor,
                        boxShadow: defaultBoxShadow(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(laporanGajiList[index].img!, height: 35, width: 35, color: laporanGajiList[index].color),
                          15.height,
                          Text(
                            laporanGajiList[index].title!,
                            style: primaryTextStyle(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ).onTap(
                          () {
                        BankingPaymentDetails(headerText: laporanGajiList[index].title).launch(context);
                      },
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
