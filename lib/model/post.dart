class PostList{
final List<Post> posts;
PostList({this.posts});
factory PostList.fromJson(List<dynamic> parsedJson){    //you could use List<Post> , it would work
 List<Post> posts = List<Post>();
 posts = parsedJson.map((i) => Post.fromJson(i)).toList();
return PostList(posts:posts);
}

}



class Post{
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],

    );
  } // factory keyword is used for this Constructor, because when we implement  this Constructor, then, this Constructor wont always create a new instance of its Class. Because we dont want it to constantly create new objects/instances, when we invoke Post..because they are very expensive in programming.


} //this gives you 1 object from the json payload