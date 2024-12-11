import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AssetsRecord extends FirestoreRecord {
  AssetsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "ticker" field.
  String? _ticker;
  String get ticker => _ticker ?? '';
  bool hasTicker() => _ticker != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "value" field.
  double? _value;
  double get value => _value ?? 0.0;
  bool hasValue() => _value != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _ticker = snapshotData['ticker'] as String?;
    _description = snapshotData['description'] as String?;
    _imageUrl = snapshotData['imageUrl'] as String?;
    _type = snapshotData['type'] as String?;
    _value = castToType<double>(snapshotData['value']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('assets');

  static Stream<AssetsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AssetsRecord.fromSnapshot(s));

  static Future<AssetsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AssetsRecord.fromSnapshot(s));

  static AssetsRecord fromSnapshot(DocumentSnapshot snapshot) => AssetsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AssetsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AssetsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AssetsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AssetsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAssetsRecordData({
  String? name,
  String? ticker,
  String? description,
  String? imageUrl,
  String? type,
  double? value,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'ticker': ticker,
      'description': description,
      'imageUrl': imageUrl,
      'type': type,
      'value': value,
    }.withoutNulls,
  );

  return firestoreData;
}

class AssetsRecordDocumentEquality implements Equality<AssetsRecord> {
  const AssetsRecordDocumentEquality();

  @override
  bool equals(AssetsRecord? e1, AssetsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.ticker == e2?.ticker &&
        e1?.description == e2?.description &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.type == e2?.type &&
        e1?.value == e2?.value;
  }

  @override
  int hash(AssetsRecord? e) => const ListEquality().hash(
      [e?.name, e?.ticker, e?.description, e?.imageUrl, e?.type, e?.value]);

  @override
  bool isValidKey(Object? o) => o is AssetsRecord;
}
