import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/app_snackbar.dart';
import '../../components/components.dart';
import '../../components/imc_result_card.dart';
import '../../core/models/models.dart';
import '../../services/imc_service/imc_service.dart';
import '../../services/imc_service/imc_service_impl.dart';

class IMCResultPage extends StatelessWidget {
  final Person person;

  const IMCResultPage({super.key, required this.person});

  static Route route(Person person) {
    return MaterialPageRoute(
      builder: (_) {
        return IMCResultPage(person: person);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _IMCResultView(person: person, imcService: IMCServiceImpl());
  }
}

class _IMCResultView extends StatefulWidget {
  final Person person;
  final IMCService imcService;

  const _IMCResultView({
    required this.person,
    required this.imcService,
  });

  @override
  State<_IMCResultView> createState() => _IMCResultViewState();
}

class _IMCResultViewState extends State<_IMCResultView> {
  final _boundaryKey = GlobalKey();

  Future<void> _saveImage() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final render = _boundaryKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;

    if (await Permission.storage.isPermanentlyDenied) {
      scaffoldMessenger.showSnackBar(
        AppSnackbar(
          text:
              'Permissão permanentemente negada! Altere nas configurações para poder salvar imagens',
        ),
      );
      return;
    }

    if (await Permission.storage.isDenied) {
      if ((await Permission.storage.request()).isDenied) {
        scaffoldMessenger.showSnackBar(AppSnackbar(text: 'Permissão negada'));
        return;
      }
    }

    final path = await _saveImageToGallery(render);
    final success = path != null;

    final icon = success ? Icons.check_rounded : Icons.close_rounded;
    final text = success
        ? 'Imagem salva na galeria'
        : 'Ocorreu um erro ao salvar a imagem';

    scaffoldMessenger.showSnackBar(AppSnackbar(icon: icon, text: text));
  }

  Future<String?> _saveImageToGallery(RenderRepaintBoundary render) async {
    final image = await render.toImage();
    final bytes = (await image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
    final result = await ImageGallerySaver.saveImage(bytes);
    return result['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final imc = widget.imcService.getIMC(widget.person);

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
                            widget.person.name ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _IMCCalculation(person: widget.person),
                          IMCResultCard(imc: imc),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleButton.surface(
                          onPressed: () {},
                          child: const Icon(Icons.share_rounded),
                        ),
                        CircleButton.surface(
                          onPressed: _saveImage,
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
  final Person person;
  const _IMCCalculation({required this.person});

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
            Text(person.weight.toStringAsFixed(1)),
            const SizedBox(
              height: 10.0,
              width: 80.0,
              child: Divider(),
            ),
            Text('${person.height} x ${person.height}'),
          ],
        )
      ],
    );
  }
}
