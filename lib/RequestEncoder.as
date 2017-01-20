package lib 
{
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author OMaster
	 */
	public class RequestEncoder 
	{
		
		public function RequestEncoder() 
		{
			
		}
		
		public static function encode(base_url:String,key_arr:Array,value_arr:Array):URLRequest
		{
			var request:URLRequest = new URLRequest(base_url.concat(
			key_arr[0], "=", encodeURI(value_arr[0]))
			);
			if (key_arr.length < 2)
				return request;
			else
			{
				for (var i:int = 1; i < key_arr.length; i++)
				{
					request.url = request.url.concat("&",key_arr[i],"=",encodeURI(value_arr[i]))
				}
			}
			return request;
		}
		
	}

}