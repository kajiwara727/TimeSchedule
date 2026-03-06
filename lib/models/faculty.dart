enum FacultyType {
  // --- 学部 ---
  law('法学部', '11'),
  economics('経済学部', '12'),
  business('経営学部', '13'),
  socialSciences('産業社会学部', '14'),
  internationalRelations('国際関係学部', '15'),
  policyScience('政策科学部', '16'),
  letters('文学部', '17'),
  designArt('デザイン・アート学部', '18'),
  imageArts('映像学部', '19'),
  psychology('総合心理学部', '20'),
  scienceEngineering('理工学部', '21'),
  globalLiberalArts('グローバル教養学部', '24'),
  gastronomy('食マネジメント学部', '25'),
  informationScience('情報理工学部', '26'),
  lifeSciences('生命科学部', '27'),
  pharmaceuticalSciences('薬学部', '28'),
  sportHealth('スポーツ健康科学部', '29'),

  // --- 研究科 ---
  lawGraduate('法学研究科', '31'),
  economicsGraduate('経済学研究科', '32'),
  businessGraduate('経営学研究科', '33'),
  socialSciencesGraduate('社会学研究科', '34'),
  internationalRelationsGraduate('国際関係研究科', '35'),
  policyScienceGraduate('政策科学研究科', '36'),
  lettersGraduate('文学研究科', '37'),
  designArtGraduate('デザイン・アート学研究科', '38'),
  appliedHumanSciencesGraduate('応用人間科学研究科', '39'),
  scienceEngineeringGraduate('理工学研究科', '41'),
  advancedInterdisciplinaryGraduate('先端総合学術研究科', '42'),
  languageEducationGraduate('言語教育情報研究科', '43'),
  lawSchool('法務研究科', '45'),
  technologyManagementGraduate('テクノロジー・マネジメント研究科', '46'),
  businessAdministrationGraduate('経営管理研究科', '47'),
  publicPolicyGraduate('公務研究科', '48'),
  sportHealthGraduate('スポーツ健康科学研究科', '49'),
  imageArtsGraduate('映像研究科', '50'),
  informationScienceGraduate('情報理工学研究科', '54'),
  lifeSciencesGraduate('生命科学研究科', '55'),
  pharmaceuticalSciencesGraduate('薬学研究科', '56'),
  teachingProfessionalGraduate('教職研究科', '57'),
  humanSciencesGraduate('人間科学研究科', '58'),
  gastronomyGraduate('食マネジメント研究科', '59');

  final String displayName;
  final String code;

  const FacultyType(this.displayName, this.code);

  static String nameToCode(String name) {
    return FacultyType.values
        .firstWhere((e) => e.displayName == name, orElse: () => FacultyType.law)
        .code;
  }
}