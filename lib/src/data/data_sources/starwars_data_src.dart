import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goers_test/src/data/model/model_species.dart';
import 'package:goers_test/src/data/model/model_species_detail.dart';
import 'package:http/http.dart' as http;

final starWarsDataSrcProvider = Provider((ref) => StarWarsDataSource());

class StarWarsDataSource {

  Future<ModelSpecies> speciesList() async {
    try {
      final url = Uri.parse('https://swapi.dev/api/species/');
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelSpecies.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesList Catch $e');
      }
      return ModelSpecies();
    }
  }

  Future<ModelSpecies> speciesPagination(String nextUrl) async {
    try {
      final url = Uri.parse(nextUrl);
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelSpecies.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesPagination Catch $e');
      }
      return ModelSpecies();
    }
  }

  Future<ModelSpeciesDetail> speciesDetail(String detailUrl) async {
    try {
      final url = Uri.parse(detailUrl);
      final response = await http.get(url);
      final convert = json.decode(response.body);
      final object = ModelSpeciesDetail.fromJson(convert);
      
      return object;
    } catch (e) {
      if (kDebugMode) {
        print('speciesPagination Catch $e');
      }
      return ModelSpeciesDetail();
    }
  }
}