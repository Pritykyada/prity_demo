import 'package:dio/dio.dart';

abstract class Api {
  Future<Response>? get({required String endpoint});
}