import 'package:employee_management/features/home_page/ui/homepage_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../employee_add/bloc/employee_bloc.dart';

class HomepageFeatureWidget extends StatelessWidget {
  const HomepageFeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmployeeBloc>(
        create: (context) => EmployeeBloc(), child: const HomepagePresenter());
  }
}
