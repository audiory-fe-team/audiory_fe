// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportImpl _$$ReportImplFromJson(Map<String, dynamic> json) => _$ReportImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      reportedId: json['reported_id'] as String? ?? '',
      reportedType: json['report_type'] as String? ?? 'COMMENT',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['image_url'] as String? ?? '',
      createdDate: json['created_date'] as String? ?? '',
      updatedDate: json['updated_date'] as String? ?? '',
      approvedDate: json['approved_date'] as String? ?? '',
      approvedBy: json['approved_by'] as String? ?? '',
      rejectedDate: json['rejected_date'] as String? ?? '',
      rejectedBy: json['rejected_by'] as String? ?? '',
      reportStatus: json['report_status'] as String? ?? '',
      responseMessage: json['response_message'] as String? ?? '',
      isEnabled: json['is_enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$$ReportImplToJson(_$ReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'reported_id': instance.reportedId,
      'report_type': instance.reportedType,
      'title': instance.title,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'created_date': instance.createdDate,
      'updated_date': instance.updatedDate,
      'approved_date': instance.approvedDate,
      'approved_by': instance.approvedBy,
      'rejected_date': instance.rejectedDate,
      'rejected_by': instance.rejectedBy,
      'report_status': instance.reportStatus,
      'response_message': instance.responseMessage,
      'is_enabled': instance.isEnabled,
    };
