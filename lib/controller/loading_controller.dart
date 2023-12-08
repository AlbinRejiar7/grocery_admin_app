import 'package:flutter/material.dart';

class LoadingController with ChangeNotifier {
  bool isLoading = false;
  void changeLoadingState(bool currentState) {
    isLoading = currentState;
    notifyListeners();
  }
}
