import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_mytest/amplifyconfiguration.dart';
import 'package:new_mytest/models/ModelProvider.dart';

class Connected extends StatefulWidget {
  const Connected({Key? key}) : super(key: key);

  @override
  State<Connected> createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    final api = AmplifyAPI(modelProvider: ModelProvider.instance);
    await Amplify.addPlugin(api);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print('Tried to Amplify');
    }
  }

  Future<void> createTodo() async {
    try {
      final todo = Post(title: '111 second test by suyang', isComplete: true);
      final request = ModelMutations.create(todo);
      final response = await Amplify.API.mutate(request: request).response;

      final createdTodo = response.data;
      if (createdTodo == null) {
        print('errors: ${response.errors}');
        return;
      }
      print('Test result: it has sucessfully added');
    } on ApiException catch (e) {
      print('Test failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: createTodo,
          child: const Text('Test add an item'),
        ),
      ),
    ));
  }
}
