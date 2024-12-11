import '/backend/backend.dart';
import '/components/card_asset_widget.dart';
import '/components/header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          decoration: BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                wrapWithModel(
                  model: _model.headerModel,
                  updateCallback: () => safeSetState(() {}),
                  child: HeaderWidget(),
                ),
                StreamBuilder<List<AssetsRecord>>(
                  stream: queryAssetsRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                      );
                    }
                    List<AssetsRecord> wrapAssetsRecordList = snapshot.data!;

                    return Wrap(
                      spacing: 0.0,
                      runSpacing: 0.0,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.horizontal,
                      runAlignment: WrapAlignment.start,
                      verticalDirection: VerticalDirection.down,
                      clipBehavior: Clip.none,
                      children: List.generate(wrapAssetsRecordList.length,
                          (wrapIndex) {
                        final wrapAssetsRecord =
                            wrapAssetsRecordList[wrapIndex];
                        return wrapWithModel(
                          model: _model.cardAssetModels.getModel(
                            wrapAssetsRecord.reference.id,
                            wrapIndex,
                          ),
                          updateCallback: () => safeSetState(() {}),
                          child: CardAssetWidget(
                            key: Key(
                              'Keywsh_${wrapAssetsRecord.reference.id}',
                            ),
                            parameter1: wrapAssetsRecord.imageUrl,
                            parameter2: wrapAssetsRecord.name,
                            parameter3: wrapAssetsRecord.type,
                            parameter4: formatNumber(
                              wrapAssetsRecord.value,
                              formatType: FormatType.decimal,
                              decimalType: DecimalType.periodDecimal,
                              currency: '\$ ',
                            ),
                            parameter5: wrapAssetsRecord,
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
