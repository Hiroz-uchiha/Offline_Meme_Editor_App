import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/detail/detail_page.dart';
import 'package:meme_editor_app_offline_first_flutter_application/presentation/home/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meme Editor"),
        actions: [
          Row(
            children: [
              const Text("Offline"),
              Switch(
                  value: prov.isOffline,
                  onChanged: (val) => prov.toggleOffline(val)),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => prov.loadMemes(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: "Cari Meme...", border: OutlineInputBorder()),
                onChanged: (val) => prov.searchMemes(val),
              ),
            ),
            if (prov.isLoading)
              const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ))
            else if (prov.memes.isEmpty)
              const Expanded(
                  child: Center(
                child: Text("Tidak ada meme Ditemukan"),
              ))
            else
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6),
                    itemCount: prov.memes.length,
                    itemBuilder: (context, index) {
                      final meme = prov.memes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      DetailPage(imageUrl: meme.url)));
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: meme.url,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.broken_image)),
                            )),
                      );
                    }),
              ))
          ],
        ),
      ),
    );
  }
}
