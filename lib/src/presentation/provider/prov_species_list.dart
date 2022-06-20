import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goers_test/src/data/data_sources/starwars_data_src.dart';
import 'package:goers_test/src/data/model/model_species.dart';

final provListSpecies = StateNotifierProvider<NotifierSpeciesList, AsyncValue<ModelSpecies>>((ref) 
    => NotifierSpeciesList(ref));

class NotifierSpeciesList extends StateNotifier<AsyncValue<ModelSpecies>> {
  final StateNotifierProviderRef _provider;
  late final StarWarsDataSource _dataSource;
  List<Results>? listResult;

  NotifierSpeciesList(this._provider) : super(AsyncValue.data(ModelSpecies())) {
    _dataSource = _provider.watch(starWarsDataSrcProvider);
  }

  Future<void> listSpecies() async {
    state = const AsyncLoading();
    final res = await AsyncValue.guard(() async => await _dataSource.speciesList());
    listResult = res.value?.results;
    state = AsyncValue.data(res.asData!.value);
  }

  Future<void> paginationSpecies(String url) async {
    final res = await AsyncValue.guard(() async => await _dataSource.speciesPagination(url));
    
    if (listResult != null) {
      for (var i = 0; i < res.value!.results!.length; i++) {
        listResult!.add( res.value!.results![i]);
      }
      
    }
    state = AsyncValue.data(res.asData!.value);
  }

  @override
  void dispose() {
    super.dispose();
  }
}