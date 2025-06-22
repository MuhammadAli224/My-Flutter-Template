import '../../../../global_imports.dart';

mixin SyncHiveMixin<T> {
  Future<void> syncBox({
    required Box<T> box,
    required List<T> newItems,
    required int Function(T item) getId,
    Set<dynamic> preserveKeys = const {},
  }) async {
    final newIds = newItems.map(getId).toSet();

    final existingIds = box.keys
        .whereType<int>()
        .where((id) => !preserveKeys.contains(id))
        .toSet();

    final toRemove = existingIds.difference(newIds);
    await box.deleteAll(toRemove);

    await box.putAll({
      for (var item in newItems) getId(item): item,
    });
  }
}
