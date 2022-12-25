package wasteofhaxe;

#if !html5
import haxe.Http;
import haxe.io.Bytes;
import haxe.Json;
import wasteofhaxe.Typedefs;
import openfl.display.BitmapData;
import openfl.utils.ByteArray;
import haxe.io.BytesOutput;
import haxe.Exception;

using StringTools;

class WasteOfHaxe2 {
	public static var apiUrl:String = 'https://api.wasteof.money/';

	private static function makeRequest(url:String = '', isJson:Bool = true):Dynamic {
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
		if(!Http.requestUrl(apiUrl + url).contains('http://www.w3.org/2000/svg')){
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

	public static function putRequest(url:String, data:Dynamic) {
		var req:Http = new Http(apiUrl + url);
		var responseBytes:BytesOutput = new BytesOutput();
		req.setHeader("User-Agent", "request");

		req.setPostData(Json.stringify(data));
		req.addHeader("Content-Type", "application/json");

		req.onError = function(e) {
			throw e;
		};

		req.customRequest(true, responseBytes, "PUT");

		var response:Bytes = responseBytes.getBytes();

		return Json.parse(response.toString());
	}

	public static function getHome():Dynamic {
		return makeRequest();
	}

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

	public static function getUserFromId(id:String):Dynamic{
		return makeRequest('username-from-id/$id');
	}

	public static function usernameAvailable(username:String):Bool{
		return makeRequest('username-available?username=$username');
	}

	public static function getPost(id:String):Post{
		return makeRequest('posts/$id');
	}

	public static function getCommentsOnPost(id:String,page:Int = 1):CommentList{
		return makeRequest('posts/$id/comments?page=$page');
	}

	public static function searchUsers(query:String, page:Int = 1):UserList{
		return makeRequest('search/users?q=$query&page=$page');
	}

	public static function searchPosts(query:String, page:Int = 1):PostList{
		return makeRequest('search/posts?q=$query&page=$page');
	}

	public static function getRepliesToComment(id:String, page:Int = 1):CommentList{
		return makeRequest('comments/$id/replies?page=$page');
	}

	public static function getWallComments(user:String, page:Int = 1):CommentList{
		return makeRequest('users/$user/wall?page=$page');
	}

	public static function getIfUserLovedPost(id:String, user:String):Bool{
		return makeRequest('posts/$id/loves/$user');
	}
	
	public static function getFeed(user:String, page:Int = 1):PostList{
		return makeRequest('users/$user/following/posts?page=$page');
	}

	public static function requestPasswordReset(user:String):Bool{
		return putRequest('settings/password-reset', {username: user});
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
	public static function getUserFromId(id:String){}
	public static function usernameAvailable(username:String){}
	public static function getPost(id:String){}
	public static function getCommentsOnPost(id:String,page:Int = 1){}
	public static function searchUsers(query:String, page:Int = 1){}
	public static function searchPosts(query:String, page:Int = 1){}
	public static function getRepliesToComment(id:String, page:Int = 1){}
	public static function getWallComments(user:String, page:Int = 1){}
	public static function getIfUserLovedPost(id:String, user:String){}
	public static function getFeed(user:String, page:Int = 1){}
	public static function requestPasswordReset(user:String){}
}
#end