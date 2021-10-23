import 'dart:io' as io;
import 'dart:typed_data' show Uint8List;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:webcontent_converter_example/services/demo.dart';
import 'package:webcontent_converter_example/services/webview_helper.dart';

class ContentToImageScreen extends StatefulWidget {
  @override
  _ContentToImageScreenState createState() => _ContentToImageScreenState();
}

class _ContentToImageScreenState extends State<ContentToImageScreen> {
  int _counter = 1;
  Uint8List _bytes;
  io.File _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Content to Image"),
        actions: [
          IconButton(
            icon: Icon(Icons.image),
            onPressed: _convert,
          ),
          IconButton(
            icon: Icon(Icons.wifi_rounded),
            onPressed: _startPrintWireless,
          ),
          IconButton(
            icon: Icon(Icons.bluetooth),
            onPressed: _startPrintBluetooth,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            // if (_file != null) Image.memory(_file.readAsBytesSync()),
            if (_bytes?.isNotEmpty == true)
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.blue,
                )),
                child: Image.memory(_bytes),
              )
          ],
        ),
      ),
    );
  }

  ///[convert html] content into bytes
  _convert() async {
    final content = _counter.isEven
        ? Demo.getShortReceiptContent()
        : Demo.getReceiptContent();
    var stopwatch = Stopwatch()..start();
    var bytes = await WebcontentConverter.contentToImage(
      content: content,
      executablePath: WebViewHelper.executablePath(),
      autoClosePage: false,
    );
    WebcontentConverter.logger
        .info("completed executed in ${stopwatch.elapsed}");
    setState(() => _counter += 1);
    if (bytes.length > 0) _saveFile(bytes);
    WebcontentConverter.logger.info(bytes);
  }

  ///[save bytes] into file
  _saveFile(Uint8List bytes) async {
    setState(() => _bytes = bytes);
    if (kIsWeb) {
      return;
    }
    var dir = await getTemporaryDirectory();
    var path = join(dir.path, "receipt.jpg");
    io.File file = io.File(path);
    await file.writeAsBytes(bytes);
    WebcontentConverter.logger.info(file.path);
    setState(() => _file = file);
  }

  _startPrintWireless() async {
    // var p = ESCPrinterService(_bytes);
    // p.startPrint();
  }

  _startPrintBluetooth() {
    // var p = ESCPrinterService(_bytes);
    // p.startBluePrint();
  }
}

List<int> sample = [
  255,
  216,
  255,
  224,
  0,
  16,
  74,
  70,
  73,
  70,
  0,
  1,
  1,
  0,
  0,
  1,
  0,
  1,
  0,
  0,
  255,
  226,
  2,
  40,
  73,
  67,
  67,
  95,
  80,
  82,
  79,
  70,
  73,
  76,
  69,
  0,
  1,
  1,
  0,
  0,
  2,
  24,
  0,
  0,
  0,
  0,
  2,
  16,
  0,
  0,
  109,
  110,
  116,
  114,
  82,
  71,
  66,
  32,
  88,
  89,
  90,
  32,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  97,
  99,
  115,
  112,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  246,
  214,
  0,
  1,
  0,
  0,
  0,
  0,
  211,
  45,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  9,
  100,
  101,
  115,
  99,
  0,
  0,
  0,
  240,
  0,
  0,
  0,
  116,
  114,
  88,
  89,
  90,
  0,
  0,
  1,
  100,
  0,
  0,
  0,
  20,
  103,
  88,
  89,
  90,
  0,
  0,
  1,
  120,
  0,
  0,
  0,
  20,
  98,
  88,
  89,
  90,
  0,
  0,
  1,
  140,
  0,
  0,
  0,
  20,
  114,
  84,
  82,
  67,
  0,
  0,
  1,
  160,
  0,
  0,
  0,
  40,
  103,
  84,
  82,
  67,
  0,
  0,
  1,
  160,
  0,
  0,
  0,
  40,
  98,
  84,
  82,
  67,
  0,
  0,
  1,
  160,
  0,
  0,
  0,
  40,
  119,
  116,
  112,
  116,
  0,
  0,
  1,
  200,
  0,
  0,
  0,
  20,
  99,
  112,
  114,
  116,
  0,
  0,
  1,
  220,
  0,
  0,
  0,
  60,
  109,
  108,
  117,
  99,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  12,
  101,
  110,
  85,
  83,
  0,
  0,
  0,
  88,
  0,
  0,
  0,
  28,
  0,
  115,
  0,
  82,
  0,
  71,
  0,
  66,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  88,
  89,
  90,
  32,
  0,
  0,
  0,
  0,
  0,
  0,
  111,
  162,
  0,
  0,
  56,
  245,
  0,
  0,
  3,
  144,
  88,
  89,
  90,
  32,
  0,
  0,
  0,
  0,
  0,
  0,
  98,
  153,
  0,
  0,
  183,
  133,
  0,
  0,
  24,
  218,
  88,
  89,
  90,
  32,
  0,
  0,
  0,
  0,
  0,
  0,
  36,
  160,
  0,
  0,
  15,
  132,
  0,
  0,
  182,
  207,
  112,
  97,
  114,
  97,
  0,
  0,
  0,
  0,
  0,
  4,
  0,
  0,
  0,
  2,
  102,
  102,
  0,
  0,
  242,
  167,
  0,
  0,
  13,
  89,
  0,
  0,
  19,
  208,
  0,
  0,
  10,
  91,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  88,
  89,
  90,
  32,
  0,
  0,
  0,
  0,
  0,
  0,
  246,
  214,
  0,
  1,
  0,
  0,
  0,
  0,
  211,
  45,
  109,
  108,
  117,
  99,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  12,
  101,
  110,
  85,
  83,
  0,
  0,
  0,
  32,
  0,
  0,
  0,
  28,
  0,
  71,
  0,
  111,
  0,
  111,
  0,
  103,
  0,
  108,
  0,
  101,
  0,
  32,
  0,
  73,
  0,
  110,
  0,
  99,
  0,
  46,
  0,
  32,
  0,
  50,
  0,
  48,
  0,
  49,
  0,
  54,
  255,
  219,
  0,
  67,
  0,
  6,
  4,
  5,
  6,
  5,
  4,
  6,
  6,
  5,
  6,
  7,
  7,
  6,
  8,
  10,
  16,
  10,
  10,
  9,
  9,
  10,
  20,
  14,
  15,
  12,
  16,
  23,
  20,
  24,
  24,
  23,
  20,
  22,
  22,
  26,
  29,
  37,
  31,
  26,
  27,
  35,
  28,
  22,
  22,
  32,
  44,
  32,
  35,
  38,
  39,
  41,
  42,
  41,
  25,
  31,
  45,
  48,
  45,
  40,
  48,
  37,
  40,
  41,
  40,
  255,
  219,
  0,
  67,
  1,
  7,
  7,
  7,
  10,
  8,
  10,
  19,
  10,
  10,
  19,
  40,
  26,
  22,
  26,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  40,
  255,
  192,
  0,
  17,
  8,
  0,
  200,
  0,
  100,
  3,
  1,
  34,
  0,
  2,
  17,
  1,
  3,
  17,
  1,
  255,
  196,
  0,
  21,
  0,
  1,
  1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  8,
  255,
  196,
  0,
  20,
  16,
  1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  255,
  196,
  0,
  20,
  1,
  1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  255,
  196,
  0,
  20,
  17,
  1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  255,
  218,
  0,
  12,
  3,
  1,
  0,
  2,
  17,
  3,
  17,
  0,
  63,
  0,
  149,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  7,
  255,
  217
];
