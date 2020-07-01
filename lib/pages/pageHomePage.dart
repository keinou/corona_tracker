import 'package:corona_tracker/model/modelDadosPPais.dart';
import 'package:corona_tracker/pages/pageCasos.dart';
import 'package:corona_tracker/constants.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DadosPorPaisData dadosPorPais = new DadosPorPaisData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Scaffold(
        //drawer: NavDrawer(),
        // appBar: AppBar(
        //   title: Text(widget.title),
        //   backgroundColor: Color.fromRGBO(255, 219, 0, 1),
        // ),
        //  Expanded(
        //   child: body(),
        // )
        body: Transform.scale(
      scale: 1,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Text(
                          "Sintomas",
                          style: kTitleTextstyle,
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SymptomCard(
                                image: "assets/images/sad.png",
                                title: "Dor de Cabeça",
                                isActive: true,
                              ),
                              SymptomCard(
                                image: "assets/images/cough.png",
                                title: "Tosse",
                              ),
                              SymptomCard(
                                image: "assets/images/fever.png",
                                title: "Febre",
                              ),
                              SymptomCard(
                                image: "assets/images/garganta.png",
                                title: "Dor de garganta",
                              ),
                              SymptomCard(
                                image: "assets/images/conjutivite.png",
                                title: "Conjuntivite",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Prevenção", style: kTitleTextstyle),
                        SizedBox(height: 20),
                        Container(
                          height: (MediaQuery.of(context).size.height * 156) /
                              737.45 *
                              2.2,
                          child: ListView(
                            children: [
                              PreventCard(
                                text:
                                    "Para a segurança de todos, fique em casa",
                                image: "assets/images/house.png",
                                title: "Fique em casa",
                              ),
                              PreventCard(
                                text:
                                    "Desde o início do surto de coronavírus, alguns lugares adotaram completamente o uso de máscaras faciais",
                                image: "assets/images/patient.png",
                                title: "Usar máscara facial",
                              ),
                              PreventCard(
                                text:
                                    "Este é o principal meio de combate ao coronavírus",
                                image: "assets/images/washing-hands.png",
                                title: "Lave suas mãos",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            color: Colors.white,
                            textColor: Colors.red,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CasosPage()),
                              );
                            },
                            child: Text(
                              "  Acompanhar Casos  ".toUpperCase(),
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: (MediaQuery.of(context).size.height * 156) / 737.45,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height * 136) / 737.45,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                height: 150,
                width: MediaQuery.of(context).size.width - 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: Text(
                        title,
                        style: kTitleTextstyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    )
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: SvgPicture.asset("assets/icons/forward.svg"),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image,
              height: (MediaQuery.of(context).size.height * 90) / 737.45),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
