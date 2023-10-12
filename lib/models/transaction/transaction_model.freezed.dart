// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_type')
  String? get productType => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  String? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String? get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'coin_id')
  int? get coinId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_price')
  dynamic get totalPrice =>
      throw _privateConstructorUsedError; //can be int or double
  @JsonKey(name: 'total_price_after_commission')
  dynamic get totalPriceAfterCommission => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_type')
  String? get transactionType => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_status')
  String? get transactionStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'product_type') String? productType,
      @JsonKey(name: 'product_id') String? productId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'coin_id') int? coinId,
      @JsonKey(name: 'total_price') dynamic totalPrice,
      @JsonKey(name: 'total_price_after_commission')
      dynamic totalPriceAfterCommission,
      @JsonKey(name: 'transaction_type') String? transactionType,
      @JsonKey(name: 'transaction_status') String? transactionStatus,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? productType = freezed,
    Object? productId = freezed,
    Object? productName = freezed,
    Object? coinId = freezed,
    Object? totalPrice = freezed,
    Object? totalPriceAfterCommission = freezed,
    Object? transactionType = freezed,
    Object? transactionStatus = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      productType: freezed == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceAfterCommission: freezed == totalPriceAfterCommission
          ? _value.totalPriceAfterCommission
          : totalPriceAfterCommission // ignore: cast_nullable_to_non_nullable
              as dynamic,
      transactionType: freezed == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionStatus: freezed == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$_TransactionCopyWith(
          _$_Transaction value, $Res Function(_$_Transaction) then) =
      __$$_TransactionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'product_type') String? productType,
      @JsonKey(name: 'product_id') String? productId,
      @JsonKey(name: 'product_name') String? productName,
      @JsonKey(name: 'coin_id') int? coinId,
      @JsonKey(name: 'total_price') dynamic totalPrice,
      @JsonKey(name: 'total_price_after_commission')
      dynamic totalPriceAfterCommission,
      @JsonKey(name: 'transaction_type') String? transactionType,
      @JsonKey(name: 'transaction_status') String? transactionStatus,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate});
}

/// @nodoc
class __$$_TransactionCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$_Transaction>
    implements _$$_TransactionCopyWith<$Res> {
  __$$_TransactionCopyWithImpl(
      _$_Transaction _value, $Res Function(_$_Transaction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? productType = freezed,
    Object? productId = freezed,
    Object? productName = freezed,
    Object? coinId = freezed,
    Object? totalPrice = freezed,
    Object? totalPriceAfterCommission = freezed,
    Object? transactionType = freezed,
    Object? transactionStatus = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
  }) {
    return _then(_$_Transaction(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      productType: freezed == productType
          ? _value.productType
          : productType // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      coinId: freezed == coinId
          ? _value.coinId
          : coinId // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPrice: freezed == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalPriceAfterCommission: freezed == totalPriceAfterCommission
          ? _value.totalPriceAfterCommission
          : totalPriceAfterCommission // ignore: cast_nullable_to_non_nullable
              as dynamic,
      transactionType: freezed == transactionType
          ? _value.transactionType
          : transactionType // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionStatus: freezed == transactionStatus
          ? _value.transactionStatus
          : transactionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transaction implements _Transaction {
  const _$_Transaction(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'user_id') this.userId = '',
      @JsonKey(name: 'product_type') this.productType = '',
      @JsonKey(name: 'product_id') this.productId = '',
      @JsonKey(name: 'product_name') this.productName = '',
      @JsonKey(name: 'coin_id') this.coinId,
      @JsonKey(name: 'total_price') this.totalPrice,
      @JsonKey(name: 'total_price_after_commission')
      this.totalPriceAfterCommission,
      @JsonKey(name: 'transaction_type') this.transactionType,
      @JsonKey(name: 'transaction_status') this.transactionStatus = '',
      @JsonKey(name: 'created_date') this.createdDate = '',
      @JsonKey(name: 'updated_date') this.updatedDate = ''});

  factory _$_Transaction.fromJson(Map<String, dynamic> json) =>
      _$$_TransactionFromJson(json);

//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @JsonKey(name: 'product_type')
  final String? productType;
  @override
  @JsonKey(name: 'product_id')
  final String? productId;
  @override
  @JsonKey(name: 'product_name')
  final String? productName;
  @override
  @JsonKey(name: 'coin_id')
  final int? coinId;
  @override
  @JsonKey(name: 'total_price')
  final dynamic totalPrice;
//can be int or double
  @override
  @JsonKey(name: 'total_price_after_commission')
  final dynamic totalPriceAfterCommission;
  @override
  @JsonKey(name: 'transaction_type')
  final String? transactionType;
  @override
  @JsonKey(name: 'transaction_status')
  final String? transactionStatus;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;

  @override
  String toString() {
    return 'Transaction(id: $id, userId: $userId, productType: $productType, productId: $productId, productName: $productName, coinId: $coinId, totalPrice: $totalPrice, totalPriceAfterCommission: $totalPriceAfterCommission, transactionType: $transactionType, transactionStatus: $transactionStatus, createdDate: $createdDate, updatedDate: $updatedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transaction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productType, productType) ||
                other.productType == productType) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.coinId, coinId) || other.coinId == coinId) &&
            const DeepCollectionEquality()
                .equals(other.totalPrice, totalPrice) &&
            const DeepCollectionEquality().equals(
                other.totalPriceAfterCommission, totalPriceAfterCommission) &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.transactionStatus, transactionStatus) ||
                other.transactionStatus == transactionStatus) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      productType,
      productId,
      productName,
      coinId,
      const DeepCollectionEquality().hash(totalPrice),
      const DeepCollectionEquality().hash(totalPriceAfterCommission),
      transactionType,
      transactionStatus,
      createdDate,
      updatedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      __$$_TransactionCopyWithImpl<_$_Transaction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransactionToJson(
      this,
    );
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'user_id') final String? userId,
          @JsonKey(name: 'product_type') final String? productType,
          @JsonKey(name: 'product_id') final String? productId,
          @JsonKey(name: 'product_name') final String? productName,
          @JsonKey(name: 'coin_id') final int? coinId,
          @JsonKey(name: 'total_price') final dynamic totalPrice,
          @JsonKey(name: 'total_price_after_commission')
          final dynamic totalPriceAfterCommission,
          @JsonKey(name: 'transaction_type') final String? transactionType,
          @JsonKey(name: 'transaction_status') final String? transactionStatus,
          @JsonKey(name: 'created_date') final String? createdDate,
          @JsonKey(name: 'updated_date') final String? updatedDate}) =
      _$_Transaction;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$_Transaction.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'product_type')
  String? get productType;
  @override
  @JsonKey(name: 'product_id')
  String? get productId;
  @override
  @JsonKey(name: 'product_name')
  String? get productName;
  @override
  @JsonKey(name: 'coin_id')
  int? get coinId;
  @override
  @JsonKey(name: 'total_price')
  dynamic get totalPrice;
  @override //can be int or double
  @JsonKey(name: 'total_price_after_commission')
  dynamic get totalPriceAfterCommission;
  @override
  @JsonKey(name: 'transaction_type')
  String? get transactionType;
  @override
  @JsonKey(name: 'transaction_status')
  String? get transactionStatus;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(name: 'updated_date')
  String? get updatedDate;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionCopyWith<_$_Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}
