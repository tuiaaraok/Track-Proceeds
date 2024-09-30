import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:zp_calendar/navigation/navigation.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: isActive ? 6.0.h : 6.h,
      width: isActive ? 35.w : 20.h,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        FirstWidgetForOnBoardingInfo(
                          asset_image: 'assets/on_boarding_first.png',
                          title: 'Keeping track of your work\nschedule is ',
                          title_s: 'Easy!',
                          subtitle:
                              'Open your calendar, and keep\ntrack of your work days, as well as\ncalculate your time',
                        ),
                        WidgetForOnBoardingInfo(
                          asset_image: 'assets/on_boarding_second.png',
                          title:
                              'Keep track of your income,\nlook at all the reports.',
                          subtitle:
                              "Calculate your lifetime earnings,\nadd events that are important to\nyou",
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_currentPage == 1) {
                          Navigator.pushNamed(context, menu_page);
                        }
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: GestureDetector(
                        onTap: () async {
                          final Uri _url = Uri.parse('https://flutter.dev');
                          if (!await launchUrl(_url)) {
                            throw Exception('Could not launch $_url');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Terms of use",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.sp),
                              child: Container(
                                width: 1,
                                height: 12.sp,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
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
    );
  }
}

class WidgetForOnBoardingInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset_image;

  WidgetForOnBoardingInfo(
      {required this.title, required this.subtitle, required this.asset_image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              asset_image,
            ),
            fit: BoxFit.fitWidth,
            height: 360.h,
            width: 360.w,
          ),
          SizedBox(height: 30.h),
          Container(
            width: 340.w,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: kTitleStyle,
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            width: 340.w,
            child: Text(
              subtitle,
              textAlign: TextAlign.start,
              style: kSubtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}

final kTitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 24.sp,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white.withOpacity(0.5),
  fontSize: 18.sp,
);

class FirstWidgetForOnBoardingInfo extends StatelessWidget {
  final String title;
  final String title_s;
  final String subtitle;
  final String asset_image;

  FirstWidgetForOnBoardingInfo(
      {required this.title,
      required this.title_s,
      required this.subtitle,
      required this.asset_image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 39.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              asset_image,
            ),
            fit: BoxFit.fitWidth,
            height: 360.h,
            width: 360.w,
          ),
          SizedBox(height: 30.h),
          Container(
            width: 340.w,
            child: RichText(
                text: TextSpan(
              text: title,
              style: TextStyle(fontSize: 24.sp, color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: title_s,
                  style: TextStyle(fontSize: 24.sp, color: Colors.white),
                ),
              ],
            )),
          ),
          SizedBox(height: 15.h),
          Container(
            width: 340.w,
            child: Text(
              subtitle,
              textAlign: TextAlign.start,
              style: kSubtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}
