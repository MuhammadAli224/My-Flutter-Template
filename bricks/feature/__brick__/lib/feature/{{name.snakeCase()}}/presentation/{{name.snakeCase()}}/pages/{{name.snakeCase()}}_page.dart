import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../core/dependencies/dependencies_injection.dart';
import '../../../../../generated/app_strings.g.dart';
import '../../../../../core/widget/app_widget/app_text.dart';
import '../cubit/{{name.snakeCase()}}_cubit.dart';
import '../widget/{{name.snakeCase()}}_widget.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<{{name.pascalCase()}}Cubit>()..fetchItems(),
    child: Scaffold(
      appBar: AppBar(title: AppText(context.tr(LocaleKeys.app_name))),
      body: const {{name.pascalCase()}}Widget(),
    ),
  );
}
