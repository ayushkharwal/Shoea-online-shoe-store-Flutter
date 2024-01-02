import 'package:flutter/material.dart';
import 'package:shoea_flutter/constants.dart';

class SeeAllOffersScreen extends StatefulWidget {
  const SeeAllOffersScreen({
    super.key,
    required this.specialOffersImagesList,
  });

  static const String routeName = '/special_offers';

  final List specialOffersImagesList;

  @override
  State<SeeAllOffersScreen> createState() => _SeeAllOffersScreenState();
}

class _SeeAllOffersScreenState extends State<SeeAllOffersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(
        'SpecialOffers in See All Offers Screen: ${widget.specialOffersImagesList}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Special Offers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.specialOffersImagesList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            // padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kGrey1,
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: NetworkImage(
                    widget.specialOffersImagesList[index]['image']),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
