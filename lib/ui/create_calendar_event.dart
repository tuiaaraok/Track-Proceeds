import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:zp_calendar/data/boxes.dart';
import 'package:zp_calendar/data/calendar_model.dart';

class CreateCalendarEvent extends StatefulWidget {
  CreateCalendarEvent({super.key, required this.currentDate});
  DateTime currentDate;
  @override
  State<CreateCalendarEvent> createState() => _CreateCalendarEventState();
}

class _CreateCalendarEventState extends State<CreateCalendarEvent> {
  TextEditingController startController = TextEditingController();
  TextEditingController finishController = TextEditingController();
  TextEditingController paymentController = TextEditingController();
  TextEditingController tipController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  late Box<CalendarModel> box;
  bool isWorking = true;
  _updateFormCompletion() {
    bool isFilled = isWorking
        ? startController.text.isNotEmpty &&
            finishController.text.isNotEmpty &&
            paymentController.text.isNotEmpty &&
            tipController.text.isNotEmpty
        : notesController.text.isNotEmpty;

    setState(() {});
    return isFilled;
  }

  _clearText() {
    startController.text = '';
    finishController.text = '';
    paymentController.text = '';
    tipController.text = '';
    notesController.text = '';
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box<CalendarModel>(HiveBoxes.calendar);
    startController.addListener(_updateFormCompletion);
    finishController.addListener(_updateFormCompletion);
    paymentController.addListener(_updateFormCompletion);
    tipController.addListener(_updateFormCompletion);
    notesController.addListener(_updateFormCompletion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
            child: Text(
          "Event",
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        )),
        leadingWidth: 70.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.white, size: 14.w),
                    Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 200.h,
              width: 200.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/calendar.png"),
                      fit: BoxFit.fitWidth)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: isWorking ? 844.h : 516.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r))),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: 350.w,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                              ),
                              child: Container(
                                width: 350.w,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You're working today",
                                  style: TextStyle(fontSize: 18.sp),
                                ),
                              ),
                            ),
                            Container(
                              width: 350.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      isWorking = true;
                                      _clearText();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 160.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          color: isWorking
                                              ? Color.fromARGB(
                                                  255, 247, 106, 106)
                                              : Color(0xFF736D6D),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r))),
                                      child: Center(
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 23.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      isWorking = false;
                                      _clearText();
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 160.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                          color: !isWorking
                                              ? Color.fromARGB(
                                                  255, 247, 106, 106)
                                              : Color(0xFF736D6D),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r))),
                                      child: Center(
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            Center(
                              child: SizedBox(
                                width: 330.w,
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      !isWorking
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 38.h,
                                ),
                                Container(
                                  width: 310.w,
                                  child: Text(
                                    "Notes",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Container(
                                  height: 120.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: TextField(
                                      maxLines: 6,
                                      controller: notesController,
                                      decoration: InputDecoration(
                                          border: InputBorder
                                              .none, // Убираем обводку
                                          focusedBorder: InputBorder
                                              .none, // Убираем обводку при фокусе
                                          hintText: 'None',
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFE72525)
                                                  .withOpacity(0.5),
                                              fontSize: 18.sp)),
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.transparent,
                                      style: TextStyle(
                                          color: Color(0xFFE72525),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp),
                                      onChanged: (text) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_updateFormCompletion()) {
                                        String dateKey = DateFormat('MMM yyyy')
                                            .format(widget.currentDate);
                                        DayIs dayIs = DayIs(
                                            data: widget.currentDate,
                                            note: notesController.text);

                                        if (box.isEmpty) {
                                          box.add(CalendarModel(day: {
                                            dateKey: [dayIs]
                                          }));
                                          print("box");
                                        } else {
                                          box.keys.forEach((action) {
                                            print(action);
                                          });
                                          if (box
                                              .getAt(0)!
                                              .day
                                              .containsKey(dateKey)) {
                                            Map<String, List<DayIs>> day =
                                                box.getAt(0)!.day;
                                            day.forEach(
                                              (key, value) {
                                                if (key == dateKey) {
                                                  value.add(dayIs!);
                                                }
                                              },
                                            );
                                            box.putAt(
                                                0, CalendarModel(day: day));
                                          } else {
                                            Map<String, List<DayIs>> new_date =
                                                box.getAt(0)!.day;
                                            new_date[dateKey] = [dayIs];
                                            box.putAt(0,
                                                CalendarModel(day: new_date));
                                          }
                                        }
                                        Navigator.pop(context, dayIs);
                                      }
                                    },
                                    child: Container(
                                      width: 320.w,
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          color: _updateFormCompletion()
                                              ? Color.fromARGB(
                                                  255, 241, 106, 106)
                                              : Color.fromARGB(
                                                  255, 117, 51, 51),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r))),
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width: 310.w,
                                  child: Text(
                                    "Start",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 55.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Center(
                                      child: TextField(
                                        controller: startController,
                                        decoration: InputDecoration(
                                            border: InputBorder
                                                .none, // Убираем обводку
                                            focusedBorder: InputBorder
                                                .none, // Убираем обводку при фокусе
                                            hintText: '00:00',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE72525)
                                                    .withOpacity(0.5),
                                                fontSize: 18.sp)),
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.transparent,
                                        style: TextStyle(
                                            color: Color(0xFFE72525),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp),
                                        onChanged: (text) {},
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 28.h,
                                ),
                                Container(
                                  width: 310.w,
                                  child: Text(
                                    "Finish",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 55.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Center(
                                      child: TextField(
                                        controller: finishController,
                                        decoration: InputDecoration(
                                            border: InputBorder
                                                .none, // Убираем обводку
                                            focusedBorder: InputBorder
                                                .none, // Убираем обводку при фокусе
                                            hintText: '00:00',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE72525)
                                                    .withOpacity(0.5),
                                                fontSize: 18.sp)),
                                        keyboardType: TextInputType.datetime,
                                        cursorColor: Colors.transparent,
                                        style: TextStyle(
                                            color: Color(0xFFE72525),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp),
                                        onChanged: (text) {},
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 28.h,
                                ),
                                Container(
                                  width: 310.w,
                                  child: Text(
                                    "Payment (\$)",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 55.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Center(
                                      child: TextField(
                                        controller: paymentController,
                                        decoration: InputDecoration(
                                            border: InputBorder
                                                .none, // Убираем обводку
                                            focusedBorder: InputBorder
                                                .none, // Убираем обводку при фокусе
                                            hintText: '0 \$',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE72525)
                                                    .withOpacity(0.5),
                                                fontSize: 18.sp)),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: true, decimal: true),
                                        textInputAction: TextInputAction.done,
                                        cursorColor: Colors.transparent,
                                        style: TextStyle(
                                            color: Color(0xFFE72525),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp),
                                        onChanged: (text) {},
                                        onSubmitted: (_) {
                                          FocusScope.of(context)
                                              .unfocus(); // Закрываем клавиатуру
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 28.h,
                                ),
                                Container(
                                  width: 310.w,
                                  child: Text(
                                    "Tip (\$)",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 55.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Center(
                                      child: TextField(
                                        controller: tipController,
                                        decoration: InputDecoration(
                                            border: InputBorder
                                                .none, // Убираем обводку
                                            focusedBorder: InputBorder
                                                .none, // Убираем обводку при фокусе
                                            hintText: '0 \$',
                                            hintStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFE72525)
                                                    .withOpacity(0.5),
                                                fontSize: 18.sp)),
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                signed: true, decimal: true),
                                        cursorColor: Colors.transparent,
                                        style: TextStyle(
                                            color: Color(0xFFE72525),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp),
                                        onChanged: (text) {},
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 28.h,
                                ),
                                Container(
                                  width: 310.w,
                                  child: Text(
                                    "Notes",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Container(
                                  height: 120.h,
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.r)),
                                    color: Color(0xFFD9D9D9),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: TextField(
                                      maxLines: 6,
                                      controller: notesController,
                                      decoration: InputDecoration(
                                          border: InputBorder
                                              .none, // Убираем обводку
                                          focusedBorder: InputBorder
                                              .none, // Убираем обводку при фокусе
                                          hintText: 'None',
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFE72525)
                                                  .withOpacity(0.5),
                                              fontSize: 18.sp)),
                                      keyboardType: TextInputType.text,
                                      cursorColor: Colors.transparent,
                                      style: TextStyle(
                                          color: Color(0xFFE72525),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp),
                                      onChanged: (text) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30.h),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_updateFormCompletion()) {
                                        String dateKey = DateFormat('MMM yyyy')
                                            .format(widget.currentDate);
                                        DayIs dayIs = DayIs(
                                            data: widget.currentDate,
                                            start: startController.text,
                                            finish: finishController.text,
                                            payment: paymentController.text,
                                            tip: tipController.text,
                                            note: notesController.text);
                                        if (box.isEmpty) {
                                          box.add(CalendarModel(day: {
                                            dateKey: [dayIs]
                                          }));
                                          print("box");
                                        } else {
                                          if (box
                                              .getAt(0)!
                                              .day
                                              .containsKey(dateKey)) {
                                            Map<String, List<DayIs>> day =
                                                box.getAt(0)!.day;
                                            day.forEach(
                                              (key, value) {
                                                if (key == dateKey) {
                                                  value.add(dayIs!);
                                                }
                                              },
                                            );
                                            box.putAt(
                                                0, CalendarModel(day: day));
                                          } else {
                                            Map<String, List<DayIs>> new_date =
                                                box.getAt(0)!.day;
                                            new_date[dateKey] = [dayIs];
                                            box.putAt(0,
                                                CalendarModel(day: new_date));
                                          }
                                        }
                                        Navigator.pop(context, dayIs);
                                      }
                                    },
                                    child: Container(
                                      width: 320.w,
                                      height: 60.h,
                                      decoration: BoxDecoration(
                                          color: _updateFormCompletion()
                                              ? Color.fromARGB(
                                                  255, 241, 106, 106)
                                              : Color.fromARGB(
                                                  255, 117, 51, 51),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.r))),
                                      child: Center(
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
