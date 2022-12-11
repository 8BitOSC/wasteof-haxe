package wasteofhaxe;

private typedef UserPermissions = {
    var admin:Bool;
    var banned:Bool;
}

private typedef UserLink = {
    var label:String;
    var url:String;
}

private typedef UserHistory = {
    var joined:Int;
}

private typedef UserStats = {
    var followers:Int;
    var following:Int;
    var posts:Int;
}

typedef User = {
    var name:String;
    var id:String;
    var bio:String;
    var verified:Bool;
    var permissions:UserPermissions;
    var beta:Bool;
    var links:Array<UserLink>;
    var history:UserHistory;
    var stats:UserStats;
    var online:Bool;
}

private typedef Poster = {
    var name:String;
    var id:String;
}

typedef PostRevision = {
    var content:String;
    var time:Int;
    var current:Bool;
}

typedef Post = {
    var _id:String;
    var poster:Poster;
    var content:String;
    var time:Int;
    var revisions:Array<PostRevision>;
    var comments:Int;
    var loves:Int;
    var reposts:Int;
}