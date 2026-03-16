import '../../../global_imports.dart';
import '../../utils/font_size.dart';

class AppMultiSelectDropDown<T> extends StatefulWidget {
  final String? title;
  final String labelText;
  final List<T> selectedValues;
  final void Function(List<T>) onChanged;
  final List<DropdownMenuItem<T>> items;
  final String? Function(List<T>?)? validator;
  final double? borderRadius;
  final String Function(T) itemLabel; // to display selected chips

  const AppMultiSelectDropDown({
    super.key,
    this.title,
    this.borderRadius,
    required this.labelText,
    required this.selectedValues,
    required this.onChanged,
    required this.items,
    required this.itemLabel,
    this.validator,
  });

  @override
  State<AppMultiSelectDropDown<T>> createState() =>
      _AppMultiSelectDropDownState<T>();
}

class _AppMultiSelectDropDownState<T> extends State<AppMultiSelectDropDown<T>> {
  void _showMultiSelectDialog() async {
    final result = await showDialog<List<T>>(
      context: context,
      builder: (context) => _MultiSelectDialog<T>(
        items: widget.items,
        initialSelected: widget.selectedValues,
        itemLabel: widget.itemLabel,
      ),
    );
    if (result != null) {
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: TextStyle(fontSize: AppFontSizes.sm)),
        6.gap,
        GestureDetector(
          onTap: _showMultiSelectDialog,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.selectedValues.isEmpty
                  ? widget.labelText
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 30),
                borderSide: const BorderSide(
                  width: 0.8,
                  color: AppColor.primaryColor,
                ),
              ),
              suffixIcon: const Icon(Icons.arrow_drop_down),
            ),
            child: widget.selectedValues.isEmpty
                ? const SizedBox.shrink()
                : Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: widget.selectedValues.map((value) {
                      return Chip(
                        label: Text(
                          widget.itemLabel(value),
                          style: const TextStyle(fontSize: 12),
                        ),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          final updated = List<T>.from(widget.selectedValues)
                            ..remove(value);
                          widget.onChanged(updated);
                        },
                        backgroundColor: AppColor.primaryColor.withValues(alpha: 0.1),
                        side: const BorderSide(color: AppColor.primaryColor),
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }
}

// ─── Dialog ───────────────────────────────────────────────────────────────────

class _MultiSelectDialog<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final List<T> initialSelected;
  final String Function(T) itemLabel;

  const _MultiSelectDialog({
    required this.items,
    required this.initialSelected,
    required this.itemLabel,
  });

  @override
  State<_MultiSelectDialog<T>> createState() => _MultiSelectDialogState<T>();
}

class _MultiSelectDialogState<T> extends State<_MultiSelectDialog<T>> {
  late List<T> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<T>.from(widget.initialSelected);
  }

  void _toggle(T value) {
    setState(() {
      if (_selected.contains(value)) {
        _selected.remove(value);
      } else {
        _selected.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اختر',
              style: TextStyle(
                fontSize: AppFontSizes.md,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
            const Divider(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ListView(
                shrinkWrap: true,
                children: widget.items.map((item) {
                  final isSelected = _selected.contains(item.value);
                  return CheckboxListTile(
                    value: isSelected,
                    title: item.child,
                    activeColor: AppColor.primaryColor,
                    onChanged: (_) => _toggle(item.value as T),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('إلغاء'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => context.pop(_selected),
                  child: const Text(
                    'تطبيق',
                    style: TextStyle(color: AppColor.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
