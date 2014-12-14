package timetouch.view
{
	import flash.events.Event;
	
	public class DrawingViewEvent extends Event
	{
		
		public static const DRAWING_BEGIN:String = "drawingBegin";
		public static const DRAWING_MOVE:String = "drawingMove";
		public static const DRAWING_END:String = "drawingEnd";
		
		public var touchID:int;
		public var localX:Number;
		public var localY:Number;
		
		public function DrawingViewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}