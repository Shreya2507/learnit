import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:learnit/screens/select-language.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  int selectedIndex = -1;
  TextEditingController controller = TextEditingController();
  List<String> filteredLanguages = [];
  @override
  void initState() {
    super.initState();
    filteredLanguages =
        arrNames; // Initialize filteredLanguages with all languages
  }

  var arrNames = [
    'Hindi',
    'Spanish',
    'French',
    'German',
    'Italian',
    'Portuguese',
    'Russian',
    'Japanese',
    'chinese'
  ];
  final List<String> imageUrls = [
    'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/383px-Flag_of_India.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Flag_of_Spain.svg/300px-Flag_of_Spain.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/255px-Flag_of_France.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/383px-Flag_of_Germany.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/383px-Flag_of_Italy.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/383px-Flag_of_Portugal.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/383px-Flag_of_Russia.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/383px-Flag_of_Japan.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/383px-Flag_of_the_People%27s_Republic_of_China.svg.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(
              top: 90, left: 10.0, right: 10.0, bottom: 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text(
                "Select Your Native Language",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                onChanged: onSearchTextChanged,
                controller: controller,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide(
                      width: 3,
                      color: Color.fromRGBO(131, 193, 60, 1),
                    ),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(135, 218, 213, 213),
                  hintText: 'Search Language',
                  hintStyle: TextStyle(color: Color.fromARGB(137, 103, 99, 99)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  suffixIcon: Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color.fromARGB(137, 103, 99, 99)),
                  ),
                ),
              ),
            ),
            // SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                  itemCount: filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final language = filteredLanguages[index];
                    bool isSelected = index == selectedIndex;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: ListTile(
                          //Tile Shape
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? Color.fromRGBO(131, 193, 60, 1)
                                  : Color.fromARGB(255, 228, 226, 226),
                            ),
                          ),
                          // ListTile Leading Icon Photo
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(
                              imageUrls[index],
                              width: 40.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(language),
                          trailing: isSelected
                              ? const IconTheme(
                                  data: IconThemeData(
                                    color: Color.fromRGBO(131, 193, 60, 1),
                                    size: 24.0,
                                  ),
                                  child: const Icon(Icons.check_box),
                                )
                              : null,
                          minLeadingWidth: 60, // Icon--content
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectLanguageScreen(
                                  selectedLanguage: language,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10.0),
          ])),
    );
  }

  void onSearchTextChanged(String text) {
    setState(() {
      filteredLanguages = arrNames.where((language) {
        return language.toLowerCase().contains(text.toLowerCase());
      }).toList();
    });
  }
}
