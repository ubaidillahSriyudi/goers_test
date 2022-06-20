import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goers_test/common/custom_text.dart';
import 'package:goers_test/src/presentation/provider/prov_species_detail.dart';

class DetailSpeciesPage extends ConsumerStatefulWidget {
  final String detailUrl;

  const DetailSpeciesPage({Key? key, required this.detailUrl}) : super(key: key);


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailSpeciesPageState();
}

class _DetailSpeciesPageState extends ConsumerState<DetailSpeciesPage> {

  @override
  void initState() {
    super.initState();
    ref.read(provSpeciesDetail.notifier).speciesDetail(widget.detailUrl);
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(provSpeciesDetail);

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
      body: watch.when(
        data: (data) => ListView(
          children: [
            Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/war.jpeg'),
                  fit: BoxFit.cover
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText().starjediWhite(txt: watch.value?.name ?? '', size: 20),
                      const SizedBox(height: 20),
                      Row( ///__________ CLASSIFICATION
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.panorama_fisheye_outlined, color: Colors.white, size: 13),
                              const SizedBox(width: 10),
                              CustomText().starjediWhite(txt: 'Classification'),
                            ],
                          ),
                          CustomText().starjediWhite(txt: '${watch.value?.classification}')
                        ],
                      ),
                      const Divider(thickness: 1, color: Colors.white),
                      // const SizedBox(height: 20),
                      Row( ///__________ DESINATION
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.panorama_fisheye_outlined, color: Colors.white, size: 13),
                              const SizedBox(width: 10),
                              CustomText().starjediWhite(txt: 'Designation'),
                            ],
                          ),
                          CustomText().starjediWhite(txt: '${watch.value?.designation}')
                        ],
                      ),
                      // const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.white),
                      Row( ///__________ HEIGHT
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.panorama_fisheye_outlined, color: Colors.white, size: 13),
                              const SizedBox(width: 10),
                              CustomText().starjediWhite(txt: 'Height'),
                            ],
                          ),
                          CustomText().starjediWhite(txt: '${watch.value?.averageHeight}')
                        ],
                      ),
                      // const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.white),
                      Row( ///__________ SKIN
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.panorama_fisheye_outlined, color: Colors.white, size: 13),
                              const SizedBox(width: 10),
                              CustomText().starjediWhite(txt: 'Skin'),
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: CustomText().starjediWhite(txt: '${watch.value?.skinColors}', textAlign: TextAlign.end)
                          )
                        ],
                      ),
                      // const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.white),
                      Row( ///__________ EYE
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.panorama_fisheye_outlined, color: Colors.white, size: 13),
                              const SizedBox(width: 10),
                              CustomText().starjediWhite(txt: 'Eye Colors'),
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: CustomText().starjediWhite(txt: '${watch.value?.eyeColors}', textAlign: TextAlign.end)
                          )
                        ],
                      ),
                      // const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.white),
                      Row( ///__________ LIFESPAN
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.panorama_fisheye_outlined, color: Colors.white, size: 13),
                              const SizedBox(width: 10),
                              CustomText().starjediWhite(txt: 'Lifespan'),
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: CustomText().starjediWhite(txt: '${watch.value?.averageLifespan}', textAlign: TextAlign.end)
                          )
                        ],
                      ),

                      // const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.white),
                      Row( ///__________ LEANGUAGE
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.panorama_fisheye_outlined, color: Colors.white, size: 13),
                              const SizedBox(width: 10),
                              CustomText().starjediWhite(txt: 'Leanguage'),
                            ],
                          ),
                          SizedBox(
                            width: 150,
                            child: CustomText().starjediWhite(txt: '${watch.value?.language}', textAlign: TextAlign.end)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ), 
        error: (error, stack) {
          return Container();
        }, 
        loading: () =>  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/gif/loading_3.gif', height: 130),
              const SizedBox(height: 20),
              CustomText().starjediWhite(txt: 'Loading ...')
            ],
          ),
        )
      ),
    );
  }
}