import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'withdraw_widget.dart' show WithdrawWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WithdrawModel extends FlutterFlowModel<WithdrawWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for txtValue widget.
  FocusNode? txtValueFocusNode;
  TextEditingController? txtValueTextController;
  String? Function(BuildContext, String?)? txtValueTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    txtValueFocusNode?.dispose();
    txtValueTextController?.dispose();
  }
}
