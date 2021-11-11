import 'package:flutter/material.dart';
import 'package:olx_app/make_paymanet/models/payment_info.dart';
import 'package:olx_app/make_paymanet/models/payment_option.dart';
import 'package:olx_app/make_paymanet/utils/ui_color.dart';
import 'package:olx_app/make_paymanet/widgets/payment_options_list_view.dart';
import 'package:olx_app/make_paymanet/widgets/secured_by.dart';

class PaymentOptionSelectorView extends StatefulWidget {
  const PaymentOptionSelectorView({
    Key key,
    @required this.paymentOptionslist,
    this.onItemPressed,
    this.paymentInfo,
  }) : super(key: key);

  final PaymentInfo paymentInfo;
  final List<PaymentOption> paymentOptionslist;
  final Function onItemPressed;

  @override
  _PaymentOptionSelectorViewState createState() =>
      _PaymentOptionSelectorViewState();
}

class _PaymentOptionSelectorViewState extends State<PaymentOptionSelectorView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "PAYSTACK CHECKOUT",
                style: TextStyle(
                  color: UIColors.accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Use one of the payment methods below to pay",
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${widget.paymentInfo.currency} 2",
              ),
              SizedBox(
                height: 20,
              ),
              PaymentOptionsListview(
                paymentOptionslist: widget.paymentOptionslist,
                onItemPressed: widget.onItemPressed,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SecuredByFooter(),
      ],
    );
  }
}
