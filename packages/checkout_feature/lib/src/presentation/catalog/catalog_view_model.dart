import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../core/result.dart';
import '../../domain/entities/catalog.dart';
import '../../domain/entities/money.dart';
import '../../domain/repositories/repositories.dart';
import '../command.dart';

/// The catalogue: load the services, pick one or two, continue to checkout.
class CatalogViewModel extends ChangeNotifier {
  CatalogViewModel({
    required CatalogRepository catalog,
    List<String> initiallySelected = const <String>[],
  }) : _catalog = catalog {
    _selected.addAll(initiallySelected.toSet().take(maxServices));
    load = Command0<List<Service>>(_load)..addListener(notifyListeners);
    unawaited(load.execute());
  }

  static const int maxServices = 2;

  final CatalogRepository _catalog;
  final List<String> _selected = <String>[];

  late final Command0<List<Service>> load;

  List<Service> get services => switch (load.result) {
    Ok<List<Service>>(:final List<Service> value) => value,
    _ => const <Service>[],
  };

  List<String> get selectedIds => List<String>.unmodifiable(_selected);

  bool isSelected(String serviceId) => _selected.contains(serviceId);

  /// A third service can't be picked until one is unpicked.
  bool canToggle(String serviceId) =>
      isSelected(serviceId) || _selected.length < maxServices;

  void toggle(String serviceId) {
    if (isSelected(serviceId)) {
      _selected.remove(serviceId);
    } else if (_selected.length < maxServices) {
      _selected.add(serviceId);
    }
    notifyListeners();
  }

  /// From catalogue prices. The server works out the real total.
  Money get estimatedTotal => services
      .where((Service service) => isSelected(service.id))
      .fold(const Money.zar(0), (Money total, Service s) => total + s.price);

  bool get canContinue => _selected.isNotEmpty;

  Future<Result<List<Service>>> _load() async {
    final Result<List<Service>> result = await _catalog.services();
    if (result case Ok<List<Service>>(:final List<Service> value)) {
      // Drop selections from the URL that aren't real services.
      final Set<String> known = <String>{
        for (final Service service in value) service.id,
      };
      _selected.removeWhere((String id) => !known.contains(id));
    }
    return result;
  }

  @override
  void dispose() {
    load
      ..removeListener(notifyListeners)
      ..dispose();
    super.dispose();
  }
}
