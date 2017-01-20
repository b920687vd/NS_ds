package lib 
{
	import adobe.utils.CustomActions;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author OMaster
	 */
	public class SkillMgr 
	{
		
		public function SkillMgr() 
		{
			send_var = new Object();
			dispatcher = new EventDispatcher();
			
			inst();
		}
		
		private function inst():void
		{
			_skill_index = 0;
			skill_class_index = 0;
			
			skill_list = new Array();
			skill_class_list = new Array();
			
			_skill_list_raw = new Array();
			_skill_list = new Array();
			_skill_dict = new Dictionary();
		}
		
		private var _skill_list:Array;
		private var _skill_list_raw:Array;
		
		private var _skill_dict:Dictionary;
		
		public var skill_list:Array;
		public var skill_class_list:Array;
		private var _skill_index:int;
		public var skill_class_index:int;
			
		public var dispatcher:EventDispatcher;
		
		public var send_var:Object;
		
		public function set skill_index(index:int):void
		{
			this._skill_index = index;
			skill_class_list = _skill_list[index];
		}
		
		public function get skill_index():int
		{
			return this._skill_index;
		}
		
		public static const SKILL_INTERFACE:String = "http://chessbook.applinzi.com/api/skill/insert/";
		
		public function send_skill(e:MouseEvent = null):void
		{
			var request:URLRequest = RequestEncoder.encode(SkillMgr.SKILL_INTERFACE,
			["name", "rank", "describe"], [send_var.name, send_var.rank, send_var.describe]
			);
			var loader:URLLoader = new URLLoader(request);
			loader.load(request);
			loader.addEventListener(Event.COMPLETE,skill_send_over);
		}
		
		public function skill_send_over(e:Event):void
		{
			var json:Object = JSON.parse(e.target.data)["data"];
			trace(e.target.data);
		}
		
		public function get_skill(e:MouseEvent = null):void
		{
			trace("开始获取技能队列")
			var request:URLRequest = new URLRequest("http://chessbook.applinzi.com/api/skill/list/key=value");
			request.method = "GET";
			var loader:URLLoader = new URLLoader(request);
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, skill_get_over);
			
		}

		public function skill_get_over(e:Event):void
		{
			trace("已获得技能队列")
			var json:Object = JSON.parse(e.target.data)["data"];
			inst();
			_skill_list_raw = json.items;
			
			for (var i = 0; i < _skill_list_raw.length; i++ )
			{
				trace("检测是否有 "+_skill_list_raw[i].name+" 技能，第" + i +"个 / 目前已经有"+ _skill_list.length+" / "+skill_list.length+" 个技能")
				if (!_skill_dict[_skill_list_raw[i].name])
				{
					trace(_skill_list_raw[i].name+" 技能不存在。将创建新集合")
					_skill_dict[_skill_list_raw[i].name] = new Array();
					_skill_list.push(_skill_dict[_skill_list_raw[i].name]);
					skill_list.push(_skill_list_raw[i]);
				}
				else
					trace(_skill_list_raw[i].name+" 技能已存在。");
				_skill_dict[_skill_list_raw[i].name].push(_skill_list_raw[i]);
			}
			skill_class_list = _skill_list[0];
			trace("当前技能有 " + skill_class_list.length + " 个等级");
			EventMgr.Cube.dispatchEvent(new LibEvent(LibEvent.LOAD_SUCCESS));
		}
		
	}

}