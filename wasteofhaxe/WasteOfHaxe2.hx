package wasteofhaxe;

import haxe.Http;
import haxe.Json;
import typedefs.*;

class WasteOfHaxe2 {
    private static function makeRequest(url:String = ''):Dynamic{
      return Json.parse(Http.requestUrl('https://api.wasteof.money/$url'));
    }
    
    public static function test():Dynamic{
        return makeRequest();
    }
}