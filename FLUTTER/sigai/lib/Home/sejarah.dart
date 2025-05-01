import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  String appLanguage = 'ms';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      appLanguage = prefs.getString('appLanguage') ?? 'ms';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMalay = appLanguage == 'ms';

    return Scaffold(
      appBar: AppBar(
        title: Text(isMalay ? 'Sejarah' : 'History'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMalay ? 'Sifir Garis Itamta (SIGAI)' : 'Itamta Line Multiplication (SIGAI)',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              isMalay ? _sejarahMs : _sejarahEn,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

const String _sejarahMs = '''
DIPAKSA menghafal sifir - bagi murid lemah dan membenci matematik - ialah mimpi ngeri, khususnya dalam kalangan murid-murid Melayu di sekolah kebangsaan (SK). Bagi guru matematik pula, mereka sering sakit kepala kerana tiada kaedah atau alat menghafal yang mudah supaya murid berupaya mengingat dan berjinak-jinak dengan sifir kerana sifir ialah ibu segala matematik.

Pelbagai inovasi dalam pengajaran dan pembelajaran matematik pernah ditemui dan telah dikomersialkan, tetapi tidak sehingga diterima sebagai teks sekolah kerana beberapa kekurangan dalam kesesuaian dari segi teori, falsafah dan amalan. Namun begitu, kaedah yang diberi nama Sifir Garis Itamta (Sigai) hasil inovasi Guru Besar SK Kati di Kuala Kangsar, Itamta Harun, memang wajar dipertimbangkan oleh Pusat Perkembangan Kurikulum (PPK) sebagai teks di sekolah Malaysia.

Uniknya, Sigai ialah murid tidak perlu lagi menghafal sifir. Selain itu, kaedah itu dicipta untuk mengatasi masalah murid yang tidak menguasai fakta asas darab dan bahagi - khususnya murid pemulihan khas dan pendidikan khas yang menghadapi masalah pembelajaran Linus (Literasi dan Numerasi) Matematik.

“Objektif Sigai ialah pelajar tidak perlu menghafal sifir,” kata Itamta. Potensi Sigai cukup besar ekoran testimoninya yang pernah memenangi anugerah di dalam dan luar negara, dan khabarnya sudah ada usaha untuk menyesuaikan dan mengeksploitasi penemuan itu dalam kalangan pengamal matematik di sekolah-sekolah di Kanada.

Itamta mengesyaki terdapat usaha untuk menciplak Sigai di Taiwan, tetapi dengan sedikit pengubahsuaian - mujurlah belum ada usaha memplagiat Sigai setakat ini. Penemuan itu belum dipatenkan kerana kos berbuat demikian agak mahal, kata Itamta. Kini, kaedah itu boleh dicapai di laman Wikipedia, dengan menaip Sigai pada enjin pencarian.

Wartawan Utusan Malaysia ketika ditunjuk ajar tentang kaedah itu oleh Itamta sendiri, mendapati pendekatan Sigai amat mudah difahami, mempunyai elemen matematik minda, ciri-ciri sempoa, serta boleh dilakukan dengan sokongan alat bantu mengajar maujud yang berciri fizikal, boleh dipegang dan dimanipulasi.

Kata Itamta, konsep asas Sigai ialah penggunaan garis menegak dan melintang, iaitu nombor pertama diwakili garis menegak, nombor kedua oleh garis melintang dan jawapan diwakili titik pertemuan garis menegak dan melintang.

“Murid lemah dalam program Linus, murid Orang Asli, murid di pedalaman atau yang bermasalah pembelajaran perlu dicuba dengan Sigai,” katanya.

Kaedah Sigai melibatkan pengiraan menggunakan garisan menegak dan melintang bagi mendapatkan jawapan dalam operasi darab atau bahagi tanpa perlu menghafal sifir 2 hingga 9.

Sigai untuk murid sekolah rendah dan perlu menguasai Sigai Fasa 1, Sigai Fasa 2 dan Sigai Fasa 3. Fasa 1 melibatkan kiraan 1 digit darab atau bahagi dengan 1 digit, Fasa 2 melibatkan 2 digit dan Fasa 3 melibatkan 3 digit.

Kaedah Sigai ditemui semasa beliau menyampaikan ceramah Matematik di SK Jalong, Sg. Siput Utara dalam Program Gerak Gempur Matematik anjuran Pejabat Pelajaran Daerah Kuala Kangsar, Perak.

“Seorang guru wanita di sekolah tersebut mencabar saya supaya memperkenalkan kaedah penguasaan sifir tanpa perlu menghafal atau mengingat sifir dua hingga sembilan,” katanya.

Pada sebelah malamnya, Itamta melakar dan mencuba beberapa kali dengan melakar garisan menegak dan melintang Fasa 1, “maka terciptalah Sifir Garis Itamta atau singkatannya Sigai,” katanya.

Semasa itu beliau bertugas sebagai Guru Besar SK Sg. Siput pada 1993 hingga 1997. Fasa 2 dan pengenalan konsep Sigai kepada digit sifar ditemui semasa beliau menyampaikan ceramah di Pusat Kegiatan Guru Manong, apabila seorang guru lelaki meminta penjelasan bagaimana kaedah Sigai yang melibatkan digit sifar (kosong).

“Saya pun tidak terfikir isu yang dikemukakan oleh guru berkenaan,” katanya. Semasa itu beliau bertugas sebagai Guru Besar SK Manong (1998-2000) dan Pengerusi Panitia Matematik Daerah Kuala Kangsar.

Kata Itamta, pada 2001 terciptalah sepenuhnya kaedah Sigai yang melibatkan Fasa 3 dan operasi bahagi. Pada tahun yang sama beliau menyertai Pertandingan Anugerah Gemilang Akademik anjuran Jabatan Pelajaran Negeri Perak dan menerima Anugerah Penghargaan sempena Hari Guru Negeri Perak.
''';

const String _sejarahEn = '''
Being forced to memorize multiplication tables is a nightmare for students who struggle with math and dislike the subject, especially among Malay students in national schools.

For math teachers, it is often frustrating because there is no simple method or tool to help students remember and become familiar with multiplication tables, which are the foundation of mathematics.

Various innovations in math teaching and learning have been discovered and commercialized, but none have been formally accepted as school textbooks due to limitations in theory, philosophy, and practical application.

However, the Sifir Garis Itamta (Sigai) method, an innovation by SK Kati’s headmaster, Itamta Harun, in Kuala Kangsar, deserves consideration by the Curriculum Development Center (PPK) as an official teaching method in Malaysian schools.

What makes Sigai unique is that students no longer need to memorize multiplication tables. The method was specifically designed to help students struggling with fundamental multiplication and division concepts—particularly remedial students, special education learners, and those facing literacy and numeracy (Linus) challenges in mathematics.

“The objective of Sigai is to eliminate the need for students to memorize multiplication tables,” said Itamta.

The potential of Sigai is enormous, as it has won awards both locally and internationally. There are even reports of efforts to adapt and apply the method in Canadian schools.

Itamta suspects that there have been attempts to copy Sigai in Taiwan, with slight modifications. However, so far, no direct plagiarism has been reported.

Despite its effectiveness, Sigai has not yet been patented due to high costs, said Itamta. The method can now be found on Wikipedia by searching for “Sigai.”

When a Utusan Malaysia journalist was personally introduced to the Sigai method by Itamta, they found it extremely easy to understand, incorporating mental math elements and features similar to abacus calculations. The method can also be demonstrated using tangible teaching aids, which are hands-on and manipulatable.

According to Itamta, the core concept of Sigai is the use of vertical and horizontal lines:
    •    The first number is represented by vertical lines.
    •    The second number is represented by horizontal lines.
    •    The answer is determined by counting the intersection points of these lines.

“Students who struggle with the Linus program, Orang Asli students, those in rural areas, or those with learning difficulties should try Sigai,” he suggested.

How Sigai Works

Sigai calculates multiplication and division using a grid of intersecting vertical and horizontal lines, eliminating the need to memorize multiplication tables from 2 to 9.

Sigai is designed for elementary school students and is divided into three phases:
    •    Phase 1: Single-digit multiplication and division (e.g., 3 × 4 or 8 ÷ 2).
    •    Phase 2: Two-digit calculations (e.g., 23 × 5 or 36 ÷ 6).
    •    Phase 3: Three-digit calculations and advanced division techniques.

The Discovery of Sigai

The Sigai method was discovered when Itamta was giving a math workshop at SK Jalong, Sungai Siput Utara during a Gerak Gempur Mathematics program organized by the Kuala Kangsar District Education Office.

“A female teacher at the school challenged me to introduce a method for learning multiplication without memorizing tables from 2 to 9,” Itamta recalled.

That night, he experimented by drawing vertical and horizontal lines, and thus, the Sifir Garis Itamta (Sigai) method was born.

At that time, Itamta was the headmaster of SK Sungai Siput (1993-1997).

Expanding the Sigai Concept

Phase 2 of Sigai and how to handle multiplication with the digit zero was developed when a male teacher at Pusat Kegiatan Guru Manong asked Itamta how Sigai could accommodate numbers containing zero.

“I had never considered that issue before,” he admitted.

At that time, Itamta was serving as Headmaster of SK Manong (1998-2000) and was also the Chairman of the Mathematics Panel for Kuala Kangsar District.

By 2001, the complete Sigai method had been finalized, including Phase 3 and division operations.

That same year, Itamta participated in the Academic Excellence Award competition organized by the Perak State Education Department and received a Special Recognition Award during the Perak State Teacher’s Day celebration.
''';
