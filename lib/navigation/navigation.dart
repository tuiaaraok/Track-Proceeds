import 'package:flutter/material.dart';
import 'package:zp_calendar/ui/create_calendar_event.dart';
import 'package:zp_calendar/ui/menu_page.dart';
import 'package:zp_calendar/ui/report_info.dart';

const String createCalendarEvent = "/create-calendar-event";
const String menuPage = "/menu-page";
const String reportInfo = "/report-info";

class NavigationApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case createCalendarEvent:
        var args = settings.arguments as DateTime;
        return MaterialPageRoute(
          builder: (_) {
            return CreateCalendarEvent(
              currentDate: args,
            );
          },
          settings: settings,
        );
      case menuPage:
        return MaterialPageRoute(
          builder: (_) {
            return const MenuPage();
          },
          settings: settings,
        );
      case reportInfo:
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
            return const MenuPage();
          },
          settings: settings,
        );
    }
  }
}
