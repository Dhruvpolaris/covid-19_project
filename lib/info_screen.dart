import './constant.dart';
import './widgets/my_header.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: "Covid-19",
              textBottom: "Details",
              iconleft: true,
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Symptoms",
                    style: dTitleTextstyle,
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SymptomCard(
                            image: "assets/images/headache.png",
                            title: "Headache",
                            // isActive: true,
                          ),
                          SizedBox(width: 15),
                          SymptomCard(
                            image: "assets/images/cough.png",
                            title: "Cough",
                          ),
                          SizedBox(width: 15),
                          SymptomCard(
                            image: "assets/images/fever.png",
                            title: "Fever",
                          ),
                          SizedBox(width: 15),
                          SymptomCard(
                            image: "assets/images/headache.png",
                            title: "Tiredness",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Prevention", style: dTitleTextstyle),
                  SizedBox(height: 20),
                  PreventCard(
                    text:
                        "Avoid going to crowded places where people come together in crowds.",
                    image: "assets/images/stayhome.png",
                    title: "STAY HOME \nSave Lives",
                  ),
                   PreventCard(
                    text:
                        "Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.",
                    image: "assets/images/covercough.png",
                    title: "COVER \nyour cough",
                  ),
                  PreventCard(
                    text:
                        "Maintain a safe distance (at least 1 meter) from anyone who is coughing or sneezing.",
                    image: "assets/images/distance.png",
                    title: "KEEP \nsafe distance",
                  ),
                  PreventCard(
                    text:
                        "Clean your hands often. Use soap and water, or an alcohol-based hand sanitizer.",
                    image: "assets/images/washhands.png",
                    title: "WASH \nhands often",
                  ),
                  PreventCard(
                    text:
                        "If you have a fever, a cough, and difficulty breathing, seek medical attention. CALL !",
                    image: "assets/images/sick.png",
                    title: "SICK? \nCall helpline",
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
        height: 160,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 135,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: dShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(
              image,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 150,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 145,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: dTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
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
                  color: dActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: dShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
