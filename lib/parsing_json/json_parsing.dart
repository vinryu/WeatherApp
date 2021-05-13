//import 'dart:html';
//import 'packe:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:flutter/material.dart';

class JsonParsingSimple extends StatefulWidget {
  @override
  _JsonParsingSimpleState createState() => _JsonParsingSimpleState();
}

class _JsonParsingSimpleState extends State<JsonParsingSimple> {
Future data; //you are creating this variable of Future Type, which means you can use it to call the method fetchData(), which returns a Future type.
//the next thing we are go, is we are going to override the initState.
  //its ver important to remember, that the build method is called many times throoughout the rendering of our user interface.
  //So, its not a very good idea to ever call anything that requuires us to go fetch data amd do all sort of things, inside of this build method.
  //beacuse remmeber , build method should only be responsoble forrendering the user interface .
  //anything else. especially when we talk about asynchronously go and get remote data. it should NOT EVER be inside of our build ,because the build method is called many times, and we dont want flood our UI with calls that dont pertain to it.
  //So, as you know we are currently in a State here(as we are in a StateFul Widget), we are going to override, the init method:
  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      data = getData();
  }
  //the idea is that the application goes through certain states.
  //so , when we click open our app or in this case , when  we run ur application , the application goes through a few states until we can see our user interface....ie until we get to the actual rendering of our US ie, the Scaffold, appbar and body of the Scaffold etc.
  //one of these states is the init state. as the name implies, it is the initial part of the application.
  //This is where things happen even before or little bit before  the user interface is rendered which means that whenever we have certain things that the application needs, in this case, the data , ie setting up the data, ie, all the things that are needed before we bootup our application, the initState is where we should run this code.
  //so, in this case here it makes sense to do that becausewe are getting data , setting up the data  that we are getting from the jason api.
  //But again its a Future type , so we are not sure if we are going  to get a good result or a bad result. In any case, we are setting up our data source.
  //Here's where we want to do that work, that will pertain  to that data that we want to put in our user interface.
  //In this case , here we are going to let super.initState be caslled first, to make sure everything is good.
  //and then this is where we are going to say data Network("



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parsing Json'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: FutureBuilder( //whenever you call a builder, you are expecting to build something from the data source that you are passing. so, finally, you have to return a widget...which you are building...and this widget is at the returned Widget.
            future: getData(), //this future is asking : where do i get this Future type data which i need ,(which gets passes to snapshot),
            builder: (context, AsyncSnapshot snapshot){
              // return  Text(snapshot.data[0]['title']);//now, snapshot, is actually being retrieved by getData. All that is being done is being done in the backend , which is awersome. but although this works as it is , i like to give the snapshots some sort of modifier....and this is AsyncSnapshot. however, you can still see a red underline under snapshot because: an argument of type AsyncSnapshot, cant be passes to Text, which requires an argument of type String. so ,return snapshot.data . The data field returns a dynamic type. its also a LIST<Mao>. so, use [index]['key'] . This gives the result on the avd, but gives gibberish on the terminal...because whenever we are doing tihngs asynchronously, especially using futures as well as going remotely to invoke somthing where we have no control over this, we should always account for things that could go wrong...meaning, that although the avd display is showing the title correctly for the first object in our list, dart is asking us to be careful. by adding hasData which is a bool.

              if(snapshot.hasData) {
                return createListView(snapshot.data,context);

                //return Text(snapshot.data[0]['title'].toString());//.toString() because if you use id, then that returns an int.
              }
              return CircularProgressIndicator();


              },
          ),
        ),
      ),
    );
  }

  Widget createListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Divider(height: 5.0,),
            ListTile(
              title: Text("${data[index]['title']}"),
              subtitle: Text("${data[index]['body']}"),
              leading: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black26,
                    radius: 23,
                    child: Text('${data[index]['id']}'),
                  ),
        ],
              ),

            ),
          ],
        );
      }),

    );
  }
}


Future getData() async {
  var data;
  String url = 'https://jsonplaceholder.typicode.com/posts';
  Network network = Network(url);
  data = network.fetchData();
  print(data); //Instance of Future<dynamic>.

  data.then((value) {
    print(value[0]['title']);
  });
  return data;


}


class Network{
  //responsibility of this class is to go and fetch data from our url...it has to fetch the json payload. so, first , you need the json url. so, create that string.
  final String url;
  Network(this.url);
  //now, create a method called fetchData, which is responsible for actually getting a Json, decode it into data which we can parse. Beyond being asynchronous, it also has to be a Future type.

 Future fetchData() async{
   print('url');
   Response response = await get(Uri.encodeFull(url)); // Everytime we go and fetch anything, there is Respone...ie, you request some data...and the API sends out a Response....in this case, if all goes well...the Response will be a Json payload. So everytime we send a request, the api will send out a Response(sometimes the response can also be a error, or wrong request). you knock at a Door, you will either get an Open door or an acknowledgement that you knocked..but gave a wrong knock. This Respone object type is from http library.so import it.

  //you typed await because you have async above.
  //get method is also from http.dart. (as is Response type)
   //Response is a a HTTP response where the entire response is known in advance.
   if(response.statusCode==200){//if 200, then things are good
    // print(response.body[0]);
     return json.decode(response.body);   //you cant return a response only as it is gibberish.  you need to return(a Future Type) and also..you need to return response.body which is a String represenattion of the entire JSON file.body

   } else {
     print(response.statusCode);//this will tell us 100, 400 or 404 which will tell us what is happeiing with the request that is sent out.

   }
 }
}