import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static Future<void> _saveHowMuchKg(String exercise, int kg) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(exercise, kg);
  }

  static Future<Map<String, int>> loadSavedKgs(List<String> exercises) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, int> savedKgs = {};
    for (String exercise in exercises) {
      savedKgs[exercise] = prefs.getInt(exercise) ?? 0;
    }
    return savedKgs;
  }

  static Widget buildKgInputAndSaveButton({
    required TextEditingController controller,
    required String exercise,
    required VoidCallback onSaved, // onSaved parametresi eklendi
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: '$exercise',
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            int kg = int.tryParse(controller.text) ?? 0;
            _saveHowMuchKg(exercise, kg);
            onSaved(); // Geri çağrı fonksiyonu çağrılıyor
          },
        ),
      ],
    );
  }
}

