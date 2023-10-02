import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/create_invoice/presentation/pages/Create_invoice_page.dart';
import 'package:supermarket/features/main_page/presentations/blocs/main_bloc.dart';
import 'package:supermarket/features/main_page/presentations/widgets/show_password_dialog_widget.dart';
import 'package:supermarket/features/products/presentations/pages/products_pages.dart';
import 'package:supermarket/injection_container.dart'as di;


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:const Text('Main Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h*0.1,
              ),





              /// products
            BlocProvider(
                create: (context)=>di.sl<MainBloc>(),
              child: BlocConsumer<MainBloc,MainState>(
                listener: (context,state){
                  if(state is FirstShowPasswordDialogState){

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowPasswordDialogWidget(

                          );
                        });

                  }
                },
                builder: (context,state){
                  var bloc=MainBloc.get(context);
                  return InkWell(
                    onTap: (){


                      bloc.add(ShowPasswordDialogEvent());



                    },
                    child: Center(
                      child: Container(
                        height: h*0.3,
                        width: w*0.8,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[400],
                            borderRadius: BorderRadius.all(Radius.circular(w*0.4)),
                            border: Border.all(color: Colors.deepPurple,width: w*0.02, )
                        ),
                        child: Center(
                            child: Text('البضائع',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w*0.1,
                              ),
                            )
                        ),
                      ),
                    ),
                  );
                },

              ),
            ),






              SizedBox(
                height: h*0.1,
              ),
              /// create price
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateInvoicePage()),);

                },
                child: Center(
                  child: Container(
                    height: h*0.3,
                    width: w*0.8,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[400],
                        borderRadius: BorderRadius.all(Radius.circular(w*0.4)),
                        border: Border.all(color: Colors.deepPurple,width: w*0.02, )
                    ),
                    child: Center(
                        child: Text('إنشاء فاتورة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: w*0.1,
                          ),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
