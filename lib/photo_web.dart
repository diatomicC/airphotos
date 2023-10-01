import 'dart:html' as html;

class PhotoWebHelper {
  void addPhotoWeb(Function(String) onImageSelected) {
    final html.FileUploadInputElement input = html.FileUploadInputElement()
      ..accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onImageSelected(reader.result as String);
      });
    });
  }
}
