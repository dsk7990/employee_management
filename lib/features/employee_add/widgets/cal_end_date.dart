import 'package:employee_management/app_colors.dart';
import 'package:employee_management/features/employee_add/widgets/cal_bottom_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../app_strings.dart';
import '../../../custom_widgets/cbutton.dart';

class CalEndDate extends StatelessWidget {
  CalEndDate(
      {super.key, required this.onSavePressed, required this.onCancelPressed});
  DateTime _selectedDay = DateTime.now(), _focusedDay = DateTime.now();
  bool isNoDateSelected = true;
  bool isTodaySelected = false;
  final DateFormat formatter = DateFormat('dd MMM, yyyy');
  Function(String) onSavePressed;
  Function() onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        width: kIsWeb ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CButton(
                      buttonLabel: AppStrings.hintNoDate,
                      textColor:
                          isNoDateSelected ? Colors.white : AppColors.blueColor,
                      backgroundColor: isNoDateSelected
                          ? AppColors.blueColor
                          : Colors.blue.shade50,
                      onPressed: () {
                        setState(() {
                          isNoDateSelected = true;
                          isTodaySelected = false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
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
                          isNoDateSelected = false;
                          isTodaySelected = true;
                          _selectedDay = DateTime.now();
                          _focusedDay = DateTime.now();
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
                firstDay: DateTime.now(),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _selectedDay,
                selectedDayPredicate: isNoDateSelected
                    ? null
                    : (day) {
                        return isSameDay(_selectedDay, day);
                      },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: isNoDateSelected ? false : true,
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
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const Divider(),
            CalBottomButtons(
              date: isNoDateSelected
                  ? AppStrings.hintNoDate
                  : formatter.format(_focusedDay),
              onSavePressed: () {
                if (isNoDateSelected) {
                  onSavePressed('');
                } else {
                  onSavePressed(formatter.format(_focusedDay));
                }
              },
              onCancelPressed: onCancelPressed,
            ),
          ],
        ),
      );
    });
  }
}
