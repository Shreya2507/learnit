import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'word_match_provider.dart';

class WordMatchGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordMatchProvider>(context);

    showDataAlert() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
              ),
              contentPadding: EdgeInsets.only(
                top: 10.0,
              ),
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Well Done!",
                      style: TextStyle(
                          fontSize: 24.0, color: Color.fromRGBO(49, 90, 1, 1)),
                    ),
                    Text(
                      "You can improve next time!",
                      style: TextStyle(
                          fontSize: 20.0, color: Color.fromRGBO(49, 90, 1, 1)),
                    ),
                  ]),
            );
          });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (provider.areAllPairsSelected()) {
        showDataAlert();
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushNamed(context, '/dashboard');
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Match Game'),
        backgroundColor: Color.fromRGBO(131, 193, 60, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        elevation: 5,
        // automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Match the words with their pairs!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3,
                  ),
                  itemCount: provider.shuffledKeys.length +
                      provider.shuffledValues.length,
                  itemBuilder: (context, index) {
                    if (index % 2 == 0) {
                      int leftIndex = index ~/ 2;
                      if (leftIndex < provider.shuffledKeys.length) {
                        String word = provider.shuffledKeys[leftIndex];
                        return GestureDetector(
                          onTap: provider.wordColors[word] != null
                              ? null
                              : () {
                                  provider.selectLeftWord(word);
                                },
                          child: Container(
                            decoration: BoxDecoration(
                              color: provider.wordColors[word] ?? Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                word,
                                style: TextStyle(
                                  color: provider.wordColors[word] != null
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      int rightIndex = (index - 1) ~/ 2;
                      if (rightIndex < provider.shuffledValues.length) {
                        String pair = provider.shuffledValues[rightIndex];
                        return GestureDetector(
                          onTap: provider.wordColors[pair] != null
                              ? null
                              : () {
                                  provider.selectRightWord(pair);
                                },
                          child: Container(
                            decoration: BoxDecoration(
                              color: provider.wordColors[pair] ?? Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                pair,
                                style: TextStyle(
                                  color: provider.wordColors[pair] != null
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    return SizedBox
                        .shrink(); // Return an empty widget for invalid indexes
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  provider.resetPairs();
                },
                child: Text('Restart Game'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Color.fromRGBO(131, 193, 60, 1),
                  minimumSize: Size(200, 50),
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class NewExerciseScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('New Exercise'),
//       ),
//       body: Center(
//         child: Text('This is the new exercise screen.'),
//       ),
//     );
//   }
// }
