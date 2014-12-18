package utils.graphic
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class TextButtonSimpleEvent extends Event
	{
		
		public static const BUTTON_TRIGGERED:String = "buttonTriggered";
		public static const BUTTON_DRAGGING:String = "buttonDragging";
		public static const BUTTON_PRESSING:String = "buttonPressing";
				
		public function TextButtonSimpleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}