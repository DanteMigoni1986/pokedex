import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controllers/data_state_controller.dart';

class PokemonDescriptionPage extends StatelessWidget {
  const PokemonDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon Description')),
      body: _PageBody(),
    );
  }
}

class _PageBody extends StatelessWidget {
  final dynamicDataCtrl = Get.find<DataStateController>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 100.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: Colors.red,
                    width: 4.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: const FadeInImage(
                    image: AssetImage('assets/img/no-image.jpg'),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                    height: 150.0,
                    width: 150.0,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      dynamicDataCtrl.currentPokemon.value.name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                ],
              ),
            ],
          ),
          const SizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: const [
                  SizedBox(
                    width: 180,
                    child: Text(
                      'Ability:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  SizedBox(
                    width: 180,
                    child: Text(
                      'Ability:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      dynamicDataCtrl
                          .currentPokemon.value.abilities[0].ability.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 54.0),
                  SizedBox(
                    width: 180,
                    child: Text(
                      dynamicDataCtrl
                          .currentPokemon.value.abilities[1].ability.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 30),
              Text(
                'More information',
                style: TextStyle(
                  color: Color.fromRGBO(180, 180, 180, 1.0),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            height: 2,
            width: width * 0.9,
            color: Color.fromRGBO(180, 180, 180, 1.0),
          ),
        ],
      ),
    );
  }
}
