import 'package:ncdc_assignment/features/content/hooks/use_content_api.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_list_provider.g.dart';

@riverpod
class ContentListNotifier extends _$ContentListNotifier {
  UseContentApi get _contentApi => UseContentApi(ref);

  @override
  Future<List<Content>> build() async {
    await _fetchContents();
    return state.requireValue;
  }

  Future<void> _fetchContents() async {
    state = const AsyncValue.loading();
    try {
      final contents = await _contentApi.getList();
      state = AsyncValue.data(contents);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await _fetchContents();
  }

  Future<void> delete(int id) async {
    try {
      await _contentApi.delete(id);
      await _fetchContents();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
