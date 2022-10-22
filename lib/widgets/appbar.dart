import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'jeden',
    'dwa',
    'trzy',
    'cztery'
  ];

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset('assets/Logo.svg'),
              const CircleAvatar(),
            ],
          ),
          Container(
            height: 47,
            decoration: BoxDecoration(
              color: const Color(0xFF383838),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const SearchBar(_kOptions),
          ),
        ],
      ),
      toolbarHeight: 156,
      floating: true,
      pinned: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background.png',),
            fit: BoxFit.fitWidth,
          ),
         ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar(this._kOptions, {super.key});

  final List<String> _kOptions;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint(selection);
      },
    );
  }
}
