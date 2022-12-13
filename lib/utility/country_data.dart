class CountryData {
  late String phoneCode;
  late String name;
  late String image;

  CountryData(this.phoneCode, this.name, this.image);

  static List<CountryData> getCounties() {
    return <CountryData>[
      CountryData("+90", 'Turkey', 'assets/images/svg/turkey.svg'),
    ];
  }
}
