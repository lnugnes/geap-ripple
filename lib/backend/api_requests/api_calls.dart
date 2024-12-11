import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start BNK Group Code

class BnkGroup {
  static String getBaseUrl() => 'https://api.2bnk.com';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'x-api-key': 'AJvcdPumqoaDqBMvJyWqL1ZofIUAt5Fw3GPbJTxC',
  };
  static CreateWalletCall createWalletCall = CreateWalletCall();
}

class CreateWalletCall {
  Future<ApiCallResponse> call() async {
    final baseUrl = BnkGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'createWallet',
      apiUrl: '${baseUrl}/ripple/wallets',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': 'AJvcdPumqoaDqBMvJyWqL1ZofIUAt5Fw3GPbJTxC',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? address(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.address''',
      ));
  String? secret(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.secret''',
      ));
}

/// End BNK Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
