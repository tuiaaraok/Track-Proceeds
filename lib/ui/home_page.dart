import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:zp_calendar/data/boxes.dart';
import 'package:zp_calendar/data/calendar_model.dart';
import 'package:zp_calendar/navigation/navigation.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.isappbar, required this.opnebar});
  VoidCallback isappbar;
  VoidCallback opnebar;
  @override
  State<HomePage> createState() => _MyHomePageState();
}

DateTime? selectedDate;

class _MyHomePageState extends State<HomePage> {
  DateTime _currentMonth = DateTime.now();

  DateTime _nowDate = DateTime.now();
  bool is_open_node = false;

  List<DayIs> dayList = [];
  List<DayIs> noteList = [];
  List<DayIs> checkList = [];

  PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);
  bool isNote(DateTime date) {
    bool hasReminder = noteList.any((reminder) =>
        reminder.data.isSameDate(date) &&
        (reminder.start == null || reminder.start!.isEmpty));
    if (hasReminder == false) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.isappbar(); // Теперь это будет вызвано после строения
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.opnebar(); // Теперь это будет вызвано после строения
      });
    }
    return hasReminder;
  }

  addCheckLust(DateTime now) {
    dayList.forEach((action) {
      if (action.data == now) {
        checkList.add(action);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<CalendarModel>(HiveBoxes.calendar).listenable(),
        builder: (context, Box<CalendarModel> box, _) {
          return Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  "Calendar",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                ),
              ),
              leadingWidth: double.infinity,
            ),
            backgroundColor: Color(0xFFDD6565),
            body: Stack(
              children: [
                SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: 315.h,
                          width: 330.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat('MMMM yyyy')
                                          .format(_currentMonth),
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (_currentMonth.month == 1) {
                                                // Если января — переключаемся на декабрь предыдущего года
                                                setState(() {
                                                  _currentMonth = DateTime(
                                                      _currentMonth.year - 1,
                                                      12);
                                                  _pageController.jumpToPage(
                                                      11); // Сброс к странице 11 (декабрь предыдущего года)
                                                });
                                              } else {
                                                setState(() {
                                                  _currentMonth = DateTime(
                                                    _currentMonth.year,
                                                    _currentMonth.month - 1,
                                                  );
                                                  _pageController.previousPage(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                });
                                              }
                                            },
                                            child: Container(
                                              width: 18.sp,
                                              child: Icon(Icons.arrow_back_ios,
                                                  size: 18.sp),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            if (_currentMonth.month == 12) {
                                              // Если декабря — переключаемся на январь следующего года
                                              setState(() {
                                                _currentMonth = DateTime(
                                                    _currentMonth.year + 1, 1);
                                                _pageController.jumpToPage(
                                                    0); // Сброс к странице 0 (январь следующего года)
                                              });
                                            } else {
                                              setState(() {
                                                _currentMonth = DateTime(
                                                  _currentMonth.year,
                                                  _currentMonth.month + 1,
                                                );
                                                _pageController.nextPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: 18.sp,
                                            child: Icon(Icons.arrow_forward_ios,
                                                size: 18.sp),
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 230.h,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: PageView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _pageController,
                                    onPageChanged: (index) {
                                      setState(() {
                                        _currentMonth = DateTime(
                                          _currentMonth.year,
                                          index + 1,
                                        );
                                      });
                                    },
                                    itemCount: 12 * 3,
                                    itemBuilder: (context, pageIndex) {
                                      return buildCalendar(
                                          DateTime(_currentMonth.year,
                                              pageIndex + 1, 1),
                                          box);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        selectedDate == null
                            ? Column(children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  width: 360.w,
                                  child: Text(
                                    "Notes",
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200.h,
                                        width: 200.w,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/calendar.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Select the date of\nyour notes",
                                        style: TextStyle(fontSize: 24.sp),
                                      )
                                    ],
                                  ),
                                )
                              ])
                            : _buildContIndi(
                                noteList, selectedDate!, is_open_node, () {
                                setState(() {
                                  is_open_node = !is_open_node;
                                });
                              })
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: selectedDate != null
                          ? isNote(selectedDate!)
                              ? 0.h
                              : 400.h
                          : 0.h,
                      width: double.infinity,
                      color:
                          selectedDate != null && isNote(selectedDate!) == false
                              ? null
                              : Colors.white,
                      decoration:
                          selectedDate != null && isNote(selectedDate!) == false
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.r),
                                    topRight: Radius.circular(20.r),
                                  ))
                              : null,
                      child: selectedDate != null &&
                              isNote(selectedDate!) == false
                          ? Stack(
                              children: [
                                Positioned(
                                  left: 10.w,
                                  top: 10.h,
                                  child: Text(
                                    DateFormat('d MMMM').format(selectedDate!),
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                    right: 10.w,
                                    top: 20.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                                context, create_calendar_event,
                                                arguments: selectedDate)
                                            .then((onValue) {
                                          print("Hi");
                                          if (onValue != null) {
                                            if ((onValue as DayIs).start ==
                                                null) {
                                              noteList.add(onValue);
                                            } else {
                                              checkList.add(onValue as DayIs);
                                            }
                                            setState(() {});
                                          }

                                          print("Hi");
                                        });
                                      },
                                      child: Container(
                                        height: 90.h,
                                        width: 90.h,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.r))),
                                        child: Icon(
                                          Icons.add,
                                          size: 64.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  left: checkList.isEmpty ? 100.w : 50.w,
                                  top: checkList.isEmpty ? 110.h : 150.h,
                                  child: checkList.isEmpty
                                      ? Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 200.h,
                                                width: 200.w,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/calendar.png"),
                                                        fit: BoxFit.fitWidth)),
                                              ),
                                              Text(
                                                "There are no events today",
                                                style:
                                                    TextStyle(fontSize: 18.sp),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(
                                          width: 300.w,
                                          height: 300.h,
                                          child: ListView.builder(
                                              itemCount: checkList.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.h),
                                                  child: Container(
                                                    width: 300.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12.r)),
                                                        color:
                                                            Color(0xFFD9D9D9)),
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          ListTile(
                                                            title: Text(
                                                              "New Shift",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            subtitle: Text(
                                                              "${checkList[index].start} - ${checkList[index].finish}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      18.sp,
                                                                  color: Color(
                                                                      0xFFE72525)),
                                                            ),
                                                            trailing: Text(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              "${checkList[index].payment}\$/h",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      24.sp,
                                                                  color: Color(
                                                                      0xFFE72525)),
                                                            ),
                                                          ),
                                                          (checkList[index]
                                                                      .note !=
                                                                  "")
                                                              ? Column(
                                                                  children: [
                                                                    Divider(
                                                                      color: Colors
                                                                          .black,
                                                                      endIndent:
                                                                          20.w,
                                                                      indent:
                                                                          20.w,
                                                                    ),
                                                                    Text(
                                                                      checkList[
                                                                              index]
                                                                          .note,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18.sp),
                                                                    ),
                                                                  ],
                                                                )
                                                              : SizedBox
                                                                  .shrink()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        selectedDate = null;
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          widget
                                              .opnebar(); // Теперь это будет вызвано после строения
                                        });
                                        setState(() {});
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.keyboard_arrow_up,
                                              color: Colors.black, size: 30.h),
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
                                )
                              ],
                            )
                          : SizedBox()),
                ),
              ],
            ),
          );
        });
  }

  Widget buildCalendar(DateTime month, Box<CalendarModel> box) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
    int weekdayOfFirstDay = firstDayOfMonth.weekday;

    List<Widget> calendarCells = [];

    List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    for (String day in weekDays) {
      calendarCells.add(
        Container(
          decoration: const BoxDecoration(border: Border()),
          alignment: Alignment.center,
          child: Text(
            day,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: day == "Sun" || day == "Sat"
                    ? Colors.red
                    : DateFormat('E').format(_nowDate).toString() == day
                        ? DateFormat('M y').format(month).toString() ==
                                DateFormat('M y').format(_nowDate).toString()
                            ? Colors.green
                            : Colors.black
                        : Colors.black),
          ),
        ),
      );
    }

    // Регулировка для пустых ячеек (начиная с воскресенья)
    for (int i = 0; i < (weekdayOfFirstDay % 7); i++) {
      calendarCells.add(Container(
        decoration: const BoxDecoration(border: Border()),
        alignment: Alignment.center,
        child: Text(""),
      ));
    }
    bool istr = false;

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(month.year, month.month, i);
      bool isToday = date.isSameDate(DateTime.now());

      // Безопасное добавление элементов в список
      String dateKey = DateFormat('MMM yyyy').format(date);

      // Логика для выбора фона ячейки

      // Проверка наличия элементов в dayList перед доступом к last
      if (!istr) {
        if (box.isNotEmpty) {
          dayList.clear();
          noteList.clear();
          if (box.getAt(0)!.day.containsKey(dateKey)) {
            box.getAt(0)!.day[dateKey]!.forEach((action) {
              if (action?.start == null) {
                noteList.add(action);
              } else {
                dayList.add(action);
              }
            });
          }
        }
        istr = true;
      }

      calendarCells.add(
        GestureDetector(
          onTap: () {
            selectedDate = date;
            checkList = [];
            is_open_node = false;

            addCheckLust(selectedDate!);
            //                              if (box.isEmpty) {
            //   box.add(CalendarModal(day: {
            //     dateKey: [DayIs(data: date, note: "Desc")]
            //   }));
            //   print("box");
            // } else {
            //   box.keys.forEach((action) {
            //     print(action);
            //   });
            //   if (box.getAt(0)!.day.containsKey(dateKey)) {
            //     Map<String, List<DayIs>> day = box.getAt(0)!.day;
            //     day.forEach(
            //       (key, value) {
            //         if (key == dateKey) {
            //           value.add(DayIs(
            //               data: date,
            //               start: "00:00",
            //               finish: "12:00",
            //               note: "Desc"));
            //         }
            //       },
            //     );
            //     box.putAt(0, CalendarModal(day: day));
            //   } else {
            //     box.getAt(0)!.day.addAll({
            //       dateKey: [DayIs(data: date, note: "Desc")]
            //     });
            //   }
            // }

            setState(() {});
          },
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Container(
              decoration: BoxDecoration(
                color: _decorationColor(dayList, date),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Круг для напоминаний
                  (!isToday && noteList.isNotEmpty)
                      ? Positioned(
                          top: 3.h,
                          right: 3.w,
                          child: _buildReminderIndicator(noteList, date),
                        )
                      : SizedBox.shrink(),
                  // Текст даты
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isToday
                          ? Colors.green
                          : (date.weekday == 7 || date.weekday == 6
                              ? Colors.red
                              : Colors.black),
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      crossAxisCount: 7,
      childAspectRatio: (40.w / 32.h),
      children: calendarCells,
    );
  }
}

_buildReminderIndicator(List<DayIs> dayList, DateTime date) {
  bool hasReminder = dayList.any((reminder) =>
      reminder.data.isSameDate(date) &&
      (reminder.start == null || reminder.start!.isEmpty));

  return hasReminder
      ? Container(
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        )
      : SizedBox.shrink();
}

//  _isbuildCalend(List<DayIs> dayList, DateTime date) {
//    bool hasReminder;
//    String dateaa="";
//     hasReminder = dayList.any((reminder) {
//     if (reminder.data.isSameDate(date) &&
//         (reminder.start == null || reminder.start!.isEmpty)) {
//     dateaa="a";
//       return true;
//     }
//     if (reminder.data.isSameDate(date) &&
//         (reminder.start != null || reminder.start!.isNotEmpty)) {
//     dateaa="b";
//       return true;
//     }
//     return false;
//   });
//   return dateaa;
// }

_buildContIndi(
    List<DayIs> dayList, DateTime date, bool is_open_node, VoidCallback func) {
  DayIs? dayIs;
  bool hasReminder;
  hasReminder = dayList.any((reminder) {
    if (reminder.data.isSameDate(date) &&
        (reminder.start == null || reminder.start!.isEmpty)) {
      dayIs = reminder;
      return true;
    }
    return false;
  });

  return hasReminder
      ? Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 360.w,
              child: Text(
                "Notes",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: !is_open_node
                      ? BorderRadius.all(Radius.circular(12.r))
                      : BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r))),
              child: Stack(
                children: [
                  Container(
                    width: 330.w,
                    child: Column(
                      children: [
                        Container(
                          width: 330.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('MMMM yyyy').format(date),
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      DateFormat('EEEE').format(date),
                                      style: TextStyle(fontSize: 24.sp),
                                    ),
                                  ],
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  DateFormat('d').format(date),
                                  style: TextStyle(fontSize: 42.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -10.h,
                    right: 140.w,
                    child: IconButton(
                        onPressed: () {
                          func();
                        },
                        icon: Icon(
                          !is_open_node
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down_outlined,
                          size: 30.h,
                        )),
                  ),
                ],
              ),
            ),
            is_open_node
                ? Container(
                    width: 330.w,
                    height: 154.h,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: !is_open_node
                            ? BorderRadius.all(Radius.circular(12.r))
                            : BorderRadius.only(
                                bottomRight: Radius.circular(12.r),
                                bottomLeft: Radius.circular(12.r))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        dayIs!.note,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE72525)),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        )
      : SizedBox.shrink();
}

Color _decorationColor(List<DayIs> dayList, DateTime date) {
  bool hasReminder = dayList.any((reminder) =>
      reminder.data.isSameDate(date) &&
      (reminder.start != null || reminder.start!.isNotEmpty));

  return hasReminder ? Colors.deepOrange : Colors.white;
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
