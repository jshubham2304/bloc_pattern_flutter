class AppRepo {
  Future<void> loginIn() async {
    print('Loggging');
    await Future.delayed(Duration(seconds: 3))
        .then((value) => {print('Logging In')});
    print('LogggIn Done');
    // throw Exception('Failed');
  }
}
