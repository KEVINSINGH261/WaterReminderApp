import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:waterreminderapp/pages/setting_model.dart';

class PageParametres extends StatefulWidget {
  const PageParametres({super.key});

  @override
  State<PageParametres> createState() => _PageParametresState();
}

class _PageParametresState extends State<PageParametres> {
  final TextEditingController _objectifController = TextEditingController();
  final TextEditingController _quantiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final settings = Provider.of<SettingsModel>(context, listen: false);
    _objectifController.text = settings.objectifQuotidien.toString();
    _quantiteController.text = settings.quantiteAAjouter.toString();
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/img.png',
          width: 50.0,
          height: 50.0,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Paramètres Généraux", style: TextStyle(fontSize: 20),)
              ],
            ),
            Divider(height: 20, thickness: 1,),
            GestureDetector(
              onTap: () {
                _objectifController.text = settings.objectifQuotidien.toString();
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Entrer votre nouvel objectif quotidien"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _objectifController,
                          decoration: InputDecoration(
                              labelText: "Objectif quotidien (ml)"
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            double? newValue = double.tryParse(_objectifController.text);
                            if (newValue != null) {
                              settings.setObjectifQuotidien(newValue);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Enregistrer")
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Annuler")
                      ),
                    ],
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Objectif quotidien", style: TextStyle(fontSize: 15,)),
                    Text('${settings.objectifQuotidien} ml'),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _quantiteController.text = settings.quantiteAAjouter.toString();
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Entrer la quantité à ajouter"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _quantiteController,
                          decoration: InputDecoration(
                              labelText: "Quantité à ajouter (ml)"
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            double? newValue = double.tryParse(_quantiteController.text);
                            if (newValue != null) {
                              settings.setQuantiteAAjouter(newValue);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Enregistrer")
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Annuler")
                      ),
                    ],
                  );
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Quantité à ajouter", style: TextStyle(fontSize: 15,)),
                    Text('${settings.quantiteAAjouter} ml'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Notifications", style: TextStyle(fontSize: 20),),
              ],
            ),
            Divider(height: 20, thickness: 1,),
          ],
        ),
      ),
    );
  }
}
