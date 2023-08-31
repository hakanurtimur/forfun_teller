import 'package:flutter/material.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/tarot_services.dart';
import 'package:provider/provider.dart';
import 'package:forfun_teller/widgets/tarot-widgets/tarot_meanings_colum.dart';

class TarotActionButton extends StatefulWidget {
  final String imageUrl1;
  final String imageUrl2;
  final String imageUrl3;
  final String image1Id;
  final String image2Id;
  final String image3Id;

  const TarotActionButton(
      {super.key,
      required this.imageUrl1,
      required this.imageUrl2,
      required this.imageUrl3,
      required this.image1Id,
      required this.image2Id,
      required this.image3Id});

  @override
  State<TarotActionButton> createState() => _TarotActionButtonState();
}

class _TarotActionButtonState extends State<TarotActionButton> {
  bool isRendered = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isRendered = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: isRendered ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: OutlinedButton(
            style: kOutlinedButtonStyle,
            child: const Text('Falınızı Görün', style: TextStyle(fontSize: 18)),
            onPressed: () async {
              var data =
                  await Provider.of<TarotServices>(context, listen: false)
                      .getTarotById(widget.image1Id, widget.image2Id,
                          widget.image3Id, context);
              String combineText = data['combineMeaning']['desc'];
              String tarot1Title = data['tarot1']['title'];
              String tarot1Desc = data['tarot1']['desc'];
              String tarot2Title = data['tarot2']['title'];
              String tarot2Desc = data['tarot2']['desc'];
              String tarot3Title = data['tarot3']['title'];
              String tarot3Desc = data['tarot3']['desc'];
              if (!context.mounted) return;
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: kBigModalBoxDecoration(context),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 50, bottom: 50, left: 20, right: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TarotMeaningsColumn(
                                      tarotTitle: tarot1Title,
                                      tarotDesc: tarot1Desc,
                                      imageUrl: widget.imageUrl1),
                                  PadderBox(),
                                  TarotMeaningsColumn(
                                      tarotTitle: tarot2Title,
                                      tarotDesc: tarot2Desc,
                                      imageUrl: widget.imageUrl2),
                                  PadderBox(),
                                  TarotMeaningsColumn(
                                      tarotTitle: tarot3Title,
                                      tarotDesc: tarot3Desc,
                                      imageUrl: widget.imageUrl3),
                                  PadderBox(),
                                  Text(
                                    'Kartların birleşik anlamı',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  PadderBox(),
                                  Text(
                                    combineText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
