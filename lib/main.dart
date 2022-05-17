import 'dart:math';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: CardGame(),
    );
  }
}

class CardGame extends StatefulWidget {
  const CardGame({Key? key}) : super(key: key);

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  static const List<String> kindOfCards = [
    'clubs',
    'hearts',
    'diamonds',
    'spades',
  ];

  List<String> shuffledCards = List.empty(growable: true);
  int cardCount = 52;
  String displayCard = 'back.png';
  String shuffledCard = 'blank.png';
  int numberOfCard = 0;
  int indexOfCards = 0;

  String randomNumber() {
    numberOfCard = Random().nextInt(13) + 1;
    indexOfCards = Random().nextInt(4);
    return '${kindOfCards[indexOfCards]}$numberOfCard';
  }

  bool checkShuffledCards(String shuffledCard) =>
      shuffledCards.contains(shuffledCard) ? true : false;

  void randomCards() {
    setState(() {
      displayCard = randomNumber();
      while (checkShuffledCards('$displayCard.png') == true) {
        displayCard = randomNumber();
        if (shuffledCards.length == 53) {
          break;
        }
      }
      if (displayCard == '${kindOfCards[indexOfCards]}1') {
        Alert(
          context: context,
          title: 'CONGRATULATIONS!',
          desc: 'You pick an ace card with ${52 - cardCount} attempt\\s!',
        ).show();
        reset();
      }
      numberOfCard == 0
          ? displayCard = 'back.png'
          : shuffledCards.length == 52
              ? displayCard = 'blank.png'
              : displayCard = '$displayCard.png';
      shuffledCards.add(displayCard);

      cardCount -= 1;
      if (cardCount == -1) cardCount = 0;
    });
  }

  void reset() {
    displayCard = 'back';
    shuffledCard = 'blank.png';
    cardCount = 53;
    shuffledCards = List.empty(growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8E3200).withOpacity(0.9),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/table.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBC1),
                  ),
                  child: Text(
                    'Card Game',
                    style: GoogleFonts.patuaOne(
                      fontSize: 25,
                      color: const Color(0xFF8E3200),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 100),
                Text(
                  'Remaining Cards: $cardCount',
                  style: GoogleFonts.patuaOne(
                    fontSize: 20,
                    color: const Color(0xFFFFEBC1),
                  ),
                ),
                const SizedBox(height: 90),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          if (cardCount < 52) {
                            shuffledCard = displayCard;
                          }
                          randomCards();
                        },
                        child: Image.asset('images/$displayCard'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset('images/$shuffledCard'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
