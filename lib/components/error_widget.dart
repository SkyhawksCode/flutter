import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trade_inn/utility/colors.dart';
import 'package:trade_inn/utility/utils.dart';


class ErrorHandlerWidget extends StatelessWidget {
  final dynamic store;

  const ErrorHandlerWidget({Key key, @required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///For Opacity
        Observer(
          builder: (_) => Container(
            child: store.shouldLoad
                ? Opacity(
                    opacity: 0.8,
                    child: const ModalBarrier(
                        dismissible: false, color: Colors.white54),
                  )
                : Container(),
          ),
        ),
        //For Progressbar
        Observer(
          builder: (_) => Center(
            child: store.shouldLoad
                ? CircularProgressIndicator(
                    backgroundColor: AppColors.colorRed,
                  )
                : Container(),
          ),
        ),
        //For
        Observer(
          builder: (fun) {
            if (!store.isError) {
              return Container();
            } else {
              print('Error message is ${store.errorMessage}');
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                Utils.showSnackBar("${store.errorMessage}", fun);
                //disable error/snack bar
                store.disableError();
              });
              return Container();
            }
          },
        ),

      ],
    );
  }
}
