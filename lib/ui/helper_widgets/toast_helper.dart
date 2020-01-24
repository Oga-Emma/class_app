import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

showErrorToast(String message) {
  BotToast.showText(text: message, contentColor: Colors.red);
}

showSuccessToast(String message) {
  BotToast.showText(text: message, contentColor: Colors.green);
}

showLoading() {
  BotToast.showLoading();
}

closeLoading() {
  BotToast.closeAllLoading();
}
