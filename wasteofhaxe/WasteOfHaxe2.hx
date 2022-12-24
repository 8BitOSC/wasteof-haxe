package wasteofhaxe;

import haxe.Http;
import haxe.io.Bytes;
import haxe.Json;
import wasteofhaxe.Typedefs;
import openfl.display.BitmapData;

using StringTools;

class WasteOfHaxe2 {
	public static var apiUrl:String = 'https://api.wasteof.money/';
	private static function makeRequest(url:String = '', isJson:Bool = true):Dynamic {
		var h:Http = new Http(apiUrl+url);
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

	private static function makeBitmapRequest(url:String):BitmapData {
		var h:Http = new Http(apiUrl+url);
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

	public static function getProfilePicture(user:String):BitmapData {
		return makeBitmapRequest('users/$user/picture');
	}

	public static function getBanner(user:String):BitmapData {
		return makeBitmapRequest('users/$user/banner');
	}
}
