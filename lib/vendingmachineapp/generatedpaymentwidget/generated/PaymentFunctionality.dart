import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/helpers/transform/transform.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';



class PaymentFunctionality {

  final String cardNumber='';
  final String personName='';
  final String validate='';
  final String cvv='';

  static Future<void> Payment(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: CreditCardInputForm(
              cardHeight: 170,
              showResetButton : true,

              frontCardDecoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
                  ],
                  gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 224, 33, 186),
                        const Color.fromARGB(255, 0, 77, 180),
                      ],
                      begin: const FractionalOffset(-0.0, 1.2),
                      end: const FractionalOffset(0.9, -0.7),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              backCardDecoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black54, blurRadius: 15.0, offset: Offset(0, 8))
                  ],
                  gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 224, 33, 186),
                        const Color.fromARGB(255, 0, 77, 180),
                      ],
                      begin: const FractionalOffset(-0.0, 1.2),
                      end: const FractionalOffset(0.9, -0.7),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              prevButtonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 33, 67),
                      const Color.fromARGB(255, 49, 73, 107),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              nextButtonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 33, 67),
                      const Color.fromARGB(255, 49, 73, 107),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              resetButtonDecoration : BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 33, 67),
                      const Color.fromARGB(255, 49, 73, 107),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              prevButtonTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              nextButtonTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              resetButtonTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              initialAutoFocus: true,


              onStateChange: (currentState, cardInfo ) {
                String cardNumber= cardInfo.cardNumber.toString();
                String personName= cardInfo.name.toString();
                String validate= cardInfo.validate.toString();
                String cvv= cardInfo.cvv.toString();

                if(currentState==InputState.DONE)
                {


                  if(testIfInformationsAreCorrect(cardNumber, personName, validate, cvv)==false){
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(

                        title: Text("Card informations are invalid!"),
                        actions: [
                          TextButton(
                              child: Text('Back'),
                              onPressed: () {
                                Navigator.pop(context);
                              }
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                    return showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmation'),
                          content: Text('Do you want to proceed transaction?'),
                          actions: [
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.pushNamed(context, '/GeneratedPaymentWidget');
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                procidePayment(cardNumber, personName, validate, cvv);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }

              },
            ),


          ),

        );
      },
    );
  }

  static bool testIfInformationsAreCorrect(String cardNumber, String personName, String validate, String cvv) {
    List<String> dateParts = validate.split('/');
    int month = int.parse(dateParts[0]);
    int year = int.parse(dateParts[1]);
    DateTime now = DateTime.now();
    DateTime cardExpirationDate = DateTime(year + 2000, month, 1);

    if(cardNumber.length!=19 || personName.length == 0 || dateParts.length != 2 || cardExpirationDate.isBefore(now) || cvv.length<3){
      return  false;
    }
    else{
      return true;
    }
  }


}

void procidePayment(String cardNumber, String personName, String validate, String cvv ) {

}

