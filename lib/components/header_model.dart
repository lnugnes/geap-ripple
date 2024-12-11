import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'header_widget.dart' show HeaderWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HeaderModel extends FlutterFlowModel<HeaderWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (createWallet)] action in Image widget.
  ApiCallResponse? apiResultCreateWallet;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
