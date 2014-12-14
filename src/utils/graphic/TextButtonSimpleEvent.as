package utils.graphic
{
	import flash.events.Event;
	
	public class TextButtonSimpleEvent extends Event
	{
		
		public static const BUTTON_TRIGGERED:String = "buttonTriggered";
		
		public function TextButtonSimpleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}