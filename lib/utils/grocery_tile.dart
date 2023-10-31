import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:textless/textless.dart';

class GroceryTile extends StatelessWidget {
  final String grocery;
  final bool isBought;
  Function(bool?)? onChanged;
  VoidCallback? onTap;
  Function(BuildContext)? deleteGrocery;
  GroceryTile(
      {Key? key,
      required this.grocery,
      required this.isBought,
      required this.onChanged,
      required this.onTap,
      required this.deleteGrocery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        SlidableAction(
          onPressed: deleteGrocery,
          icon: Icons.delete,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(12),
        )
      ]),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: isBought,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                Expanded(
                  child: isBought
                      ? grocery.h6.lineThrough.overflowEllipsis
                      : grocery.h6.semiBold.overflowEllipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
