import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseApiUrl = dotenv.get('BASE_API_URL');

final String imageUploadUrl = dotenv.get('IMAGE_UPLOAD_SERVICE_URL');
