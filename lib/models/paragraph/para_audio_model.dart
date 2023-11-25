import 'package:freezed_annotation/freezed_annotation.dart';
part 'para_audio_model.freezed.dart';
part 'para_audio_model.g.dart';

@freezed
class ParaAudio with _$ParaAudio {
  const factory ParaAudio({
    //add the code in analysis_options.yaml to ignore the JsonKey warning
    //json key : snack_case
    //field key : camelCase

    @JsonKey(name: 'paragraph_id') String? paragraphId,
    @JsonKey(name: 'voice_type') String? voiceType,
    @JsonKey(name: 'url') String? url,
  }) = _ParaAudio;

  factory ParaAudio.fromJson(Map<String, dynamic> json) =>
      _$ParaAudioFromJson(json);
}
