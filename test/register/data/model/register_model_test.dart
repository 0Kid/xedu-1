import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:xedu/features/register/data/model/register_model.dart';
import 'package:xedu/features/register/domain/entity/register.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  final tRegisterModel = RegisterModel(
    status: 200,
    message: "Success"
  );

  test('should be subclass of register', () {
    //assert
    expect(tRegisterModel, isA<Register>());
  });

  test('should return valid json model', () {
    //arange
    Map<String, dynamic> jsonMap = jsonDecode(fixture('register_response.json'));
    //act
    final result = RegisterModel.fromJson(jsonMap);
    //assert
    expect(result, equals(tRegisterModel));
  });
}