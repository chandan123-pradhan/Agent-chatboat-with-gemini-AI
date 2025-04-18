import 'package:google_generative_ai/google_generative_ai.dart';

class AIService {
  static final model = GenerativeModel(
    model: 'models/gemini-1.5-flash',
    apiKey: 'AIzaSyC5XI-g0fbPh_JLJIFVxAp_PfJYDilXR3M',
  );

  static Future<String?> askQuestion(String question) async {
    try {
      final content = [Content.text(question)];
      final response = await model.generateContent(content);
      return response.text;
    } catch (e) {
      
      return null;
    }
  }
}
