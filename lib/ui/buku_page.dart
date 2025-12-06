import 'package:flutter/material.dart';
import 'package:responsi2mobile_paket3h1d023107/bloc/logout_bloc.dart';
import 'package:responsi2mobile_paket3h1d023107/bloc/buku_bloc.dart';
import 'package:responsi2mobile_paket3h1d023107/model/buku.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/login_page.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/buku_detail.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/buku_form.dart';

class BukuPage extends StatefulWidget {
  const BukuPage({Key? key}) : super(key: key);
  @override
  _BukuPageState createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('List Buku Isma'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BukuForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: BukuBloc.getBuku(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListBuku(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListBuku extends StatelessWidget {
  final List? list;
  const ListBuku({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemBuku(buku: list![i]);
        });
  }
}

class ItemBuku extends StatelessWidget {
  final Buku buku;
  const ItemBuku({Key? key, required this.buku}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BukuDetail(buku: buku)));
      },
      child: Card(
        child: ListTile(
          title: Text(buku.judul!),
          subtitle: Text("Penulis: ${buku.penulis} | Harga: ${buku.harga}"),
        ),
      ),
    );
  }
}