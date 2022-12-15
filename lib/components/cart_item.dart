import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget(this.cartItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: Text('${cartItem.price}'),
            ),
          ),
        ),
        title: Text(cartItem.name),
        subtitle: Text('Total : € ${cartItem.price * cartItem.quantity}'),
        trailing: Text('${cartItem.quantity}x'),
      ),
    );
  }
}
