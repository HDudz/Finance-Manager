import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    super.key,
    required this.theme,
    required this.transaction,
  });

  final ThemeData theme;
  final dynamic transaction;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    var textStyle = widget.theme.textTheme.bodyLarge!.copyWith(color: widget.theme.colorScheme.surface, fontSize: 17, fontWeight: FontWeight.w500);
    var czyPlus = widget.transaction.type == "Przychodzące";

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: czyPlus ? Colors.green : Colors.red, // Kolor konturu
          width: 3.0, // Grubość konturur
        ),
        borderRadius: BorderRadius.circular(15.0), // Zaokrąglenie rogów (opcjonalne)
      ),
      color: widget.theme.colorScheme.primary,
      child:Theme(
        data: ThemeData(splashColor: widget.theme.colorScheme.primary),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ExpansionTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
              title: Text(widget.transaction.title , style: textStyle),
              trailing: Text((czyPlus?" ":"-") + widget.transaction.amount.toString(), style: textStyle),
              leading: czyPlus ? Icon(Icons.add, color: Colors.green,): Icon(Icons.remove, color: Colors.red,),

            children: [
              widget.transaction.description == null ? const SizedBox() : Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Row(
                  children: [
                    Text("Opis: ",style: textStyle.copyWith(fontSize: 13)),
                    Text(widget.transaction.description.toString(),style: textStyle.copyWith(fontSize: 13)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0).copyWith(left: 10.0, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data:", style: textStyle.copyWith(fontSize: 13),),
                        Text(DateFormat.yMd().add_Hm().format(widget.transaction.date).toString(), style: textStyle.copyWith(fontSize: 13),),

                      ],
                    ),
                  ),
                  widget.transaction.category == null ? SizedBox() : Padding(
                    padding: const EdgeInsets.all(6.0).copyWith(right:10.0, top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kategoria:", style: textStyle.copyWith(fontSize: 13),),
                        Text(widget.transaction.category.toString(), style: textStyle.copyWith(fontSize: 13),),
                      ],
                    ),
                  ),
                ],
              )
            ],
            ),
        ),
      ),
      );
  }
}