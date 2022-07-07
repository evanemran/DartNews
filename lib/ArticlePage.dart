import 'package:dart_news/Models/HeadlinesResponse.dart';
import 'package:dart_news/Styles/AppTheme.dart';
import 'package:dart_news/WebPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);
  final Articles article;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    Articles article = widget.article;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Article",
          textAlign: TextAlign.center,),
      ),
      body: _buildBody(context, article),
    );// This trailing comma makes auto-formatting nicer for build metho
  }
}

Widget _buildReadMoreButton(BuildContext context, String url) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.red,
        ),
        elevation: MaterialStateProperty.all(6),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Read Full Article',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WebPage(url: url,)),
        );
      },
    ),
  );
}

Widget _buildBody(BuildContext context, Articles article){
  return Container(color: Colors.white, padding: EdgeInsets.all(16), child:
      Column(children: [
        Text(article.title.toString(), style: AppTheme.titleText,),
        SizedBox(height: 8,),
        FadeInImage.memoryNetwork(
          image: article.urlToImage.toString(),
          height: 220,
          placeholder: kTransparentImage,
          imageErrorBuilder:
              (context, error, stackTrace) {
            return Image.asset(
                'assets/images/flag_placeholder.jpg',
                height: 220,
                fit: BoxFit.fitWidth);
          },
          fit: BoxFit.fitHeight,
        ),
        SizedBox(height: 8,),
        Row(children: [Expanded(child: Text("Source: " + article.source!.name.toString(), style: AppTheme.authorText, textAlign: TextAlign.right,))],),
        Row(children: [Expanded(child: Text("Author: " + article.author.toString(), style: AppTheme.authorText, textAlign: TextAlign.right,))],),
        Row(children: [Expanded(child: Text("Published At: " + parseDateTime(article.publishedAt.toString()), style: AppTheme.authorText, textAlign: TextAlign.right,))],),
        SizedBox(height: 16,),
        Row(children: [Expanded(child: Text(article.description.toString(), style: AppTheme.contentText, textAlign: TextAlign.justify,))],),
        Row(children: [Expanded(child: Text(article.content.toString(), style: AppTheme.bodyText, textAlign: TextAlign.justify,))],),
        SizedBox(height: 16,),
        _buildReadMoreButton(context, article.url.toString())
      ],),);
}

String parseDateTime(String date){

  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('hh:mm a MMM dd yyyy');
  var outputDate = outputFormat.format(inputDate);

  return outputDate;
}