// ignore: file_names
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class AltertUtil{
    void showSuccessAlert(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        animType: QuickAlertAnimType.slideInDown,
        title: 'Submitted!',
        text: 'Your details has been updated successfully',
        confirmBtnColor: const Color.fromARGB(255, 189, 187, 187));
  }

  void showWarningAlert(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        animType: QuickAlertAnimType.slideInDown,
        title: 'Warning!',
        text: "Your location is not within Clinic's range",
        confirmBtnColor: const Color.fromARGB(255, 0, 184, 169));
  }

  void showErrorAlert(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        animType: QuickAlertAnimType.slideInDown,
        title: 'Something went wrong',
        text: "The Audit details were not saved successfully. Try Again!",
        confirmBtnColor: const Color.fromARGB(255, 237, 248, 81));
  }
}