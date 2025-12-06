import 'package:flutter/material.dart';
import 'package:responsi2mobile_paket3h1d023107/bloc/buku_bloc.dart';
import 'package:responsi2mobile_paket3h1d023107/model/buku.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/buku_form.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/buku_page.dart';
import 'package:responsi2mobile_paket3h1d023107/widget/warning_dialog.dart';

class BukuDetail extends StatefulWidget {
  Buku? buku;
  BukuDetail({Key? key, this.buku}) : super(key: key);
  @override
  _BukuDetailState createState() => _BukuDetailState();
}

class _BukuDetailState extends State<BukuDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku Isma'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Judul: ${widget.buku!.judul}", style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Text("Harga: Rp ${widget.buku!.harga}"),
              Text("Jumlah: ${widget.buku!.jumlah}"),
              Text("Tgl Masuk: ${widget.buku!.tanggalMasuk}"),
              Text("Volume: ${widget.buku!.volume}"),
              Text("Penulis: ${widget.buku!.penulis}"),
              Text("Penerbit: ${widget.buku!.penerbit}"),
              const SizedBox(height: 20),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BukuForm(buku: widget.buku!),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data buku ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            BukuBloc.deleteBuku(id: widget.buku!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const BukuPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}