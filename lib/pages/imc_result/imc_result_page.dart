import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../../components/app_snackbar.dart';
import '../../components/components.dart';
import '../../components/imc_result_card.dart';
import '../../core/models/models.dart';

class IMCResultPage extends StatelessWidget {
  final Person person;
  final IMCResult imcResult;
  final _boundaryKey = GlobalKey();

  IMCResultPage({
    super.key,
    required this.person,
    required this.imcResult,
  });

  Future<void> _saveImage(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final render = _boundaryKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;

    if (!(await _checkStoragePermission(context))) return;

    final path = await _saveImageToGallery(render);
    final success = path != null;

    final icon = success ? Icons.check_rounded : Icons.close_rounded;
    final text = success
        ? 'Imagem salva na galeria'
        : 'Ocorreu um erro ao salvar a imagem';

    scaffoldMessenger.showSnackBar(AppSnackbar(icon: icon, text: text));
  }

  Future<Uint8List> _getResultImageBytes(RenderRepaintBoundary render) async {
    final image = await render.toImage();
    return (await image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<String?> _saveImageToGallery(RenderRepaintBoundary render) async {
    final bytes = await _getResultImageBytes(render);
    final result = await ImageGallerySaver.saveImage(bytes);
    return result['filePath']?.replaceAll('file://', '');
  }

  Future<bool> _checkStoragePermission(BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final apiVersion = androidInfo.version.sdkInt;

    // Em dispositivos com a API Version do Android >= 33
    // a permissão de Read/Write External Storage retorna sempre denied
    // por isso é necessário solicitar a permissão de Manage External Storage
    final storagePermission = apiVersion >= 33
        ? Permission.manageExternalStorage
        : Permission.storage;

    if (await storagePermission.isPermanentlyDenied) {
      scaffoldMessenger.showSnackBar(
        AppSnackbar(
          text:
              'Permissão permanentemente negada! Altere nas configurações para poder salvar imagens',
        ),
      );
      return false;
    }

    if (await storagePermission.isDenied) {
      if ((await storagePermission.request()).isDenied) {
        scaffoldMessenger.showSnackBar(AppSnackbar(text: 'Permissão negada'));
        return false;
      }
    }

    return storagePermission.isGranted;
  }

  Future<void> _shareImage() async {
    final render = _boundaryKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;

    final bytes = await _getResultImageBytes(render);

    await Share.shareXFiles(
      [
        XFile.fromData(bytes, mimeType: 'image/png'),
      ],
      text: 'Resultado do IMC',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final IMCResult(:height, :weight) = imcResult;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const IMCTitle(text: 'IMC'),
                    RepaintBoundary(
                      key: _boundaryKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            person.name ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _IMCCalculation(height: height, weight: weight),
                          IMCResultCard(imc: imcResult),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleButton.surface(
                          onPressed: _shareImage,
                          child: const Icon(Icons.share_rounded),
                        ),
                        CircleButton.surface(
                          onPressed: () => _saveImage(context),
                          child: const Icon(Icons.add_photo_alternate),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(32.0).copyWith(top: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.surface,
              foregroundColor: colors.onSurface,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Voltar'),
          ),
        ),
      ),
    );
  }
}

class _IMCCalculation extends StatelessWidget {
  final double height;
  final double weight;
  const _IMCCalculation({required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'IMC =',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(weight.toStringAsFixed(1)),
            const SizedBox(
              height: 10.0,
              width: 80.0,
              child: Divider(),
            ),
            Text('$height x $height'),
          ],
        )
      ],
    );
  }
}
