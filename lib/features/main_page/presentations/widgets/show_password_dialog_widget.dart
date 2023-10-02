import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/add_product/presentation/widgets/button_widget.dart';
import 'package:supermarket/features/add_product/presentation/widgets/text_form_widget.dart';
import 'package:supermarket/features/main_page/presentations/blocs/main_bloc.dart';
import 'package:supermarket/features/products/presentations/pages/products_pages.dart';
import 'package:supermarket/injection_container.dart' as di;

class ShowPasswordDialogWidget extends StatelessWidget {
  ShowPasswordDialogWidget({
    Key? key,
  }) : super(key: key);
  var formKey = GlobalKey<FormState>();
  bool isPop = true;

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => di.sl<MainBloc>(),
      child: BlocConsumer<MainBloc, MainState>(
        listener: (context, state) {
          print(state);
          if(state is CorrectPasswordState){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  ProductsPage()),);
          }
        },
        builder: (context, state) {
          var bloc = MainBloc.get(context);

          return WillPopScope(
            onWillPop: () async => isPop,

            child: SimpleDialog(
              title: Text('كلمة المرور'),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              // backgroundColor: Colors.red,
              children: [
                SizedBox(
                  height: h * 0.01,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h * 0.01,
                      ),
                      TextFormFieldWidget(
                          controller: password,
                          textInputType: TextInputType.text,
                          obscureText: false,
                          labelText: 'كلمة السر',
                          validator: (value) {
                            if(value!.isEmpty){
                              return 'لا يجب أن يبقى هذا الحقل فارغ';

                            }else{
                              return null;
                            }
                          }),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      ButtonTextWidget(
                          padding: w*0.01,
                          backgroundColor: Colors.deepPurple,
                          text: 'تأكيد',
                          textColor: Colors.white,
                          textSize: w*0.05,
                          onPressed: (){
                            bloc.add(PasswordAndNavigateEvent(password: password.text));

                          })
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
