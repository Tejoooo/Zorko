import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 230,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "About Zorko",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "ZORKO Pvt Ltd. is a DIPP recognized startup dedicated to societal impact and sustainability, advocating reduced meat consumption and supporting animal welfare. Our diverse portfolio includes food manufacturing, Horeca supply, processing, health supplements, and tech-based services. Committed to ethics and trust, we aim to globally popularize vegetarianism with a goal of adding 1000+ new vegetarian restaurants in the next 1000 days."),
              SizedBox(
                height: 40,
              ),
              Text(
                "Our Journey",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Container(
                  height: 300,
                  child: Image.asset(
                    'assets/journey.png',
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 30,
              ),
              Text(
                  "ZORKO, a vegetarian QSR born during the COVID second wave, aimed to deliver top-quality food at affordable prices, delighting customers. Their innovative market strategy propelled them to instant success, sparking a wave of franchise inquiries. Responding to demand, the Nahar brothers devised a unique franchise model, addressing past challenges and paving the way for global expansion."),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async{
                        if(await canLaunchUrl(Uri.parse('https://zorko.in/'))){
                        await launchUrl(Uri.parse('https://zorko.in/'));
                        }
                      },
                      icon: Icon(
                        Icons.link,
                        size: 38,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.email, size: 38)), 
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.facebook_outlined,
                        size: 38,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.video_collection_rounded,
                        size: 38,
                      )),
                ],
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
