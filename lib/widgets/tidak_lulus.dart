import 'package:flutter/material.dart';

class TidakLulusQuiz extends StatelessWidget {
  const TidakLulusQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF181818),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Mohon maaf, anda termasuk individu yang rawan COVID",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            ElevatedButton(onPressed: () {}, child: const Text("Lanjut"))
          ],
        ),
      ),
    );
  }
}
