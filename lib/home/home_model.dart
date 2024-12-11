import '/backend/backend.dart';
import '/components/card_asset_widget.dart';
import '/components/header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Header component.
  late HeaderModel headerModel;
  // Models for CardAsset dynamic component.
  late FlutterFlowDynamicModels<CardAssetModel> cardAssetModels;

  @override
  void initState(BuildContext context) {
    headerModel = createModel(context, () => HeaderModel());
    cardAssetModels = FlutterFlowDynamicModels(() => CardAssetModel());
  }

  @override
  void dispose() {
    headerModel.dispose();
    cardAssetModels.dispose();
  }
}
