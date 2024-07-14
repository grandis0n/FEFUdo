import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fefu_do/data/datasources/flickr_service.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<String> images;

  ImageLoaded(this.images);
}

class ImageError extends ImageState {
  final String message;

  ImageError(this.message);
}

class ImageCubit extends Cubit<ImageState> {
  final FlickrService flickrService;

  ImageCubit(this.flickrService) : super(ImageInitial());

  void fetchImages(String query, int page) async {
    emit(ImageLoading());
    try {
      final images = await flickrService.fetchImages(query, page);
      emit(ImageLoaded(images));
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }
}
