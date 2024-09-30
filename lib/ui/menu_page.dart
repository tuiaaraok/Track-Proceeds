import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:zp_calendar/data/boxes.dart';
import 'package:zp_calendar/data/calendar_model.dart';
import 'package:zp_calendar/ui/info_page.dart';
import 'package:zp_calendar/ui/home_page.dart';
import 'package:zp_calendar/navigation/navigation.dart';
import 'package:zp_calendar/ui/reports_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Widget> menu_body = [];

  int currentIndex = 0;
  bool isAppbar = true;

  @override
  void initState() {
    super.initState();
    menu_body = [
      HomePage(
        isappbar: () {
          setState(() {
            isAppbar = false;
          });
        },
        opnebar: () {
          setState(() {
            isAppbar = true;
          });
        },
      ),
      ReportsPage(),
      InfoPage(),
      // Добавьте нужные виджеты
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFDD6565),
        bottomNavigationBar: isAppbar
            ? Container(
                height: 5.5.h + 15.h + 35.h + 14.sp + 6.h,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        currentIndex = 0;
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Icon(
                            IconsaxPlusLinear.menu_board,
                            color: currentIndex == 0
                                ? Colors.black
                                : Color(0xFF4477B1).withOpacity(0.5),
                            size: 32.h,
                          ),
                          Text(
                            "Calendar",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: currentIndex == 0 ? 60.w : 0,
                            height: 5.5.h,
                            decoration: BoxDecoration(color: Colors.deepOrange),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        currentIndex = 1;
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Icon(
                            IconsaxPlusLinear.document_text,
                            color: currentIndex == 1
                                ? Colors.black
                                : Color(0xFF4477B1).withOpacity(0.5),
                            size: 32.h,
                          ),
                          Text(
                            "Reports",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: currentIndex == 1 ? 60.w : 0,
                            height: 5.5,
                            decoration: BoxDecoration(color: Colors.deepOrange),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        currentIndex = 2;
                        setState(() {});
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Icon(
                            IconsaxPlusLinear.setting_2,
                            color: currentIndex == 2
                                ? Colors.black
                                : Color(0xFF4477B1).withOpacity(0.5),
                            size: 32.h,
                          ),
                          Text(
                            "Reports",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: currentIndex == 2 ? 60.w : 0,
                            height: 5.5,
                            decoration: BoxDecoration(color: Colors.deepOrange),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox.shrink(),
        body: menu_body[currentIndex]);
  }
}
