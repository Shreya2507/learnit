import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learnit/screens/native-language-selector.dart';

class SelectLanguageScreen extends StatefulWidget {
  final String selectedLanguage;
  SelectLanguageScreen({required this.selectedLanguage});

  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  TextEditingController controller = TextEditingController();
  List<String> filteredLanguages = [];
  @override
  void initState() {
    super.initState();
    filteredLanguages =
        arrNames; // Initialize filteredLanguages with all languages
  }

  var arrNames = [
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
    'https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Flag_of_Spain.svg/300px-Flag_of_Spain.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/c/c3/Flag_of_France.svg/255px-Flag_of_France.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/383px-Flag_of_Germany.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/0/03/Flag_of_Italy.svg/383px-Flag_of_Italy.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/383px-Flag_of_Portugal.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/383px-Flag_of_Russia.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/383px-Flag_of_Japan.svg.png',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/383px-Flag_of_the_People%27s_Republic_of_China.svg.png'
  ];
  final Map<String, String> helloTranslations = {
    'Hindi': 'नमस्ते',
    'Spanish': 'Hola',
    'French': 'Bonjour',
    'German': 'Hallo',
    'Italian': 'Ciao',
    'Portuguese': 'Olá',
    'Russian': 'Привет',
    'Japanese': 'こんにちは',
    'Chinese': '你好'
  };
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    String helloMessage = helloTranslations[widget.selectedLanguage] ?? 'Hello';

    return Scaffold(
      appBar: AppBar(
          // title: Text('Hello'),
          ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text(helloMessage,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Cursive',
                    fontWeight: FontWeight.w500,
                  )),
            ),
            //Text('You selected: ${widget.selectedLanguage}'),
            Center(
              child: Text(
                "Select Language To Learn",
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
            SizedBox(height: 10.0),
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
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
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
