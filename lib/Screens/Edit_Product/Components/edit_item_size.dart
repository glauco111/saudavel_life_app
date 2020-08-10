import 'package:flutter/material.dart';
import 'package:saudavel_life_v2/common/widgets/custom_icon_buttom.dart';
import 'package:saudavel_life_v2/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;
  final ItemSize size;
  const EditItemSize(
      {Key key, this.size, this.onRemove, this.onMoveDown, this.onMoveUp})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name) {
              if (name.isEmpty) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock) {
              if (int.tryParse(stock) == null && stock.isEmpty) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
              prefixText: 'R\$',
              labelText: 'Preço',
              isDense: true,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              if (num.tryParse(price) == null && price.isEmpty) {
                return 'inválido';
              }
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButtom(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButtom(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButtom(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
