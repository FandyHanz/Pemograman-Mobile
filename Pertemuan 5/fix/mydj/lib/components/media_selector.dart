import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mydj/components/video_preview.dart';

enum MediaType { photo, video }

class MediaSelector extends StatefulWidget {
  final MediaType mediaType;
  const MediaSelector({super.key, this.mediaType = MediaType.photo});

  @override
  State<StatefulWidget> createState() {
    return _MediaSelectorState();
  }
}

class _MediaSelectorState extends State<MediaSelector> {
  String _mediaPath = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _mediaPlaceholder(),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                color: Colors.blue[50],
                child: Row(
                  children: [
                    Expanded(
                        child: FilledButton(
                            onPressed: () {
                              _selectFromCamera();
                            },
                            child: Icon(Icons.photo_camera))),
                    SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        child: Icon(Icons.photo_library),
                        onPressed: () {
                          _selectFromGallery();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: FilledButton(
                            onPressed: () {
                              _deleteSelected();
                            },
                            child: Icon(Icons.delete)))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _mediaPlaceholder() {
    Icon icon;
    String caption = '';
    Widget placeholderWidget;
// Cek jenis medianya apakah foto atau video
    if (widget.mediaType == MediaType.photo) {
      icon = Icon(Icons.image_not_supported, color: Colors.grey);
      caption = 'No photo';
      placeholderWidget = Image.file(
        File(_mediaPath),
        width: double.infinity, // <-- Isi penuh parent
        fit: BoxFit.fitWidth, // <-- Tinggi otomatis sesuai rasio
      );
    } else {
      icon = Icon(Icons.videocam_off, color: Colors.grey);
      caption = 'No video';
      placeholderWidget = VideoPreview(path: _mediaPath);
    }
// Jika path kosong, tampilkan "No Photo/Video".
    if (_mediaPath.isEmpty) {
      return SizedBox(
        height: 56, // <-- Tinggi default TextField
        child: Row(
          children: [icon, SizedBox(width: 8), Text(caption)],
        ),
      );
    }
// Jika path ada isinya, tampilkan medianya.
    else {
      return SizedBox(width: double.infinity, child: placeholderWidget);
    }
  }

  Future<XFile?> _retrieveMedia(ImageSource source) async {
    final picker = ImagePicker();
    XFile? media;
    if (widget.mediaType == MediaType.photo) {
      media = await picker.pickImage(source: source);
    } else {
      media = await picker.pickVideo(source: source);
    }
    return media;
  }

  void _selectFromCamera() async {
    XFile? media = await _retrieveMedia(ImageSource.camera);
    if (media != null) {
      setState(() {
        _mediaPath = media.path;
      });
    }
  }

// Memilih media dari galeri.
  void _selectFromGallery() async {
    XFile? media = await _retrieveMedia(ImageSource.gallery);
    if (media != null) {
      setState(() {
        _mediaPath = media.path;
      });
    }
  }

  void _deleteSelected() {
    setState(() {
      _mediaPath = '';
    });
  }
}
