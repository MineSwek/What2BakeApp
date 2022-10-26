import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'jeden',
    'dwa',
    'trzy',
    'cztery',
    'pięć',
    'sześć',
    'siedem',
    'osiem',
    'dziewięć',
    'dziesięć'
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
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF414141),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('https://steamuserimages-a.akamaihd.net/ugc/771727728500756344/8B4BCBE0ECA3A768383E6023D21D6037073E2814/'),
                ),
              ),
            ],
          ),
          Container(
            height: 47,
            decoration: BoxDecoration(
              color: const Color(0xFF383838),
              borderRadius: BorderRadius.circular(15),
            ),
            child: SearchBar(_kOptions),
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
  SearchBar(this._kOptions, {super.key});

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
      fieldViewBuilder: ( //Style obszaru wpisywania
          BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted
      ) {
        return Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.search,
                size: 38,
              ),
            ),
            Expanded(
              flex: 6,
              child: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                decoration: const InputDecoration(
                  hintText: 'Wprowadź odpowiednie argumenty',
                  hintStyle: TextStyle(
                    color: Color(0xFF959595),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
       );
      },
      onSelected: (String selection) {
        debugPrint(selection);
      },
      optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFC393838),
                ),
                height: min(options.length * 45, 255),
                width: MediaQuery.of(context).size.width - 32,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: SizedBox(
                        height: 40,
                        child: ListTile(
                          title: Text(
                              '● $option',
                              style: const TextStyle(color: Colors.white)
                          )
                        ),
                      ),
                    );
                  },
                ),
              ),
          ),
        );
        },
    );
  }
}
