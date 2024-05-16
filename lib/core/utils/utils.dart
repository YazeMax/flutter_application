import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/common/data/data_sources/authentication/firebase_auth_service.dart';
import 'package:flutter_application_1/features/common/presentation/pages/login_page.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

int randomId() {
  final random = Random();
  int min = 1000000000;
  int max = 4294967296; // 2^32 is the maximum value
  return min + random.nextInt(max - min);
}

void navigateWithReplacementTo(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void navigateTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

Future<void> showLoadingDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => const AlertDialog(
      content: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
              Text(
                "Loading . . . ",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

TableRow buildTableRow(String prop, String value) {
  return TableRow(
    children: [
      TableCell(child: Text(prop)),
      TableCell(
        child: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

String formatDate(DateTime date) => "${date.day}/${date.month}/${date.year}";

void signOut(BuildContext context) {
  FirebaseAuthService auth = FirebaseAuthService();
  auth.logout();

  navigateWithReplacementTo(context, const LoginPage());
}
