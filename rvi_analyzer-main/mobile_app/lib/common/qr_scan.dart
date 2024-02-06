import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanView extends StatefulWidget {
  final void Function(String) callback;
  final bool flashStatus;
  final double zoomScale;
  final double areaScale;
  const QRScanView(this.callback,
      {Key? key,
      this.areaScale = 0.2,
      this.flashStatus = false,
      this.zoomScale = 0.725})
      : super(key: key);

  @override
  State<QRScanView> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  double _sliderValue = 0.725;
  late MobileScannerController cameraController;

  @override
  void initState() {
    cameraController = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal,
        facing: CameraFacing.back,
        torchEnabled: widget.flashStatus,
        detectionTimeoutMs: 750);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Mobile Scanner'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.white);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.green);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
            Slider(
              thumbColor: Colors.white,
              value: _sliderValue,
              activeColor: Colors.black,
              inactiveColor: Colors.white,
              onChanged: (newValue) {
                cameraController.setZoomScale(newValue);
                setState(() {
                  _sliderValue = newValue;
                });
              },
              min: 0.0,
              max: 1.0,
              divisions: 10,
            ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              scanWindow: Rect.fromCenter(
                  center: Offset(screenWidth / 2, screenHeight / 2),
                  width: (screenWidth * (widget.areaScale + 0.1)),
                  height: (screenWidth * (widget.areaScale + 0.1))),
              onScannerStarted: (arguments) {
                cameraController.setZoomScale(widget.zoomScale);
              },
              fit: BoxFit.fill,
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                  widget.callback(barcode.rawValue!);
                }
                Navigator.pop(context);
              },
              overlay: Column(
                children: [
                  Expanded(
                    flex: ((10 - (10 * widget.areaScale)) ~/ 2) + 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity:
                                0.8, // Set the opacity value here (0.0 - 1.0)
                            child: Container(
                              // This is the partially transparent container
                              color: Colors.black, // or any other color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: (10 * widget.areaScale).toInt(),
                    child: Row(
                      children: [
                        Expanded(
                          flex: (10 - (10 * widget.areaScale)) ~/ 2,
                          child: Opacity(
                            opacity:
                                0.8, // Set the opacity value here (0.0 - 1.0)
                            child: Container(
                              // This is the partially transparent container
                              color: Colors.black, // or any other color
                            ),
                          ),
                        ),
                        Expanded(
                          flex: (10 * widget.areaScale).toInt() + 1,
                          child: Opacity(
                            opacity:
                                0.0, // Set the opacity value here (0.0 - 1.0)
                            child: Opacity(
                              opacity: 0.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: (10 - (10 * widget.areaScale)) ~/ 2,
                          child: Opacity(
                            opacity:
                                0.8, // Set the opacity value here (0.0 - 1.0)
                            child: Container(
                              // This is the partially transparent container
                              color: Colors.black, // or any other color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: ((10 - (10 * widget.areaScale)) ~/ 2) + 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Opacity(
                            opacity:
                                0.8, // Set the opacity value here (0.0 - 1.0)
                            child: Container(
                              // This is the partially transparent container
                              color: Colors.black, // or any other color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
