import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'editing_states_provider.g.dart';

@riverpod
class IsEditingContentList extends _$IsEditingContentList {
  @override
  bool build() => false;

  void startEditing() => state = true;

  void endEditing() => state = false;
}

@riverpod
class IsEditingContentDetail extends _$IsEditingContentDetail {
  @override
  bool build() => false;

  void startEditing() => state = true;

  void endEditing() => state = false;
}

@riverpod
class IsSaveLoading extends _$IsSaveLoading {
  @override
  bool build() => false;

  void startLoading() => state = true;

  void endLoading() => state = false;
}
