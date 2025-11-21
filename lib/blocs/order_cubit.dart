import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/menu_model.dart';

class OrderState {
  final Map<MenuModel, int> items;
  final double totalPrice;

  OrderState({
    required this.items,
    required this.totalPrice,
  });

  OrderState copyWith({
    Map<MenuModel, int>? items,
    double? totalPrice,
  }) {
    return OrderState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory OrderState.initial() {
    return OrderState(
      items: {},
      totalPrice: 0.0,
    );
  }
}

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState.initial());

  void addToOrder(MenuModel menu) {
    final updated = Map<MenuModel, int>.from(state.items);

    updated[menu] = (updated[menu] ?? 0) + 1;

    emit(state.copyWith(
      items: updated,
      totalPrice: _calculateTotal(updated),
    ));
  }

  void removeFromOrder(MenuModel menu) {
    final updated = Map<MenuModel, int>.from(state.items);

    if (updated.containsKey(menu)) {
      if (updated[menu]! > 1) {
        updated[menu] = updated[menu]! - 1;
      } else {
        updated.remove(menu);
      }
    }

    emit(state.copyWith(
      items: updated,
      totalPrice: _calculateTotal(updated),
    ));
  }

  void updateQuantity(MenuModel menu, int qty) {
    final updated = Map<MenuModel, int>.from(state.items);

    if (qty <= 0) {
      updated.remove(menu);
    } else {
      updated[menu] = qty;
    }

    emit(state.copyWith(
      items: updated,
      totalPrice: _calculateTotal(updated),
    ));
  }

  double getTotalPrice() {
    return _calculateTotal(state.items);
  }

  double _calculateTotal(Map<MenuModel, int> items) {
    double total = 0;

    items.forEach((menu, qty) {
      total += menu.getDiscountedPrice() * qty;
    });

    return total;
  }

  void clearOrder() {
    emit(OrderState.initial());
  }
}
