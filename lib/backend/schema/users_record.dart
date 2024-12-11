import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  bool hasBalance() => _balance != null;

  // "tokenBalance" field.
  double? _tokenBalance;
  double get tokenBalance => _tokenBalance ?? 0.0;
  bool hasTokenBalance() => _tokenBalance != null;

  // "wallet" field.
  String? _wallet;
  String get wallet => _wallet ?? '';
  bool hasWallet() => _wallet != null;

  // "blockExplorerUrl" field.
  String? _blockExplorerUrl;
  String get blockExplorerUrl => _blockExplorerUrl ?? '';
  bool hasBlockExplorerUrl() => _blockExplorerUrl != null;

  // "publicKey" field.
  String? _publicKey;
  String get publicKey => _publicKey ?? '';
  bool hasPublicKey() => _publicKey != null;

  // "privateKey" field.
  String? _privateKey;
  String get privateKey => _privateKey ?? '';
  bool hasPrivateKey() => _privateKey != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _balance = castToType<double>(snapshotData['balance']);
    _tokenBalance = castToType<double>(snapshotData['tokenBalance']);
    _wallet = snapshotData['wallet'] as String?;
    _blockExplorerUrl = snapshotData['blockExplorerUrl'] as String?;
    _publicKey = snapshotData['publicKey'] as String?;
    _privateKey = snapshotData['privateKey'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  double? balance,
  double? tokenBalance,
  String? wallet,
  String? blockExplorerUrl,
  String? publicKey,
  String? privateKey,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'balance': balance,
      'tokenBalance': tokenBalance,
      'wallet': wallet,
      'blockExplorerUrl': blockExplorerUrl,
      'publicKey': publicKey,
      'privateKey': privateKey,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.balance == e2?.balance &&
        e1?.tokenBalance == e2?.tokenBalance &&
        e1?.wallet == e2?.wallet &&
        e1?.blockExplorerUrl == e2?.blockExplorerUrl &&
        e1?.publicKey == e2?.publicKey &&
        e1?.privateKey == e2?.privateKey;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.balance,
        e?.tokenBalance,
        e?.wallet,
        e?.blockExplorerUrl,
        e?.publicKey,
        e?.privateKey
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
