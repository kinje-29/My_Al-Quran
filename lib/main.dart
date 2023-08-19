import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'repository.dart';
import 'detail.dart';
import 'model.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ujian Akhir Semester',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Al-Quran Indonesia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Blog> lisBlog = [];
  List<Blog> filteredList = [];
  Repository repository = Repository();
  TextEditingController searchController = TextEditingController();

  Future<void> getData() async {
    lisBlog = await repository.getData();
    setState(() {
      filteredList = lisBlog;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void searchBlogs(String keyword) {
    setState(() {
      try {
        if (keyword.isEmpty) {
          filteredList = lisBlog;
        } else {
          filteredList = lisBlog
              .where((blog) =>
                  blog.nama.toLowerCase().contains(keyword.toLowerCase()) ||
                  blog.arti.toLowerCase().contains(keyword.toLowerCase()))
              .toList();
        }
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: darkBlue,
      appBar: AppBar(
        backgroundColor: Color(0xff696969),
        title: Text('AL-Quran Indonesia'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Tindakan yang dijalankan saat ikon ditekan
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: searchBlogs,
              decoration: InputDecoration(
                labelText: 'Search',
                icon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final blog = filteredList[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.chrome_reader_mode_rounded,
                            color: Color.fromARGB(255, 243, 243, 243),
                            size: 50,
                          ),
                          title: Text(
                            blog.nama,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            blog.arti,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => Detail(
                                  arti: blog.arti,
                                  asma: blog.asma,
                                  audio: blog.audio,
                                  keterangan: blog.keterangan,
                                  nama: blog.nama,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: filteredList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
