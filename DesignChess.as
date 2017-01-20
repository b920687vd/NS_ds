package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.navigateToURL;
	
	import lib.LibEvent;
	import lib.EventMgr;
	import lib.SkillMgr;
	
	public class DesignChess extends MovieClip {
		
		
		public function DesignChess() {
			// constructor code
			skill_mgr = new SkillMgr()
		}
		
		var skill_mgr:SkillMgr;
		
		public function send_skill(e:MouseEvent):void
		{
			var myPattern:RegExp = /\%/g;
			var desc_text:String = input_skill_describe.text.replace(myPattern, "％");
			
			skill_mgr.send_var = {
				"name":input_skill_name.text,
				"rank":input_skill_rank.text,
				"describe":desc_text
			}
			
			skill_mgr.send_skill();
		}

		public function get_skill(e:MouseEvent = null):void
		{
			skill_mgr.get_skill();
			EventMgr.Cube.addEventListener(LibEvent.LOAD_SUCCESS, skill_get_over);
		}

		public function skill_get_over(e:Event):void
		{
			show_skill_by_index(0);
		}

		public function show_skill_by_index(index:int = -1):void
		{
			if(index == -1)
				index = skill_mgr.skill_index;
			var item:Object = skill_mgr.skill_list[index];
			skill_bar.skill_name_text.text = (item.name as String).concat(" : ",item.rank);
			skill_bar.skill_describe_text.text = item.describe;
		}
		
		public function show_class_by_index(index:int = -1):void
		{
			if (index == -1)
				index = skill_mgr.skill_class_index;
			var item:Object = skill_mgr.skill_class_list[index];
			skill_bar.skill_name_text.text = (item.name as String).concat(" : ",item.rank);
			skill_bar.skill_describe_text.text = item.describe;
		}

		public function show_last_skill(e:MouseEvent = null):void
		{
			if(skill_mgr.skill_index == 0)
				return;
			else
			{
				skill_mgr.skill_index--;
				skill_mgr.skill_class_index = 0;
			}
			show_skill_by_index();
		}

		public function show_next_skill(e:MouseEvent = null):void
		{
			if(skill_mgr.skill_index == (skill_mgr.skill_list.length-1))
				return;
			else
			{
				skill_mgr.skill_index++;
				skill_mgr.skill_class_index = 0;
			}
			show_skill_by_index();
		}
		
		public function show_last_class(e:MouseEvent = null):void
		{
			if(skill_mgr.skill_class_index == 0)
				return;
			else
				skill_mgr.skill_class_index--;
			show_class_by_index();
		}
		
		public function show_next_class(e:MouseEvent = null):void
		{
			if(skill_mgr.skill_class_index == (skill_mgr.skill_class_list.length-1))
				return;
			else
				skill_mgr.skill_class_index++;
			show_class_by_index();
		}
	}
	
}
