import 'package:flutter/cupertino.dart';

class barcode {
  final Image image;

  barcode({
    required this.image,
  });
}

class Sachen {
  final Image image;

  Sachen({
    required this.image,
  });
}

final List<Sachen> liste = [
  Sachen(
    image: Image.asset(
      "images/etburger.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/tavukburger.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/kofte.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/patso.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/tost.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/doner.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/waffle.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/trileçe.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/tiramisu.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/magnolia.jpeg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/cheesecake.jpg",
      fit: BoxFit.fill,
    ),
  ),
  Sachen(
    image: Image.asset(
      "images/baklava.jpg",
      fit: BoxFit.fill,
    ),
  ),
];

final List<barcode> barcodes = [
  barcode(image: Image.asset("images/MASA1.png")),
  barcode(image: Image.asset("images/MASA2.png")),
  barcode(image: Image.asset("images/MASA3.png")),
  barcode(image: Image.asset("images/MASA4.png")),
  barcode(image: Image.asset("images/MASA5.png")),
  barcode(image: Image.asset("images/MASA6.png")),
  barcode(image: Image.asset("images/MASA7.png")),
  barcode(image: Image.asset("images/MASA8.png")),
  barcode(image: Image.asset("images/MASA9.png")),
  barcode(image: Image.asset("images/MASA10.png")),
  barcode(image: Image.asset("images/MASA11.png")),
  barcode(image: Image.asset("images/MASA12.png")),
  barcode(image: Image.asset("images/MASA13.png")),
  barcode(image: Image.asset("images/MASA14.png")),
  barcode(image: Image.asset("images/MASA15.png")),
];
