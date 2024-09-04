import 'package:flutter/material.dart';
import 'package:zp_calendar/ui/create_calendar_event.dart';
import 'package:zp_calendar/ui/menu_page.dart';
import 'package:zp_calendar/ui/report_info.dart';

const String create_calendar_event = "/create-calendar-event";
const String menu_page = "/menu-page";
const String report_info = "/report-info";

class NavigationApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case create_calendar_event:
        var args = settings.arguments as DateTime;
        return MaterialPageRoute(
          builder: (_) {
            return CreateCalendarEvent(
              currentDate: args,
            );
          },
          settings: settings,
        );
      case menu_page:
        return MaterialPageRoute(
          builder: (_) {
            return MenuPage();
          },
          settings: settings,
        );
      case report_info:
        var args = settings.arguments as List<bool>;
        return MaterialPageRoute(
          builder: (_) {
            return ReportInfo(
              selectBtn: args,
            );
          },
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return MenuPage();
          },
          settings: settings,
        );
    }
  }
}
