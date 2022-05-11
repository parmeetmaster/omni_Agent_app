import 'package:flutter/material.dart';
import 'package:six_cash/data/model/response/contact_model.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/view/screens/transaction_money/widget/preview_contact_tile.dart';

class ForPersonWidget extends StatelessWidget {
  final ContactModel contactModel;
  const ForPersonWidget({Key key, this.contactModel, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: PreviewContactTile(contactModel: contactModel)),
          ],
        ),

        Container(height: Dimensions.DIVIDER_SIZE_MEDIUM, color: Theme.of(context).dividerColor),


      ],
    );
  }
}
