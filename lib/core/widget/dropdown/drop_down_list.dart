import '../../../global_imports.dart';

class AppDropDownList<T> extends StatelessWidget {
  final String labelText;
  final T? value;
  final void Function(T?) onChangeTap;
  final List<DropdownMenuItem<T>> items;
  final String? Function(T?)? validator;

  const AppDropDownList(
      {super.key,
      required this.labelText,
      required this.value,
      required this.onChangeTap,
      required this.items,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 0.5))),
      value: value,
      items: items,
      onChanged: onChangeTap,
      validator: validator,
    );
  }
}
