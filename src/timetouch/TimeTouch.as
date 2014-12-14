package timetouch
{
	import flash.events.EventDispatcher;
	
	import timetouch.timecontrol.TimeControl;
	import timetouch.timecontrol.TimeControlEvent;
	
	public class TimeTouch extends EventDispatcher
	{
		
		private var _timeControl:TimeControl;
		
		public function TimeTouch()
		{
			super();
		}
		
		public function set timeControl(v:TimeControl):void
		{
			if (_timeControl) {
				_timeControl.pause();
				_timeControl.removeEventListener(TimeControlEvent.UPDATE_TIME, onUpdateTime);
			}
			_timeControl = v;
			_timeControl.addEventListener(TimeControlEvent.UPDATE_TIME, onUpdateTime);
		}
		
		public function get timeControl():TimeControl {
			return _timeControl;
		}
		
		protected function onUpdateTime(event:TimeControlEvent):void
		{
			//trace("onUpdateTime()",(event.target as AbstractTimeControl).currentMilliseconds);
			//TODO:
		}
		
	}
}