import 'package:flutter/material.dart';
import 'package:olx_app/make_paymanet/models/transaction.dart';
import 'package:olx_app/make_paymanet/paystack_pay_manager.dart';
import 'package:olx_app/otherScreens/uploadAddScreen.dart';



class PaymentScreen extends StatefulWidget {

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Make Payment", style: TextStyle(color: Colors.green),),
        leading: Icon(Icons.security, color: Colors.green),
        centerTitle: true,
      ),
      
       body: Padding(
        padding: const EdgeInsets.only( top: 200.0),
        child: Center(
          child: Column(
            children: [

              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.white,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //icon
                      Icon(Icons.dangerous_rounded, color: Colors.red,),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Make sure to ha 5 different images of your product",
                        style: TextStyle(color: Colors.black, fontSize: 12.5),
                      )
                    ],
                  ),
                ),
              SizedBox(height: 20,),
             Text("Make a payment of ", style: TextStyle(fontFamily: "Lobster", fontSize: 22),),
             Text("GHS 2 before uploading your item.",style: TextStyle(fontFamily: "Lobster", fontSize: 22),),
             Text("with your mobile money number.",style: TextStyle(fontFamily: "Lobster", fontSize: 22),),
             SizedBox(height: 15,),

             GestureDetector(
               onTap: (){
                 _checkPayment();
               },
               child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.green,
                  borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //icon
                      Icon(Icons.security, color: Colors.white,),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Proceed to payment",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
             ),
            
            ],
          ),
        ),
      ),


    );
  }

void _checkPayment() {
    try {
      PaystackPayManager(context: context)
        ..setSecretKey("sk_test_497a33c8e41bfc7e5592c49d61e0501164299257")
        // ..setCompanyAssetImage(Image(image: NetworkImage("YOUR-IMAGE-URL")))
        ..setAmount(200)
        ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
        ..setCurrency("GHS")
        ..setEmail("winweba@gmail.com")
        ..setFirstName("Samuel")
        ..setLastName("Adekunle")
        ..setMetadata(
          {
            "custom_fields": [
              {
                "value": "TechWithSam",
                "display_name": "Payment_to",
                "variable_name": "Payment_to"
              }
            ]
          },
        )
        ..onSuccesful(_onPaymentSuccessful)
        ..onPending(_onPaymentPending)
        ..onFailed(_onPaymentFailed)
        ..onCancel(_onCancel)
        ..initialize();
    } catch (error) {
      print('Payment Error ==> $error');
    }
  }

  
  void _onPaymentSuccessful(Transaction transaction) {
    print('Transaction succesful');
    print(
        "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
        Route newRoute = MaterialPageRoute(builder: (context) => UploadAddScreen());
                    Navigator.pushReplacement(context, newRoute);
  }

  void _onPaymentPending(Transaction transaction) {
    print('Transaction Pending');
    print("Transaction Ref ${transaction.refrenceNumber}");
  }

  void _onPaymentFailed(Transaction transaction) {
    print('Transaction Failed');
    print("Transaction message ==> ${transaction.message}");
  }

  void _onCancel(Transaction transaction) {
    print('Transaction Cancelled');
  }
}

