class ErrorHandler {
  String getErrorMessage(err) {
    String msg = 'Signup failed';

    if (err != null && err.message != null) {
      msg = msg + ": ${err.message}";
    } else {
      msg = msg + ": Check your network and try again";
    }

    return msg;
  }
}
