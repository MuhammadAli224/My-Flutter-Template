import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../generated/app_strings.g.dart';
import '../../../../../core/widget/app_widget/app_text.dart';
import '../cubit/{{name.snakeCase()}}_cubit.dart';

class {{name.pascalCase()}}Widget extends StatelessWidget {
  const {{name.pascalCase()}}Widget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}State>(
        builder: (context, state) => switch (state) {
          {{name.pascalCase()}}Initial() || {{name.pascalCase()}}Loading() =>
            const Center(child: CircularProgressIndicator()),
          {{name.pascalCase()}}Loaded(:final items) => items.isEmpty
              ? Center(child: AppText(context.tr(LocaleKeys.noDataFound)))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) => ListTile(
                    title: AppText(items[index].name),
                    subtitle: AppText(items[index].description ?? ''),
                  ),
                ),
          {{name.pascalCase()}}Error(:final message) =>
            Center(child: AppText(context.tr(message))),
        },
      );
}
