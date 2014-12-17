package view
{
	import flash.events.Event;
	
	public class TimeControlViewEvent extends Event
	{
		
		public static const PAUSE_PRESSED:String = "pausePressed";
		public static const PLAY_PRESSED:String = "playPressed";
		
		public static const FFD_PRESSING:String = "ffdPressing";
		public static const REW_PRESSING:String = "rewPressing";
		
		public static const LOOP_ON_PRESSED:String = "loopOnPressed";
		public static const LOOP_OFF_PRESSED:String = "loopOffPressed";
		
		public function TimeControlViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}