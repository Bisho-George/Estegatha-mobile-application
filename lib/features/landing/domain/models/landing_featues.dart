class Features{
  static List<String> _features = [
    'Share your location with your organization in real time',
    'Check the safety of the areas before visiting',
    'Make sure your health matrices well',
    'Notify your relative about any problem occur to you',
    'You will get help from the nearest suitable person',
  ];
  static String feature(index) => _features[index];
  static int get length => _features.length;
}