import 'dart:convert';

import 'package:picture_perfect/data/data%20provider/picture_data_provider.dart';
import 'package:picture_perfect/models/picture_model.dart';

class PictureRepository {
  final PictureDataProvider pictureDataProvider;

  PictureRepository(this.pictureDataProvider);

  Future<PictureModel> getPictureDetails() async {
    try {
      final pictureData = await pictureDataProvider.getPicturePlayingDetails();

      final pData = jsonDecode(pictureData.toString());
      if (pData['cod'] != '200') {
        throw Exception( 'A craxy error occured.');
      }

    return PictureModel.fromMap(pData);
    } catch (e) {
      throw e.toString();
    }
  }
}
