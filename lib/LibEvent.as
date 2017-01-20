package lib 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author OMaster
	 */
	public class LibEvent extends Event 
	{
		
		public function LibEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
		public static const LOAD_SUCCESS:String = "load_success";
		
	}

}