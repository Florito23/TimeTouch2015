package timetouch.timecontrol
{
	import flash.events.EventDispatcher;
	
	[Event(name="updateTime", type="timetouch.timecontrol.TimeControlEvent")]
	[Event(name="timeStopped", type="timetouch.timecontrol.TimeControlEvent")]
	[Event(name="timeStarted", type="timetouch.timecontrol.TimeControlEvent")]
	public class TimeControl extends EventDispatcher
	{
		public function get playing():Boolean { 
			return _playing; 
		}
		protected var _playing:Boolean = false;
		
		public function get currentTimeMilliseconds():Number
		{
			return _currentTimeMilliseconds;
		}
		protected var _currentTimeMilliseconds:Number = 0;
		
		public function get lastTimeMilliseconds():Number
		{
			return _lastTimeMilliseconds;
		}
		protected var _lastTimeMilliseconds:Number = 0;
		
		function TimeControl()
		{
			super();
		}
		
		/**
		 * TODO: Override!
		 * @param milliseconds the time to set
		 * @return true if the time was set
		 */
		public function setCurrentTimeMilliseconds(milliseconds:Number):Boolean
		{
			return false;
		}
		
		/**
		 * Dispatches TimeControlEvent.TIME_STOPPED
		 */
		public function pause():void 
		{
			dispatchEvent(new TimeControlEvent(TimeControlEvent.TIME_STOPPED));
		}
		
		/**
		 * Dispatches TimeControlEvent.TIME_STARTED
		 */
		public function play():void
		{
			dispatchEvent(new TimeControlEvent(TimeControlEvent.TIME_STARTED));
		}
	}
}