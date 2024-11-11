import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
        ),
        leadingWidth: double.infinity,
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://docs.google.com/document/d/1QQwCRLlJIJPaeS7FkLwPI-bwlUBHWPBHYBcHkxAKmK8/mobilebasic');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 21.h + 10.w,
                        ),
                        Expanded(
                          child: Text(
                            "Privacy policy",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.sp),
                            textAlign: TextAlign.center, // Центрируем текст
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 21.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    LaunchReview.launch(iOSAppId: "6738050939");
                  },
                  child: Container(
                    width: 310.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.r))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 21.h + 10.w,
                        ),
                        Expanded(
                          child: Text(
                            "Rate us",
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.sp),
                            textAlign: TextAlign.center, // Центрируем текст
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 21.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
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
