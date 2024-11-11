
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zp_calendar/navigation/navigation.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<bool> selectedItems = [false, false, false];

  void _toggleSelection(int index) {
    setState(() {
      selectedItems[index] = !selectedItems[index];
    });
  }

  void _showSelection() {
    final selectedTexts = [
      if (selectedItems[0]) 'Calculate a month\'s paycheck',
      if (selectedItems[1]) 'Calculate tips per month',
      if (selectedItems[2]) 'Salary + tips per month',
    ];
    if (selectedTexts.isNotEmpty) {
      Navigator.pushNamed(context, reportInfo, arguments: selectedItems);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            "Reports",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
        ),
        leadingWidth: double.infinity,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          height: 450.h,
          width: 340.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < selectedItems.length; i++)
                GestureDetector(
                  onTap: () => _toggleSelection(i),
                  child: Container(
                    width: 310.w,
                    margin: EdgeInsets.all(10.h),
                    padding: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      border: selectedItems[i]
                          ? Border.all(color: const Color(0xFFE72525))
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        [
                          'Calculate a month\'s paycheck',
                          'Calculate tips per month',
                          'Salary + tips per month',
                        ][i],
                        style: TextStyle(color: Colors.black, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: _showSelection,
                child: Container(
                  width: 310.w,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedItems.contains(true)
                        ? const Color.fromARGB(255, 241, 106, 106)
                        : const Color.fromARGB(255, 117, 51, 51),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
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
