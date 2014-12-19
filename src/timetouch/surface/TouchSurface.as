package timetouch.surface
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	
	import logger.print;
	
	[Event(name="drawingBegin", type="timetouch.surface.TouchSurfaceEvent")]
	[Event(name="drawingMove", type="timetouch.surface.TouchSurfaceEvent")]
	[Event(name="drawingEnd", type="timetouch.surface.TouchSurfaceEvent")]
	
	public class TouchSurface extends Sprite
	{
		
		public function TouchSurface() {	
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			if (Multitouch.supportsTouchEvents) {
				//TODO TOUCH
				/*bg.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);*/
			}
			else {
				addEventListener(MouseEvent.MOUSE_DOWN, onMouseBegin);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEnd);
			}
		}
		
		
		private var _mouseDragging:Boolean = false;
		
		protected function onMouseBegin(event:MouseEvent):void
		{
			print(this, "onMouseBegin()");
			if (!_mouseDragging) {
				_mouseDragging = true;
				var loc:Point = globalToLocal(new Point(event.stageX, event.stageY));
				dispatchDrawingSurfaceEvent(TouchSurfaceEvent.DRAWING_BEGIN, 0, loc.x, loc.y);
			}
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			
			if (_mouseDragging) {
				var loc:Point = globalToLocal(new Point(event.stageX, event.stageY));
				if (loc.x>=0&&loc.x<width&&loc.y>=0&&loc.y<height) {
					dispatchDrawingSurfaceEvent(TouchSurfaceEvent.DRAWING_MOVE, 0, loc.x, loc.y);	
				} else {
					_mouseDragging = false;
					dispatchDrawingSurfaceEvent(TouchSurfaceEvent.DRAWING_END, 0, loc.x, loc.y);
				}
				
			}
		}
		
		protected function onMouseEnd(event:MouseEvent):void
		{
			if (_mouseDragging) {
				_mouseDragging = false;
				var loc:Point = globalToLocal(new Point(event.stageX, event.stageY));
				dispatchDrawingSurfaceEvent(TouchSurfaceEvent.DRAWING_END, 0, loc.x, loc.y);
			}
		}
		
		protected function dispatchDrawingSurfaceEvent(type:String, touchID, x:Number, y:Number):void
		{
			var e:TouchSurfaceEvent = new TouchSurfaceEvent(type);
			e.touchID = touchID;
			e.x = x;
			e.y = y;
			dispatchEvent(e);
		}
		
	}
}