import 'package:employee_management/app_colors.dart';
import 'package:employee_management/features/employee_add/widgets/cal_bottom_buttons.dart';
import 'package:employee_management/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app_strings.dart';
import '../../../custom_widgets/cbutton.dart';

class CalStartDate extends StatelessWidget {
  CalStartDate(
      {super.key, required this.onSavePressed, required this.onCancelPressed});
  DateTime _selectedDay = DateTime.now(), _focusedDay = DateTime.now();
  bool isTodaySelected = true;
  bool isNextMondaySelected = false;
  bool isNextTuesdaySelected = false;
  bool isNextWeekSelected = false;
  final DateFormat formatter = DateFormat('dd MMM, yyyy');
  Function(String) onSavePressed;
  Function() onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        width: kIsWeb
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, left: 16, right: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CButton(
                      buttonLabel: AppStrings.today,
                      textColor:
                          isTodaySelected ? Colors.white : AppColors.blueColor,
                      backgroundColor: isTodaySelected
                          ? AppColors.blueColor
                          : Colors.blue.shade50,
                      onPressed: () {
                        setState(() {
                          isTodaySelected = true;
                          isNextMondaySelected = false;
                          isNextTuesdaySelected = false;
                          isNextWeekSelected = false;
                          _selectedDay = DateTime.now();
                          _focusedDay = DateTime.now();
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CButton(
                      buttonLabel: AppStrings.nextMonday,
                      textColor: isNextMondaySelected
                          ? Colors.white
                          : AppColors.blueColor,
                      backgroundColor: isNextMondaySelected
                          ? AppColors.blueColor
                          : Colors.blue.shade50,
                      onPressed: () {
                        setState(() {
                          isTodaySelected = false;
                          isNextMondaySelected = true;
                          isNextTuesdaySelected = false;
                          isNextWeekSelected = false;
                          var today = DateTime.now();
                          int daysToMonday = DateTime.monday - today.weekday;
                          if (daysToMonday <= 0) {
                            daysToMonday += 7;
                          }
                          DateTime nextMonday =
                              today.add(Duration(days: daysToMonday));
                          _selectedDay = nextMonday;
                          _focusedDay = nextMonday;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CButton(
                      buttonLabel: AppStrings.nextTuesday,
                      textColor: isNextTuesdaySelected
                          ? Colors.white
                          : AppColors.blueColor,
                      backgroundColor: isNextTuesdaySelected
                          ? AppColors.blueColor
                          : Colors.blue.shade50,
                      onPressed: () {
                        setState(() {
                          isTodaySelected = false;
                          isNextMondaySelected = false;
                          isNextTuesdaySelected = true;
                          isNextWeekSelected = false;
                          var today = DateTime.now();
                          int daysToTuesday = DateTime.tuesday - today.weekday;
                          if (daysToTuesday <= 0) {
                            daysToTuesday += 7;
                          }
                          DateTime nextMonday =
                              today.add(Duration(days: daysToTuesday));
                          _selectedDay = nextMonday;
                          _focusedDay = nextMonday;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CButton(
                      buttonLabel: AppStrings.afterWeek,
                      textColor: isNextWeekSelected
                          ? Colors.white
                          : AppColors.blueColor,
                      backgroundColor: isNextWeekSelected
                          ? AppColors.blueColor
                          : Colors.blue.shade50,
                      onPressed: () {
                        setState(() {
                          isTodaySelected = false;
                          isNextMondaySelected = false;
                          isNextTuesdaySelected = false;
                          isNextWeekSelected = true;
                          var today = DateTime.now();
                          DateTime nextWeek =
                              today.add(const Duration(days: 7));
                          _selectedDay = nextWeek;
                          _focusedDay = nextWeek;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TableCalendar(
                calendarFormat: CalendarFormat.month,
                headerStyle: const HeaderStyle(
                    leftChevronIcon: Icon(Icons.arrow_left_outlined),
                    rightChevronIcon: Icon(Icons.arrow_right_outlined),
                    titleCentered: true,
                    formatButtonVisible: false),
                firstDay: DateTime.utc(1900, 01, 01),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _selectedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  todayTextStyle: const TextStyle(color: AppColors.blueColor),
                  todayDecoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.blueColor)),
                  selectedDecoration: BoxDecoration(
                      color: AppColors.blueColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.blueColor)),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const Divider(),
            CalBottomButtons(
              date: formatter.format(_focusedDay),
              onSavePressed: () {
                onSavePressed(formatter.format(_focusedDay));
              },
              onCancelPressed: onCancelPressed,
            ),
          ],
        ),
      );
    });
  }
}
