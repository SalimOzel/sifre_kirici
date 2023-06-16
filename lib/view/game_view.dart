import 'package:flutter/material.dart';

import '../util/screen_size.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  // dial angle in radians
  double _finalAngle = 0.0;
  double _oldAngle = 0.0;
  double _upsetAngle = 0.0;

  final TextEditingController _firstQuestionController =
          TextEditingController(),
      _secondQuestionController = TextEditingController(),
      _thirdQuestionController = TextEditingController(),
      _fourthQuestionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // open game info dialog when the app starts
    WidgetsBinding.instance.addPostFrameCallback((_) => _gameInfoDialog());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Şifre Kırıcı'),
        centerTitle: true,
        actions: [_resetButton()],
        leading: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () => _gameInfoDialog(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Icon(
              Icons.arrow_drop_down,
              size: ScreenSize.width(10, context),
            ),
            _dialWidget(),
            SizedBox(height: ScreenSize.height(5, context)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width(3, context)),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _customQuestionText(
                              'Kadranı saat yönünde %10 çeviriniz'),
                          SizedBox(
                              height: ScreenSize.height(5, context),
                              width: ScreenSize.width(20, context),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                controller: _firstQuestionController,
                                validator: (value) {
                                  if (value == "90") {
                                    return null;
                                  }
                                  return 'Yanlış';
                                },
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _customQuestionText(
                              'Sonra,kadranı ters yönde %20\nçeviriniz'),
                          SizedBox(
                              height: ScreenSize.height(5, context),
                              width: ScreenSize.width(20, context),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _secondQuestionController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == "10") {
                                    return null;
                                  }
                                  return 'Yanlış';
                                },
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _customQuestionText(
                              'Sonra, kadranı saat yönünde %40\nçeviriniz'),
                          SizedBox(
                              height: ScreenSize.height(5, context),
                              width: ScreenSize.width(20, context),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _thirdQuestionController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == "70") {
                                    return null;
                                  }
                                  return 'Yanlış';
                                },
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _customQuestionText(
                              'Son olarak, kadranı ters yönde %60\nçeviriniz'),
                          SizedBox(
                              height: ScreenSize.height(5, context),
                              width: ScreenSize.width(20, context),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _fourthQuestionController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value == "30") {
                                    return null;
                                  }
                                  return 'Yanlış';
                                },
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenSize.height(5, context)),
                    TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      backgroundColor: Colors.blueGrey[100],
                                      title: const Text('Tebrikler'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size:
                                                ScreenSize.height(10, context),
                                          ),
                                          SizedBox(
                                            height:
                                                ScreenSize.height(5, context),
                                          ),
                                          const Text(
                                              'Tüm soruları doğru cevapladınız'),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Tamam'))
                                      ],
                                    ));
                          }
                        },
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(
                                ScreenSize.width(100, context),
                                ScreenSize.height(5, context))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: const Text('Kontrol Et'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resetButton() {
    return IconButton(
      icon: const Icon(Icons.restart_alt),
      onPressed: () {
        // reset dial angle
        setState(() {
          _finalAngle = 0.0;
          _oldAngle = 0.0;
          _upsetAngle = 0.0;
        });

        // reset text fields
        _firstQuestionController.clear();
        _secondQuestionController.clear();
        _thirdQuestionController.clear();
        _fourthQuestionController.clear();

        _formKey.currentState!.reset();
      },
    );
  }

  Widget _customQuestionText(String text) {
    return Text(text,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: ScreenSize.width(3.5, context),
          fontWeight: FontWeight.bold,
        ));
  }

  Widget _dialWidget() {
    var centerOfGestureDetector =
        Offset(ScreenSize.width(50, context), ScreenSize.height(50, context));

    return GestureDetector(
        onPanStart: (details) {
          final touchPositionFromCenter =
              details.localPosition - centerOfGestureDetector;
          _upsetAngle = _oldAngle - touchPositionFromCenter.direction;
        },
        onPanEnd: (details) {
          setState(() => _oldAngle = _finalAngle);
        },
        onPanUpdate: (details) {
          final touchPositionFromCenter =
              details.localPosition - centerOfGestureDetector;
          setState(() =>
              _finalAngle = touchPositionFromCenter.direction + _upsetAngle);
        },
        child: Transform.rotate(
          angle: _finalAngle,
          child: Center(
              child: Image.asset(
            'assets/images/dial.png',
            height: ScreenSize.height(35, context),
          )),
        ));
  }

  void _gameInfoDialog() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Colors.blueGrey[100],
              title: const Text('Oyun Hakkında'),
              content: const Text(
                  'Nasıl Oynanır ? Aşağıdaki sorulardaki verilenlere göre gerekli çevirmeleri yaparak doğru cevapları yazınız.\n\n'
                  '1. Kadranı saat yönünde %10 çeviriniz.\n'
                  '2. Sonra, kadranı ters yönde %20 çeviriniz.\n'
                  '3. Sonra, kadranı saat yönünde %40 çeviriniz.\n'
                  '4. Son olarak, kadranı ters yönde %60 çeviriniz.\n\n'
                  'Tüm soruları cevapladıktan sonra kontrol et butonuna basarak cevapları kontrol edip oyunun tamamlayabilirsiniz.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Haydi Oyuna!'))
              ],
            ));
  }
}
