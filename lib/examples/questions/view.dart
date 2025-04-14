import 'package:flutter/material.dart';

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key});

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  final list = [
    "Text",
    "Image.asset",
    "Image.network",
    "Other",
  ];
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(border: Border.all()),
          width: double.infinity,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text("What is the Widget Used To Make Network Image?"),
              const SizedBox(
                height: 20,
              ),
              ...List.generate(
                list.length,
                (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RadioListTile(
                          title: Text(list[index]),
                          value: index,
                          groupValue: selectedItem,
                          onChanged: (value) {
                            selectedItem = value!;

                            setState(() {});
                          }),
                      if (index == list.length - 1 && index == selectedItem)
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
