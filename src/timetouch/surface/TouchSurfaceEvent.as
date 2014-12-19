package timetouch.surface
{
	import flash.events.Event;
	
	public class TouchSurfaceEvent extends Event
	{
		
		public static const DRAWING_BEGIN:String = "drawingBegin";
		public static const DRAWING_MOVE:String = "drawingMove";
		public static const DRAWING_END:String = "drawingEnd";
		
		public var touchID:int;
		public var x:Number;
		public var y:Number;
		
		public function TouchSurfaceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}