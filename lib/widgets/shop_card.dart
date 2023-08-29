import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:forfun_teller/constants.dart';
import 'package:forfun_teller/services/provider/diamond_services.dart';
import 'package:provider/provider.dart';

class ShopCard extends StatelessWidget {
  final int diamondCount;
  final double price;
  final currentUser = FirebaseAuth.instance.currentUser;

  ShopCard({
    required this.diamondCount,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(Provider.of<DiamondService>(context).sellingDiamondLoading);
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 0.2,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.7),
            context: context,
            builder: (context) => Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${price.toStringAsFixed(2)} ₺'ye $diamondCount Forfun Diamond satın almak istediğinize emin misiniz?",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      TextButton(
                        onPressed: () async {
                          if (!Provider.of<DiamondService>(context,
                                  listen: false)
                              .sellingDiamondLoading) {
                            await Provider.of<DiamondService>(context,
                                    listen: false)
                                .sellingDiamondAmount(
                                    currentUser!.uid, diamondCount, context);
                            Navigator.pushReplacementNamed(context, '/logged');
                          }
                        },
                        style: kOutlinedButtonStyle,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: !Provider.of<DiamondService>(context)
                                  .sellingDiamondLoading
                              ? const Text(
                                  'Satın Al',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                )
                              : const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: SpinKitSpinningLines(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
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
              ],
            ),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    diamondCount.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.diamond,
                    size: 20,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text('${price.toStringAsFixed(2)} ₺',
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
