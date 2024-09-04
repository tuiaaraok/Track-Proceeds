import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:zp_calendar/boxes.dart';
import 'package:zp_calendar/calendar_model.dart';

class ReportInfo extends StatefulWidget {
  ReportInfo({required this.selectBtn});
  final List<bool> selectBtn;
  @override
  State<ReportInfo> createState() => _ReportInfoState();
}

class _ReportInfoState extends State<ReportInfo> {
  String? selectedMonth;
  double resH = 0.0;
  double tip = 0.0;
  double paycheck = 0.0;
  String current_months = "";
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
            child: Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: Text(
            "Event",
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        )),
        leadingWidth: 80.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.black, size: 14.w),
                    Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Wrap(
                  spacing: 40.w,
                  runSpacing: 20.h,
                  children: List.generate(months.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        resH = 0.0;
                        tip = 0.0;
                        paycheck = 0.0;
                        Box<CalendarModel> contactsBox =
                            Hive.box<CalendarModel>(HiveBoxes.calendar);
                        if (contactsBox.getAt(0)?.day != null) {
                          current_months = months[index];
                          if (contactsBox
                              .getAt(0)!
                              .day
                              .containsKey(months[index] + " 2024")) {
                            contactsBox
                                .getAt(0)!
                                .day[months[index] + " 2024"]!
                                .forEach((action) {
                              if (action.start != null) {
                                DateTime startTime = DateTime.parse(
                                    "2023-01-01 ${action.start}");
                                DateTime finishTime = DateTime.parse(
                                    "2023-01-01 ${action.finish}");

                                // Вычисление разницы
                                Duration difference =
                                    finishTime.difference(startTime);
                                tip += double.parse(action.tip.toString());
                                paycheck += double.parse(action.tip.toString());

                                // Преобразование разницы в часы с плавающей запятой
                                resH += (difference.inHours +
                                    difference.inMinutes.remainder(60) / 60);

                                print(action.start);
                                print(action.finish);
                                print(resH);
                              }
                            });
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 80.h,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(10),
                            border: current_months == months[index]
                                ? Border.all(
                                    color: Color(0xFFE72525).withOpacity(0.7))
                                : null),
                        child: Center(
                          child: Text(
                            months[index],
                            style: TextStyle(
                                color: Color(0xFFE72525),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 70.h),
              if (resH != 0.0)
                Center(
                  child: Container(
                    width: 330.w,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFE72525).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        widget.selectBtn[0]
                            ? Container(
                                width: 320.w,
                                child: Text(
                                  "Paycheck for *${current_months} = ${paycheck}\$",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : SizedBox.shrink(),
                        widget.selectBtn[1]
                            ? Container(
                                width: 300.w,
                                child: Text(
                                  "Tips for *${current_months} = ${tip}\$",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : SizedBox.shrink(),
                        widget.selectBtn[2]
                            ? Container(
                                width: 300.w,
                                child: Text(
                                  "Salary for *${current_months} = ${tip + paycheck}\$",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : SizedBox.shrink(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Divider(
                            color: Colors.black,
                            height: 2.h,
                          ),
                        ),
                        Container(
                          width: 330.w,
                          child: Text(
                            "For *${current_months} you had ${resH.toInt().toString()} hours of work time.",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
