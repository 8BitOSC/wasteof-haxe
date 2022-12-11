package wasteofhaxe;

import haxe.Http;
import haxe.Json;
import wasteofhaxe.Typedefs;

class WasteOfHaxe2 {
    private static function makeRequest(url:String = ''):Dynamic{
      return Json.parse(Http.requestUrl('https://api.wasteof.money/$url'));
    }
    
    public static function test():Dynamic{
        return makeRequest();
    }

    public static function getUser(user:String):User {
        return makeRequest('users/$user');
    }

    public static function getPosts(user:String,page:Int = 1):UserPostList {
      var req:Dynamic = makeRequest('users/$user/posts?page=$page');
      if(req.pinned.length > 0){
        req.pinned = req.pinned[0];
      }
      return req;
  }
}