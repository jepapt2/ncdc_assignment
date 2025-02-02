import 'package:logger/web.dart';
import 'package:ncdc_assignment/core/utils/toast_helper.dart';
import 'package:ncdc_assignment/features/content/hooks/use_content_api.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/content_list_provider/content_list_provider.dart';
import 'package:ncdc_assignment/features/content/providers/editing_states_provider/editing_states_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_detail_provider.g.dart';

@riverpod
class ContentDetail extends _$ContentDetail {
  UseContentApi get _contentApi => UseContentApi(ref);

  IsSaveLoading get _isSaveLoadingNotifier =>
      ref.read(isSaveLoadingProvider.notifier);

  IsEditingContentDetail get _isEditingNotifier =>
      ref.read(isEditingContentDetailProvider.notifier);

  ContentList get _contentListProviderNotifier =>
      ref.read(contentListProvider.notifier);

  final logger = Logger();

  @override
  Future<Content> build(int id) async {
    return await fetchContent(id);
  }

  Future<Content> fetchContent(int id) async {
    state = const AsyncValue.loading();
    late Content result;
    state = await AsyncValue.guard(() async {
      result = await _contentApi.get(id);
      return result;
    }, (err) {
      logger.e(err);
      return false;
    });

    return result;
  }

  Future<Content?> updateContent(CreateContentDTO content) async {
    try {
      _isSaveLoadingNotifier.startLoading();
      final now = DateTime.now();
      final result = await _contentApi.update(Content(
        id: id,
        body: content.body ?? state.value?.body ?? '',
        title: content.title ?? state.value?.title ?? '',
        createdAt: state.value?.createdAt,
        updatedAt: now,
      ));
      state = AsyncValue.data(result);
      _contentListProviderNotifier.updateState(result);
      _isEditingNotifier.endEditing();
      return result;
    } catch (e) {
      logger.e(e);
      showToast('更新に失敗しました');
      return null;
    } finally {
      _isSaveLoadingNotifier.endLoading();
    }
  }
}
