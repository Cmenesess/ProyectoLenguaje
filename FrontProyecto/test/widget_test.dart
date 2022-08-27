// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:sava_mobile/main.dart';
import 'package:sava_mobile/screens/screens.dart';
import 'package:sava_mobile/widgets/widgets.dart';

void main() {
  testWidgets("Login button trigger home screen", (WidgetTester tester) async {
    await tester.pumpWidget(const SavaExpressApp());
    // Verify that our counter starts at 0.
    expect(find.text('Usuario'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);

    // Tap the login button
    await tester.tap(find.text("Iniciar Sesión"));
    await tester.pump();

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text('Ingrese su código'), findsOneWidget);
    expect(find.text('Historial'), findsOneWidget);
    expect(find.byType(WarehousePackageWidget), findsWidgets);
  });

  testWidgets("Home Screen trigger Historial Screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(const SavaExpressApp());
    await tester.tap(find.text("Iniciar Sesión"));
    await tester.pump();
    await tester.tap(find.text("Historial"));
    await tester.pump();

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text('Ingrese su código'), findsOneWidget);
    expect(find.text('Historial'), findsOneWidget);
    expect(find.byType(WarehousePackageWidget), findsWidgets);
  });

  testWidgets("Home Screen trigger Historial Screen",
      (WidgetTester tester) async {
    await tester.pumpWidget(const SavaExpressApp());
    await tester.tap(find.text("Iniciar Sesión"));
    await tester.pump();
    await tester.tap(find.text("Historial"));
    await tester.pump();

    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text('Ingrese su código'), findsOneWidget);
    expect(find.text('Historial'), findsOneWidget);
    expect(find.byType(WarehousePackageWidget), findsWidgets);
  });
}
