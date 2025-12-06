import 'package:flutter/material.dart';
import 'package:responsi2mobile_paket3h1d023107/bloc/buku_bloc.dart';
import 'package:responsi2mobile_paket3h1d023107/model/buku.dart';
import 'package:responsi2mobile_paket3h1d023107/ui/buku_page.dart';
import 'package:responsi2mobile_paket3h1d023107/widget/warning_dialog.dart';

class BukuForm extends StatefulWidget {
  Buku? buku;
  BukuForm({Key? key, this.buku}) : super(key: key);
  @override
  _BukuFormState createState() => _BukuFormState();
}

class _BukuFormState extends State<BukuForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judulBar = "TAMBAH BUKU ISMA"; 
  String tombolSubmit = "SIMPAN";

  final _judulCtrl = TextEditingController();
  final _hargaCtrl = TextEditingController();
  final _jumlahCtrl = TextEditingController();
  final _tglMasukCtrl = TextEditingController();
  final _volumeCtrl = TextEditingController();
  final _penulisCtrl = TextEditingController();
  final _penerbitCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.buku != null) {
      setState(() {
        judulBar = "UBAH BUKU ISMA";
        tombolSubmit = "UBAH";
        _judulCtrl.text = widget.buku!.judul!;
        _hargaCtrl.text = widget.buku!.harga.toString();
        _jumlahCtrl.text = widget.buku!.jumlah.toString();
        _tglMasukCtrl.text = widget.buku!.tanggalMasuk!;
        _volumeCtrl.text = widget.buku!.volume.toString();
        _penulisCtrl.text = widget.buku!.penulis!;
        _penerbitCtrl.text = widget.buku!.penerbit!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judulBar)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(_judulCtrl, "Judul Buku"),
                _buildTextField(_hargaCtrl, "Harga", isNumber: true),
                _buildTextField(_jumlahCtrl, "Jumlah", isNumber: true),
                _buildTextField(_tglMasukCtrl, "Tanggal Masuk (YYYY-MM-DD)"),
                _buildTextField(_volumeCtrl, "Volume", isNumber: true),
                _buildTextField(_penulisCtrl, "Penulis"),
                _buildTextField(_penerbitCtrl, "Penerbit"),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String label, {bool isNumber = false}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value!.isEmpty) {
          return "$label harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.buku != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() { _isLoading = true; });
    Buku createBuku = Buku(id: null);
    createBuku.judul = _judulCtrl.text;
    createBuku.harga = int.parse(_hargaCtrl.text);
    createBuku.jumlah = int.parse(_jumlahCtrl.text);
    createBuku.tanggalMasuk = _tglMasukCtrl.text;
    createBuku.volume = int.parse(_volumeCtrl.text);
    createBuku.penulis = _penulisCtrl.text;
    createBuku.penerbit = _penerbitCtrl.text;

    BukuBloc.addBuku(buku: createBuku).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BukuPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() { _isLoading = false; });
  }

  ubah() {
    setState(() { _isLoading = true; });
    Buku updateBuku = Buku(id: widget.buku!.id!);
    updateBuku.judul = _judulCtrl.text;
    updateBuku.harga = int.parse(_hargaCtrl.text);
    updateBuku.jumlah = int.parse(_jumlahCtrl.text);
    updateBuku.tanggalMasuk = _tglMasukCtrl.text;
    updateBuku.volume = int.parse(_volumeCtrl.text);
    updateBuku.penulis = _penulisCtrl.text;
    updateBuku.penerbit = _penerbitCtrl.text;

    BukuBloc.updateBuku(buku: updateBuku).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const BukuPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() { _isLoading = false; });
  }
}