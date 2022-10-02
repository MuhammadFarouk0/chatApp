import 'package:authorizing/dialoge_utils.dart';
import 'package:flutter/material.dart';

abstract class BaseNavigator{
void showloadingDialog({String message='loaing...'});
void hideloadingDialog();
void showMessageDialog(String message);
}
class BaseViewModel<Nav extends BaseNavigator>extends ChangeNotifier{
  Nav? navigator;
}
abstract class BaseState<T extends StatefulWidget,VM extends BaseViewModel>
    extends State<T> implements BaseNavigator{
  late VM viewModel;
  @override
  void initState() {
    super.initState();
    viewModel= initViewModel();
    viewModel.navigator=this;
  }
  VM initViewModel();
  @override
  void showloadingDialog({String message = 'loaing...'}) {
    showLoading(context, message);
  }
  @override
  void showMessageDialog(String message) {
    showMessage(context, message);
  }
  @override
  void hideloadingDialog() {
    hideLoading(context);

  }
}