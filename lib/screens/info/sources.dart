import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sources extends StatefulWidget {
  Sources({Key key}) : super(key: key);

  @override
  _SourcesState createState() => _SourcesState();
}

class _SourcesState extends State<Sources> {
  List<String> sources = [
    "http://entsyklopeedia.ee/artikkel/eesti_ajaloo_kronoloogia1",
    "https://et.wikipedia.org/wiki/Pulli_asula",
    "https://et.wikipedia.org/wiki/Eesti_esiajalugu",
    "https://et.wikipedia.org/wiki/Eesti_ajalugu",
    "https://register.muinas.ee/public.php?menuID=monument",
    "https://et.wikipedia.org/wiki/Kivikirstkalme",
    "https://et.wikipedia.org/wiki/Fulco",
    "https://et.wikipedia.org/wiki/M%C3%B5%C3%B5gavendade_ordu",
    "https://et.wikipedia.org/wiki/Katk",
    "https://et.wikipedia.org/wiki/Liivimaa_ristis%C3%B5da",
    "https://et.wikipedia.org/wiki/Eestlaste_muistne_vabadusv%C3%B5itlus",
    "https://et.wikipedia.org/wiki/Linna%C3%B5igus",
    "https://et.wikipedia.org/wiki/13._sajand_Eestis",
    "https://et.wikipedia.org/wiki/Stensby_leping",
    "https://et.wikipedia.org/wiki/L%C3%BCbecki_%C3%B5igus",
    "https://et.wikipedia.org/wiki/Kolmev%C3%A4ljas%C3%BCsteem",
    "https://et.wikipedia.org/wiki/Tsistertslaste_ordu",
    "https://et.wikipedia.org/wiki/Padise_klooster",
    "https://et.wikipedia.org/wiki/16._sajand_Eestis",
    "https://et.wikipedia.org/wiki/Vene-Liivi_s%C3%B5da",
    "https://et.wikipedia.org/wiki/K%C3%A4rde_rahu",
    "https://et.wikipedia.org/wiki/Stolbovo_rahu",
    "https://et.wikipedia.org/wiki/Br%C3%B6msebro_rahu",
    "https://et.wikipedia.org/wiki/Vallisaare_vaherahu",
    "https://et.wikipedia.org/wiki/Rootsi_aeg",
    "https://et.wikipedia.org/wiki/Peeter_I",
    "https://et.wikipedia.org/wiki/P%C3%B5hjas%C3%B5da",
    "https://en.wikipedia.org/wiki/Frederick_IV_of_Denmark",
    "https://et.wikipedia.org/wiki/Uusikaupunki_rahu",
    "https://et.wikipedia.org/wiki/Kadrioru_loss",
    "https://et.wikipedia.org/wiki/J%C3%BCri%C3%B6%C3%B6_%C3%BClest%C3%B5us",
    "https://ru.wikipedia.org/wiki/%D0%A1%D0%B5%D0%B2%D0%B5%D1%80%D0%BD%D0%B0%D1%8F_%D0%B2%D0%BE%D0%B9%D0%BD%D0%B0",
    "https://www.google.com/maps/place/Kunda+Lammasm%C3%A4gi/@59.4775287,26.5331443,13z/data=!4m2!3m1!1s0x0:0x55d69f7c2cbf77c1?sa=X&ved=2ahUKEwiikobp06nqAhWKE5oKHYdMBNsQ_BIwCnoECBMQCQ"
  ];

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Allikad')),
        body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: sources.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: ListTile(
                title: Text(sources[index]),
              ),
              onTap: () => launchURL(sources[index]),
            );
          },
        ));
  }
}
