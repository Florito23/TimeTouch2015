package timetouch.timecontrol
{
	import flash.events.Event;
	
	public class TimeControlEvent extends Event
	{
		
		/**
		 * Event that dispatches current time
		 */
		public static const UPDATE_TIME:String = "updateTime";
		
		/**
		 * Dispatched when time has stopped
		 */
		public static const TIME_STOPPED:String = "timeStopped";
		
		/**
		 * Dispatched when time has started
		 */
		public static const TIME_STARTED:String = "timeStarted";
		
		public function TimeControlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}