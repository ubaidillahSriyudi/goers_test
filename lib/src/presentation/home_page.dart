import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goers_test/src/presentation/detail_page.dart';
import 'package:goers_test/src/presentation/provider/prov_species_list.dart';

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) => false);

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  ScrollController? _scrollController;
  String? _nextUrl;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: 10
    )..addListener(_scrollListener);
    ref.read(provListSpecies.notifier).listSpecies();
  }

  _scrollListener() async {
    if (_scrollController?.position.maxScrollExtent == _scrollController?.offset && _nextUrl != null) {
      ref.read(isLoadingProvider.notifier).update((state) => true);
      ref.read(provListSpecies.notifier).paginationSpecies(_nextUrl ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(provListSpecies);
    final watchList = ref.watch(provListSpecies.notifier);
    final isLoadingVal = ref.watch(isLoadingProvider);
    
    if (watch.value?.next != null) {
      _nextUrl = watch.value?.next;
    } else {
      _nextUrl = null;
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Star Wars',
          style: TextStyle(
            fontFamily: 'Starjedi'
          ),
        ),
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: watch.when(
        data: (data) {

          if (data.results != null) {
            Future.delayed(const Duration(milliseconds: 300), (() 
                => ref.read(isLoadingProvider.notifier).update((state) => false)));
          }

          watch.value!.results = null;
         
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(
                  height:  MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                    itemCount: watchList.listResult?.length ?? 0,
                    shrinkWrap: true,
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => DetailSpeciesPage(
                              detailUrl: watchList.listResult?[index].url ?? '',
                            ))
                          ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8.0),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter:  ColorFilter.mode(Colors.black , BlendMode.dstATop),
                                image: AssetImage('assets/images/card.jpeg'),
                                opacity: 100
                              )
                            ),
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('${watchList.listResult?[index].name}', style: const TextStyle(fontFamily: 'Starjedi', color: Colors.white, fontSize: 40), textAlign: TextAlign.center),
                                      const SizedBox(height: 10),
                                      Text('${watchList.listResult?[index].classification}', style: const TextStyle(fontFamily: 'Starjedi', color: Colors.white, fontSize: 20)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }, 
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stack) => Container(), 
        loading: () => Center(
          child: Column(
            children: [
              Image.asset('assets/gif/loading_1.gif'),
              const SizedBox(height: 20,),
              const Text('Calling species...', style: TextStyle(fontFamily: 'Starjedi', color: Colors.white))
            ],
          )
        )
      ),
      floatingActionButton: isLoadingVal 
      ? SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text('Loading...', style: TextStyle(fontFamily: 'Starjedi', color: Colors.white)),
            const SizedBox(width: 10),
            Image.asset('assets/gif/droid_2.gif'),
          ],
        )
      )  
      : Container() ,
    );
  }
}