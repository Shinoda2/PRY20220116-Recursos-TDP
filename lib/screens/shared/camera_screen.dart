import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


/* class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreen createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen>{

  late List<CameraDescription> cameras;
  late CameraController cameraController;
  late int direction =0;
  int _imageCount = 0;
  var resultadoRT = "";
  @override
  void initState(){
    startCamera(0);
    _initTensorFlow();
    super.initState();
  }

  Future<String> _objectRecognition(CameraImage cameraImage) async{
    var recognitions = await Tflite.runModelOnFrame(
      bytesList: cameraImage.planes.map((plane) {return plane.bytes;}).toList(),
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 2,
      threshold: 0.2,
    );

    var resultado = '';

    if(recognitions != null){
      if(recognitions[0]['confidence'] > 0.6){
        print(recognitions[0]['label']);
        print(recognitions[0]['confidence']);
        resultado = recognitions[0]['label'];
      }
    }
    setState(() {
      resultadoRT = resultado;
    });
    return resultado;
  }

  var resultadoFinal = '';

  void startCamera(int direction) async{
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );



    await cameraController.initialize().then((value) {
      cameraController.startImageStream((image) async{
        _imageCount++;
        if(_imageCount % 30 == 0){
          _imageCount = 0;

          resultadoFinal = await _objectRecognition(image);
        }
      });
      if(!mounted){
        return;
      }
      setState(() {});
    }).catchError((e){
      print(e);
    });
  }

  @override
  void dispose(){
    cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  Future<void> _initTensorFlow() async {
    String? res = await Tflite.loadModel(
        model: 'assets/model_unquant.tflite',
        labels: 'assets/labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false
    );
  }

  @override
  Widget build(BuildContext context) {
    if(cameraController.value.isInitialized){
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: (){
                setState(() {
                  /*direction = direction == 0 ? 1 == 0;
                  startCamera(direction);*/
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
                });
              },
              child: button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: (){
                cameraController.stopImageStream().then((value) => Navigator.pop(context, resultadoFinal));
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
            Align(
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    resultadoRT,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),)
            ),
          ],
        ),
      );
    }else{
      return SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment ){
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 10,
              ),
            ]
        ),
        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
    );
  }
} */