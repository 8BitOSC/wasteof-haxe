package wasteofhaxe;

#if !html5
import haxe.Http;
import haxe.io.Bytes;
import haxe.Json;
import wasteofhaxe.Typedefs;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;
import haxe.Exception;

using StringTools;

class WasteOfHaxe2 {
	public static var apiUrl:String = 'https://api.wasteof.money/';

	private static function makeRequest(url:String = '', isJson:Bool = true):Dynamic {
		trace(apiUrl + url);
		var h:Http = new Http(apiUrl + url);
		h.setHeader("User-Agent", "request");
		var r:Null<Dynamic> = null;
		h.onData = function(d) {
			r = d;
		};
		h.onError = function(e) {
			throw e;
		};
		h.request(false);
		if (isJson) {
			return Json.parse(r);
		}
		return r;
	}


	private static function makeBitmapRequest(url:String):Null<BitmapData> {
		var h:Null<Http> = null;
		var svgUrl:String = 'https://wasteofhaxe-image-handler.8bitjake.repl.co/?url=$apiUrl$url';
		if(Http.requestUrl(svgUrl) == 'is already png'){
			h = new Http(apiUrl + url);
		} else {
			h = new Http(svgUrl);
		}
		h.setHeader("User-Agent", "request");
		var r:Null<ByteArray> = null;

		h.onBytes = function(d) {
			r = d;
		};
		h.onError = function(e) {
			throw e;
		};
		h.request(false);
		return BitmapData.fromBytes(r);
	}

	public static function getHome():Dynamic {
		return makeRequest();
	}

	// all the user stuff!!
	public static function getUser(user:String):User {
		return makeRequest('users/$user');
	}

	public static function getPosts(user:String, page:Int = 1):UserPostList {
		var req:Dynamic = makeRequest('users/$user/posts?page=$page');
		if (req.pinned.length > 0) {
			req.pinned = req.pinned[0];
		}
		return req;
	}

	public static function getFollowing(user:String, page:Int = 1):FollowingList {
		return makeRequest('users/$user/following?page=$page');
	}

	public static function getFollowers(user:String, page:Int = 1):FollowingList {
		return makeRequest('users/$user/followers?page=$page');
	}

	public static function isFollowing(user:String, other:String):Bool {
		return makeRequest('users/$user/followers/$other');
	}

	public static function getProfilePicture(user:String):Null<BitmapData> {
		return makeBitmapRequest('users/$user/picture');
	}

	public static function getBanner(user:String):Null<BitmapData> {
		return makeBitmapRequest('users/$user/banner');
	}
}
#else

class WasteOfHaxe2 { // same class, but all functions do nothing
	public static function getHome(){}
	public static function getUser(user:String){}
	public static function getPosts(user:String, page:Int = 1){}
	public static function getFollowing(user:String, page:Int = 1){}
	public static function getFollowers(user:String, page:Int = 1){}
	public static function isFollowing(user:String, other:String){}
	public static function getProfilePicture(user:String){}
	public static function getBanner(user:String){}
}
#end