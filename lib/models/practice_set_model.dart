import 'package:freezed_annotation/freezed_annotation.dart';

part 'practice_set_model.freezed.dart';
part 'practice_set_model.g.dart';

@freezed
class PracticeSetModel with _$PracticeSetModel {
  factory PracticeSetModel({
    @Default(0) int no,
    @Default('') String question,
    @Default(
        'https://thumb.ac-illust.com/b1/b170870007dfa419295d949814474ab2_t.jpeg')
    String mediaFile,
    @Default(<OptionModel>[]) final List<OptionModel> options,
    @Default('') String explanation,
    @Default(false) bool isSubmitted,
    OptionModel? submit,
  }) = _PracticeSetModel;

  factory PracticeSetModel.fromJson(Map<String, dynamic> json) =>
      _$PracticeSetModelFromJson(json);
}

@freezed
class OptionModel with _$OptionModel {
  factory OptionModel({
    @Default('') String slNo,
    @Default('') String value,
    @Default(false) bool answer,
  }) = _OptionModel;

  factory OptionModel.fromJson(Map<String, dynamic> json) =>
      _$OptionModelFromJson(json);
}
