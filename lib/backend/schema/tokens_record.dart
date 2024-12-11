import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TokensRecord extends FirestoreRecord {
  TokensRecord._(
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

  // "imageUrl" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  bool hasBalance() => _balance != null;

  // "quantity" field.
  double? _quantity;
  double get quantity => _quantity ?? 0.0;
  bool hasQuantity() => _quantity != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _ticker = snapshotData['ticker'] as String?;
    _imageUrl = snapshotData['imageUrl'] as String?;
    _balance = castToType<double>(snapshotData['balance']);
    _quantity = castToType<double>(snapshotData['quantity']);
    _userRef = snapshotData['userRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tokens');

  static Stream<TokensRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TokensRecord.fromSnapshot(s));

  static Future<TokensRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TokensRecord.fromSnapshot(s));

  static TokensRecord fromSnapshot(DocumentSnapshot snapshot) => TokensRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TokensRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TokensRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TokensRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TokensRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTokensRecordData({
  String? name,
  String? ticker,
  String? imageUrl,
  double? balance,
  double? quantity,
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'ticker': ticker,
      'imageUrl': imageUrl,
      'balance': balance,
      'quantity': quantity,
      'userRef': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class TokensRecordDocumentEquality implements Equality<TokensRecord> {
  const TokensRecordDocumentEquality();

  @override
  bool equals(TokensRecord? e1, TokensRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.ticker == e2?.ticker &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.balance == e2?.balance &&
        e1?.quantity == e2?.quantity &&
        e1?.userRef == e2?.userRef;
  }

  @override
  int hash(TokensRecord? e) => const ListEquality().hash(
      [e?.name, e?.ticker, e?.imageUrl, e?.balance, e?.quantity, e?.userRef]);

  @override
  bool isValidKey(Object? o) => o is TokensRecord;
}
