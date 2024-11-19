import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:zp_calendar/data/boxes.dart';
import 'package:zp_calendar/data/calendar_model.dart';

class ReportInfo extends StatefulWidget {
  const ReportInfo({super.key, required this.selectBtn});
  final List<bool> selectBtn;
  @override
  State<ReportInfo> createState() => _ReportInfoState();
}

class _ReportInfoState extends State<ReportInfo> {
  String? selectedMonth;
  double resH = 0.0;
  double tip = 0.0;
  double paycheck = 0.0;
  String currentMonths = "";
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
                          currentMonths = months[index];
                          if (contactsBox.getAt(0)!.day.containsKey(
                              "${months[index]} ${DateTime.now().year}")) {
                            for (var action in contactsBox.getAt(0)!.day[
                                "${months[index]} ${DateTime.now().year}"]!) {
                              if (action.start != null) {
                                String startTimeString =
                                    formatTime(action.start.toString());
                                String finishTimeString =
                                    formatTime(action.finish.toString());

                                DateTime startTime = DateTime.parse(
                                    "2023-01-01 $startTimeString");
                                DateTime finishTime = DateTime.parse(
                                    "2023-01-01 $finishTimeString");

                                // Вычисление разницы
                                Duration difference =
                                    finishTime.difference(startTime);
                                tip += double.parse(action.tip.toString());
                                paycheck += double.parse(action.tip.toString());

                                // Преобразование разницы в часы с плавающей запятой
                                resH += (difference.inHours +
                                    difference.inMinutes.remainder(60) / 60);
                              }
                            }
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 80.h,
                        height: 80.h,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(10),
                            border: currentMonths == months[index]
                                ? Border.all(
                                    color: const Color(0xFFE72525)
                                        .withOpacity(0.7))
                                : null),
                        child: Center(
                          child: Text(
                            months[index],
                            style: TextStyle(
                                color: const Color(0xFFE72525),
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
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE72525).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        widget.selectBtn[0]
                            ? SizedBox(
                                width: 320.w,
                                child: Text(
                                  "Paycheck for *$currentMonths = $paycheck\$",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : const SizedBox.shrink(),
                        widget.selectBtn[1]
                            ? SizedBox(
                                width: 300.w,
                                child: Text(
                                  "Tips for *$currentMonths = $tip\$",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : const SizedBox.shrink(),
                        widget.selectBtn[2]
                            ? SizedBox(
                                width: 300.w,
                                child: Text(
                                  "Salary for *$currentMonths = ${tip + paycheck}\$",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )
                            : const SizedBox.shrink(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Divider(
                            color: Colors.black,
                            height: 2.h,
                          ),
                        ),
                        SizedBox(
                          width: 330.w,
                          child: Text(
                            "For *$currentMonths you had ${resH.toInt().toString()} hours of work time.",
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

  String formatTime(String time) {
    final parts = time.split(':');
    if (parts.length == 2) {
      return parts.map((part) => part.padLeft(2, '0')).join(':');
    }
    return time; // если не удалось распарсить, возвращаем без изменений
  }
}
