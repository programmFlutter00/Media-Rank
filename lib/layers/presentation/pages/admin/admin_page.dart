import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:media_rank/core/di/di.dart';
import 'package:media_rank/layers/application/anime/anime_upcoming/cubit/anime_upcoming_cubit.dart';
import 'package:media_rank/layers/domain/entities/anime_entity.dart';
import 'package:media_rank/layers/domain/mappers/anime_mapper.dart';
import 'package:media_rank/layers/presentation/pages/style/app_colors.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isUploading = false;

  /// 🔹 Barcha upcoming anime’larni olish (1–15 sahifa)
Future<List<AnimeEntity>> _getAllUpcoming({
  int startPage = 1,
  int endPage = 15,
}) async {
  final cubit = sl<AnimeUpcomingCubit>();
  List<AnimeEntity> allAnime = [];

  // Service ichidagi loop o‘zi page → end orasini aylanadi
  await cubit.getUpcoming(page: startPage, end: endPage);

  // Service qaytargan natijalarni olish
  final fetchedAnime = List<AnimeEntity>.from(cubit.state.animeList);
  allAnime.addAll(fetchedAnime);

  return allAnime;
}

Future<int?> getNewsCount() async {
  final query = FirebaseFirestore.instance.collection('news');
  final aggregateQuery = await query.count().get();
  debugPrint("Data'lar: ${aggregateQuery.count}");
  return aggregateQuery
  .count;
}

Future<void> _uploadToFirebase() async {
  setState(() => _isUploading = true);

  try {
    // Masalan: 1-sahifadan 15-sahifagacha olish
    final allAnime = await _getAllUpcoming(startPage: 1, endPage: 27);

    final batch = _firestore.batch();

    for (var anime in allAnime) {
      final firebaseEntity = anime.toFirebaseEntity();
      final docRef =
          _firestore.collection('news').doc(firebaseEntity.id.toString());
      batch.set(docRef, firebaseEntity.toJson());
    }

    await batch.commit();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ ${allAnime.length} ta ma'lumot Firebase'ga yuklandi!")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Xatolik yuz berdi: $e")),
    );
  } finally {
    setState(() => _isUploading = false);
  }
}

@override
  void initState() {
    getNewsCount();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AnimeUpcomingCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: const Text("Admin Panel"),
          backgroundColor: AppColors.primary,
        ),
        body: Center(
          child: _isUploading
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      "Ma'lumotlar yuklanmoqda...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : const Text(
                  "Tugmani bosib barcha sahifalarni Firebase'ga yuklang",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _isUploading ? null : _uploadToFirebase,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primary,
          child: _isUploading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : const Icon(Icons.cloud_upload),
        ),
      ),
    );
  }
}
