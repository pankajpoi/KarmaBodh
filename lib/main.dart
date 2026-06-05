import 'package:flutter/material.dart';

import 'package:karmbodh/features/mantras/data/data_source/Mantra_data_source.dart';
import 'package:karmbodh/features/mantras/data/repository/mantra_repo_imple.dart';
import 'package:karmbodh/features/mantras/domain/usecase/mantra_usecase.dart';
import 'package:karmbodh/features/mantras/presentation/provider/mantra_provider.dart';
import 'package:karmbodh/features/ritual_guide/data/data_source/ritualguide_datasource.dart';
import 'package:karmbodh/features/ritual_guide/data/repository/ritualguide_repoimp.dart';
import 'package:karmbodh/features/ritual_guide/domain/usecase/ritualguide_usecase.dart';
import 'package:karmbodh/features/ritual_guide/presentation/provider/Ritualguide_provider.dart';
import 'package:karmbodh/shared/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>MantraProvider(
        getAllMantras:GetAllMantras
          (repository: MantraRepositoryImpl
          (localDataSource: MantraLocalDataSourceImpl()),
        ),
      searchMantras: SearchMantras
        (repository: MantraRepositoryImpl
        (localDataSource: MantraLocalDataSourceImpl()))
    ),
    ),
      ChangeNotifierProvider(create: (_)=>RitualguideProvider(getanswer: GetAnswer(repository: RitualguideRepositoryImpl(ragapiservice: RagApiService()))))
  ],
      child: MyApp(),
    )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Ritual app",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.green
        )

      ),
      home: MainScreen(),
    );
  }
}

