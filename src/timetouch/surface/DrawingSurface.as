package timetouch.surface
{
	import flash.display.Sprite;
	
	[Event(name="drawingBegin", type="timetouch.surface.DrawingSurfaceEvent")]
	[Event(name="drawingMove", type="timetouch.surface.DrawingSurfaceEvent")]
	[Event(name="drawingEnd", type="timetouch.surface.DrawingSurfaceEvent")]
	
	public class DrawingSurface extends Sprite
	{
		public function DrawingSurface()
		{
			super();
		}
		
		
		
		protected function dispatchDrawingSurfaceEvent(drawingSurfaceEventType:String, touchID:int, localX:Number, localY:Number):void
		{
			var e:DrawingSurfaceEvent = new DrawingSurfaceEvent(drawingSurfaceEventType);
			e.touchID = touchID;
			e.localX = localX;
			e.localY = localY;
			dispatchEvent(e);
		}
	}
}