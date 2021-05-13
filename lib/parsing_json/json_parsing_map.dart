import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_json_http/model/post.dart';
import 'package:http/http.dart';

class JsonParsingMap extends StatefulWidget {
  @override
  _JsonParsingMapState createState() => _JsonParsingMapState();
}

class _JsonParsingMapState extends State<JsonParsingMap> {
  Future<PostList> data;
  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      Network network = Network('https://jsonplaceholder.typicode.com/posts');
      data = network.loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PODO'),

      ),
      body: Center(
        child: Container(

          child: FutureBuilder(
            future: data,
            builder: (context, AsyncSnapshot<PostList> snapshot){
            List<Post> allPosts;
            if(snapshot.hasData){
              allPosts = snapshot.data.posts;
              return createListView(allPosts, context);
            } else {
              return CircularProgressIndicator();
            }

          },),
        ),
      ),
    );
  }

Widget createListView(List<Post> data, BuildContext context){
  return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index  ){
            return Column(
              children: [
                Divider(height: 5,),
                ListTile(
                  title: Text("${data[index].title}"),
                  subtitle: Text('${data[index].body}'),
                  leading: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 23,
                        child: Text('${data[index].id}'),
                        
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

      ),
  );

}


}



class Network{
  //responsibility of this class is to go and fetch data from our url...it has to fetch the json payload. so, first , you need the json url. so, create that string.
  final String url;
  Network(this.url);
  //now, create a method called fetchData, which is responsible for actually getting a Json, decode it into data which we can parse. Beyond being asynchronous, it also has to be a Future type.

  Future<PostList> loadPosts() async{
    final response = await get(Uri.encodeFull(url));
    if(response.statusCode ==200){
      return PostList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falied to get posts');
    }
}
}