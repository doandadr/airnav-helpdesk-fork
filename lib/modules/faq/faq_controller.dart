import 'package:get/get.dart';

class FaqController extends GetxController {
  final RxList<FaqItem> faqItems = [
    FaqItem(
      question: 'Bagaimana cara membuat tiket baru?',
      answer:
          'Anda dapat membuat tiket baru dengan menekan tombol "Buat Tiket" di halaman utama, kemudian mengisi semua form yang diperlukan.',
    ),
    FaqItem(
      question: 'Di mana saya bisa melihat status tiket saya?',
      answer:
          'Semua tiket yang pernah Anda buat akan tampil di halaman utama. Status setiap tiket akan terlihat jelas di masing-masing kartu tiket.',
    ),
    FaqItem(
      question: 'Bagaimana cara mengubah prioritas tiket?',
      answer:
          'Setelah tiket dibuat, prioritas tidak dapat diubah. Pastikan Anda memilih prioritas yang sesuai saat membuat tiket.',
    ),
    FaqItem(
      question: 'Apa saja kategori yang tersedia?',
      answer:
          'Kategori yang tersedia mencakup Jaringan, Perangkat Keras, Perangkat Lunak, dan lain-lain. Anda bisa melihat daftar lengkapnya di dropdown kategori pada halaman pembuatan tiket.',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi, set semua panel tertutup
    for (var item in faqItems) {
      item.isExpanded = false;
    }
  }

  void togglePanel(int index) {
    faqItems[index].isExpanded = !faqItems[index].isExpanded;
    faqItems.refresh(); // Memaksa UI untuk update
  }
}

class FaqItem {
  final String question;
  final String answer;
  bool isExpanded;

  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}
