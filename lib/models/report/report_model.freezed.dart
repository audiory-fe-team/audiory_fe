// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Report _$ReportFromJson(Map<String, dynamic> json) {
  return _Report.fromJson(json);
}

/// @nodoc
mixin _$Report {
//add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reported_id')
  String? get reportedId => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_type')
  String? get reportedType => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_date')
  String? get createdDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_date')
  String? get updatedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_date')
  String? get approvedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'approved_by')
  String? get approvedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejected_date')
  String? get rejectedDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejected_by')
  String? get rejectedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'report_status')
  String? get reportStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'response_message')
  String? get responseMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportCopyWith<Report> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportCopyWith<$Res> {
  factory $ReportCopyWith(Report value, $Res Function(Report) then) =
      _$ReportCopyWithImpl<$Res, Report>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'reported_id') String? reportedId,
      @JsonKey(name: 'report_type') String? reportedType,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'approved_date') String? approvedDate,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'rejected_date') String? rejectedDate,
      @JsonKey(name: 'rejected_by') String? rejectedBy,
      @JsonKey(name: 'report_status') String? reportStatus,
      @JsonKey(name: 'response_message') String? responseMessage,
      @JsonKey(name: 'is_enabled') bool? isEnabled});
}

/// @nodoc
class _$ReportCopyWithImpl<$Res, $Val extends Report>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? reportedId = freezed,
    Object? reportedType = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? approvedDate = freezed,
    Object? approvedBy = freezed,
    Object? rejectedDate = freezed,
    Object? rejectedBy = freezed,
    Object? reportStatus = freezed,
    Object? responseMessage = freezed,
    Object? isEnabled = freezed,
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
      reportedId: freezed == reportedId
          ? _value.reportedId
          : reportedId // ignore: cast_nullable_to_non_nullable
              as String?,
      reportedType: freezed == reportedType
          ? _value.reportedType
          : reportedType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedDate: freezed == approvedDate
          ? _value.approvedDate
          : approvedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedDate: freezed == rejectedDate
          ? _value.rejectedDate
          : rejectedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reportStatus: freezed == reportStatus
          ? _value.reportStatus
          : reportStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      responseMessage: freezed == responseMessage
          ? _value.responseMessage
          : responseMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportImplCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$$ReportImplCopyWith(
          _$ReportImpl value, $Res Function(_$ReportImpl) then) =
      __$$ReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'user_id') String? userId,
      @JsonKey(name: 'reported_id') String? reportedId,
      @JsonKey(name: 'report_type') String? reportedType,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'image_url') String? imageUrl,
      @JsonKey(name: 'created_date') String? createdDate,
      @JsonKey(name: 'updated_date') String? updatedDate,
      @JsonKey(name: 'approved_date') String? approvedDate,
      @JsonKey(name: 'approved_by') String? approvedBy,
      @JsonKey(name: 'rejected_date') String? rejectedDate,
      @JsonKey(name: 'rejected_by') String? rejectedBy,
      @JsonKey(name: 'report_status') String? reportStatus,
      @JsonKey(name: 'response_message') String? responseMessage,
      @JsonKey(name: 'is_enabled') bool? isEnabled});
}

/// @nodoc
class __$$ReportImplCopyWithImpl<$Res>
    extends _$ReportCopyWithImpl<$Res, _$ReportImpl>
    implements _$$ReportImplCopyWith<$Res> {
  __$$ReportImplCopyWithImpl(
      _$ReportImpl _value, $Res Function(_$ReportImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? reportedId = freezed,
    Object? reportedType = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? approvedDate = freezed,
    Object? approvedBy = freezed,
    Object? rejectedDate = freezed,
    Object? rejectedBy = freezed,
    Object? reportStatus = freezed,
    Object? responseMessage = freezed,
    Object? isEnabled = freezed,
  }) {
    return _then(_$ReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      reportedId: freezed == reportedId
          ? _value.reportedId
          : reportedId // ignore: cast_nullable_to_non_nullable
              as String?,
      reportedType: freezed == reportedType
          ? _value.reportedType
          : reportedType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedDate: freezed == updatedDate
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedDate: freezed == approvedDate
          ? _value.approvedDate
          : approvedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedDate: freezed == rejectedDate
          ? _value.rejectedDate
          : rejectedDate // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectedBy: freezed == rejectedBy
          ? _value.rejectedBy
          : rejectedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reportStatus: freezed == reportStatus
          ? _value.reportStatus
          : reportStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      responseMessage: freezed == responseMessage
          ? _value.responseMessage
          : responseMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnabled: freezed == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportImpl implements _Report {
  const _$ReportImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'user_id') this.userId = '',
      @JsonKey(name: 'reported_id') this.reportedId = '',
      @JsonKey(name: 'report_type') this.reportedType = 'COMMENT',
      @JsonKey(name: 'title') this.title = '',
      @JsonKey(name: 'description') this.description = '',
      @JsonKey(name: 'image_url') this.imageUrl = '',
      @JsonKey(name: 'created_date') this.createdDate = '',
      @JsonKey(name: 'updated_date') this.updatedDate = '',
      @JsonKey(name: 'approved_date') this.approvedDate = '',
      @JsonKey(name: 'approved_by') this.approvedBy = '',
      @JsonKey(name: 'rejected_date') this.rejectedDate = '',
      @JsonKey(name: 'rejected_by') this.rejectedBy = '',
      @JsonKey(name: 'report_status') this.reportStatus = '',
      @JsonKey(name: 'response_message') this.responseMessage = '',
      @JsonKey(name: 'is_enabled') this.isEnabled = true});

  factory _$ReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportImplFromJson(json);

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
  @JsonKey(name: 'reported_id')
  final String? reportedId;
  @override
  @JsonKey(name: 'report_type')
  final String? reportedType;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'created_date')
  final String? createdDate;
  @override
  @JsonKey(name: 'updated_date')
  final String? updatedDate;
  @override
  @JsonKey(name: 'approved_date')
  final String? approvedDate;
  @override
  @JsonKey(name: 'approved_by')
  final String? approvedBy;
  @override
  @JsonKey(name: 'rejected_date')
  final String? rejectedDate;
  @override
  @JsonKey(name: 'rejected_by')
  final String? rejectedBy;
  @override
  @JsonKey(name: 'report_status')
  final String? reportStatus;
  @override
  @JsonKey(name: 'response_message')
  final String? responseMessage;
  @override
  @JsonKey(name: 'is_enabled')
  final bool? isEnabled;

  @override
  String toString() {
    return 'Report(id: $id, userId: $userId, reportedId: $reportedId, reportedType: $reportedType, title: $title, description: $description, imageUrl: $imageUrl, createdDate: $createdDate, updatedDate: $updatedDate, approvedDate: $approvedDate, approvedBy: $approvedBy, rejectedDate: $rejectedDate, rejectedBy: $rejectedBy, reportStatus: $reportStatus, responseMessage: $responseMessage, isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.reportedId, reportedId) ||
                other.reportedId == reportedId) &&
            (identical(other.reportedType, reportedType) ||
                other.reportedType == reportedType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            (identical(other.updatedDate, updatedDate) ||
                other.updatedDate == updatedDate) &&
            (identical(other.approvedDate, approvedDate) ||
                other.approvedDate == approvedDate) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.rejectedDate, rejectedDate) ||
                other.rejectedDate == rejectedDate) &&
            (identical(other.rejectedBy, rejectedBy) ||
                other.rejectedBy == rejectedBy) &&
            (identical(other.reportStatus, reportStatus) ||
                other.reportStatus == reportStatus) &&
            (identical(other.responseMessage, responseMessage) ||
                other.responseMessage == responseMessage) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      reportedId,
      reportedType,
      title,
      description,
      imageUrl,
      createdDate,
      updatedDate,
      approvedDate,
      approvedBy,
      rejectedDate,
      rejectedBy,
      reportStatus,
      responseMessage,
      isEnabled);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      __$$ReportImplCopyWithImpl<_$ReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportImplToJson(
      this,
    );
  }
}

abstract class _Report implements Report {
  const factory _Report(
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'user_id') final String? userId,
      @JsonKey(name: 'reported_id') final String? reportedId,
      @JsonKey(name: 'report_type') final String? reportedType,
      @JsonKey(name: 'title') final String? title,
      @JsonKey(name: 'description') final String? description,
      @JsonKey(name: 'image_url') final String? imageUrl,
      @JsonKey(name: 'created_date') final String? createdDate,
      @JsonKey(name: 'updated_date') final String? updatedDate,
      @JsonKey(name: 'approved_date') final String? approvedDate,
      @JsonKey(name: 'approved_by') final String? approvedBy,
      @JsonKey(name: 'rejected_date') final String? rejectedDate,
      @JsonKey(name: 'rejected_by') final String? rejectedBy,
      @JsonKey(name: 'report_status') final String? reportStatus,
      @JsonKey(name: 'response_message') final String? responseMessage,
      @JsonKey(name: 'is_enabled') final bool? isEnabled}) = _$ReportImpl;

  factory _Report.fromJson(Map<String, dynamic> json) = _$ReportImpl.fromJson;

  @override //add the code in analysis_options.yaml to ignore the JsonKey warning
//json key : snack_case
//field key : camelCase
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;
  @override
  @JsonKey(name: 'reported_id')
  String? get reportedId;
  @override
  @JsonKey(name: 'report_type')
  String? get reportedType;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'created_date')
  String? get createdDate;
  @override
  @JsonKey(name: 'updated_date')
  String? get updatedDate;
  @override
  @JsonKey(name: 'approved_date')
  String? get approvedDate;
  @override
  @JsonKey(name: 'approved_by')
  String? get approvedBy;
  @override
  @JsonKey(name: 'rejected_date')
  String? get rejectedDate;
  @override
  @JsonKey(name: 'rejected_by')
  String? get rejectedBy;
  @override
  @JsonKey(name: 'report_status')
  String? get reportStatus;
  @override
  @JsonKey(name: 'response_message')
  String? get responseMessage;
  @override
  @JsonKey(name: 'is_enabled')
  bool? get isEnabled;
  @override
  @JsonKey(ignore: true)
  _$$ReportImplCopyWith<_$ReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
