import 'package:get/get.dart';

class FaqController extends GetxController {
  final RxString selectedCategory = 'IT'.obs;
  
  final List<String> categories = [
    'IT',
    'SDM',
    'Legal',
    'Keamanan',
    'Keuangan',
    'Humas',
  ];

  final RxList<FaqItem> allFaqItems = [
    // IT
    FaqItem(
      question: 'Bagaimana cara mengajukan permintaan perbaikan perangkat?',
      answer:
          'Anda dapat mengajukan permintaan perbaikan perangkat melalui aplikasi dengan memilih kategori IT, kemudian mengisi detail permasalahan yang Anda alami. Tim IT akan segera menindaklanjuti permintaan Anda dalam waktu 1x24 jam.',
      category: 'IT',
    ),
    FaqItem(
      question: 'Apa saja kategori masalah IT yang bisa diajukan?',
      answer:
          'Kategori masalah IT meliputi: Jaringan & Internet, Perangkat Keras (Hardware), Perangkat Lunak (Software), Email & Akun, dan Akses Sistem. Silakan pilih kategori yang sesuai dengan permasalahan Anda.',
      category: 'IT',
    ),
    FaqItem(
      question: 'Berapa lama waktu respon dari tim IT?',
      answer:
          'Untuk permintaan dengan prioritas tinggi, tim IT akan merespon dalam waktu 2-4 jam. Untuk prioritas normal, respon akan diberikan dalam waktu 1x24 jam kerja.',
      category: 'IT',
    ),
    FaqItem(
      question: 'Bagaimana cara melacak status tiket IT saya?',
      answer:
          'Anda dapat melacak status tiket IT melalui halaman utama aplikasi. Setiap tiket akan menampilkan status terkini seperti: Pending, Dalam Proses, atau Selesai. Anda juga akan menerima notifikasi saat ada update.',
      category: 'IT',
    ),
    
    // SDM
    FaqItem(
      question: 'Bagaimana cara mengajukan cuti?',
      answer:
          'Untuk mengajukan cuti, buka aplikasi dan pilih kategori SDM, lalu pilih jenis permohonan "Cuti". Isi formulir dengan lengkap termasuk tanggal mulai dan berakhirnya cuti, serta alasan cuti. Permohonan akan diproses oleh atasan dan tim SDM.',
      category: 'SDM',
    ),
    FaqItem(
      question: 'Berapa lama proses persetujuan cuti?',
      answer:
          'Proses persetujuan cuti biasanya memakan waktu 2-3 hari kerja. Anda akan menerima notifikasi melalui aplikasi dan email setelah permohonan Anda disetujui atau ditolak.',
      category: 'SDM',
    ),
    FaqItem(
      question: 'Apa saja dokumen yang diperlukan untuk klaim reimbursement?',
      answer:
          'Untuk klaim reimbursement, Anda perlu melampirkan: Bukti pembayaran asli (kuitansi/invoice), Formulir klaim yang sudah diisi, dan Bukti pendukung lainnya sesuai kebijakan perusahaan. Pastikan semua dokumen lengkap agar proses lebih cepat.',
      category: 'SDM',
    ),
    
    // Legal
    FaqItem(
      question: 'Bagaimana cara mengajukan konsultasi legal?',
      answer:
          'Untuk konsultasi legal, pilih kategori Legal di aplikasi, kemudian jelaskan permasalahan atau pertanyaan legal Anda secara detail. Tim legal akan menghubungi Anda untuk jadwal konsultasi dalam waktu 2x24 jam.',
      category: 'Legal',
    ),
    FaqItem(
      question: 'Apa saja layanan yang disediakan oleh tim legal?',
      answer:
          'Tim legal menyediakan layanan konsultasi kontrak, review dokumen legal, penanganan sengketa, perizinan, dan compliance. Semua layanan dapat diakses melalui sistem ticketing ini.',
      category: 'Legal',
    ),
    FaqItem(
      question: 'Apakah konsultasi legal bersifat rahasia?',
      answer:
          'Ya, semua konsultasi dan komunikasi dengan tim legal bersifat rahasia dan dijaga kerahasiaannya sesuai dengan kode etik profesi dan kebijakan perusahaan.',
      category: 'Legal',
    ),
    
    // Keamanan
    FaqItem(
      question: 'Bagaimana cara melaporkan insiden keamanan?',
      answer:
          'Untuk melaporkan insiden keamanan, segera buat tiket dengan kategori Keamanan dan pilih prioritas Tinggi. Jelaskan detail insiden yang terjadi, lokasi, dan waktu kejadian. Tim keamanan akan segera merespon.',
      category: 'Keamanan',
    ),
    FaqItem(
      question: 'Apa yang harus dilakukan jika kehilangan kartu akses?',
      answer:
          'Jika kehilangan kartu akses, segera laporkan melalui aplikasi dengan kategori Keamanan. Kartu lama akan dinonaktifkan dan Anda akan diberikan kartu pengganti. Proses penggantian memakan waktu 1-2 hari kerja.',
      category: 'Keamanan',
    ),
    FaqItem(
      question: 'Bagaimana prosedur visitor/tamu ke kantor?',
      answer:
          'Untuk mengajukan izin tamu, buat permintaan melalui aplikasi minimal 1 hari sebelumnya. Sertakan informasi lengkap tamu termasuk nama, NIK, instansi, dan keperluan. Tamu akan mendapatkan visitor pass saat check-in.',
      category: 'Keamanan',
    ),

    // Keuangan
    FaqItem(
      question: 'Bagaimana cara mengajukan reimburse?',
      answer:
          'Untuk mengajukan reimburse, pilih kategori Keuangan, upload bukti pembayaran yang valid, isi nominal dan keterangan dengan jelas. Proses verifikasi akan dilakukan oleh tim finance dalam 3-5 hari kerja.',
      category: 'Keuangan',
    ),
    FaqItem(
      question: 'Kapan dana reimburse akan cair?',
      answer:
          'Setelah reimburse disetujui, dana akan ditransfer ke rekening Anda pada periode pencairan berikutnya, biasanya setiap tanggal 25 setiap bulan. Anda akan menerima notifikasi setelah transfer berhasil.',
      category: 'Keuangan',
    ),
    FaqItem(
      question: 'Apa saja yang bisa di-reimburse?',
      answer:
          'Yang dapat di-reimburse meliputi: Biaya perjalanan dinas, Transportasi operasional, Konsumsi rapat/meeting, Pembelian supplies kantor, dan biaya lain yang telah disetujui sesuai kebijakan perusahaan.',
      category: 'Keuangan',
    ),

    // Humas
    FaqItem(
      question: 'Bagaimana cara mengajukan publikasi/press release?',
      answer:
          'Untuk mengajukan publikasi atau press release, pilih kategori Humas dan sertakan draft konten yang ingin dipublikasikan. Tim Humas akan melakukan review dan koordinasi dengan pihak terkait sebelum publikasi dilakukan.',
      category: 'Humas',
    ),
    FaqItem(
      question: 'Bagaimana prosedur peminjaman ruang meeting?',
      answer:
          'Peminjaman ruang meeting dapat dilakukan melalui aplikasi dengan memilih kategori Humas. Tentukan tanggal, waktu, dan ruangan yang diinginkan. Konfirmasi akan diberikan setelah pengecekan ketersediaan ruangan.',
      category: 'Humas',
    ),
    FaqItem(
      question: 'Apa saja layanan yang disediakan tim Humas?',
      answer:
          'Tim Humas menyediakan layanan: Koordinasi event internal, Publikasi & komunikasi korporat, Peminjaman fasilitas, Pembuatan materi promosi, dan Hubungan media. Semua layanan dapat diakses melalui sistem ini.',
      category: 'Humas',
    ),
  ].obs;

  List<FaqItem> get filteredItems {
    return faqItems.where((item) {
      final matchesSearch =
          item.question.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          item.answer.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesCategory =
          selectedCategory.value == 'All' ||
          item.category == selectedCategory.value;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onInit() {
    super.onInit();
    for (var item in allFaqItems) {
      item.isExpanded = false;
    }
  }

  List<FaqItem> get filteredFaqItems {
    return allFaqItems.where((item) => item.category == selectedCategory.value).toList();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    // Tutup semua panel saat ganti kategori
    for (var item in allFaqItems) {
      item.isExpanded = false;
    }
  }

  void togglePanel(int index) {
    final filtered = filteredFaqItems;
    if (index < filtered.length) {
      filtered[index].isExpanded = !filtered[index].isExpanded;
      allFaqItems.refresh();
    }
  }
}

class FaqItem {
  final String question;
  final String answer;
  final String category;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    required this.category,
    this.isExpanded = false,
  });
}