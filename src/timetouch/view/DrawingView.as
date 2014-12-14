package timetouch.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Multitouch;
	
	import logger.print;
	
	[Event(name="drawingBegin", type="timetouch.view.DrawingViewEvent")]
	[Event(name="drawingMove", type="timetouch.view.DrawingViewEvent")]
	[Event(name="drawingEnd", type="timetouch.view.DrawingViewEvent")]
	
	public class DrawingView extends Sprite
	{
		
		private var WIDTH:int;
		private var HEIGHT:int;
		
		public function DrawingView(width:int, height:int)
		{
			super();
			WIDTH = width;
			HEIGHT = height;
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void {
			
			print(this, "onStage()");
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			var bg:Sprite = new CurvedBackground(0,0,WIDTH,HEIGHT);
			addChild(bg);
			
			if (Multitouch.supportsTouchEvents) {
				//TODO TOUCH
				/*bg.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);*/
			}
			else {
				bg.addEventListener(MouseEvent.MOUSE_DOWN, onMouseBegin);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP, onMouseEnd);
			}
			
		}
		
		private var _mouseDragging:Boolean = false;
		
		protected function onMouseBegin(event:MouseEvent):void
		{
			_mouseDragging = true;
			//TODO: NOT LOCALX!!!
			dispatchDrawingViewEvent(DrawingViewEvent.DRAWING_BEGIN, 0, bgX, bgY);
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			
			if (_mouseDragging) {
				var x:Number = event.localX;
				var y:Number = event.localY;
				if (x>=0&&x<WIDTH&&y>=0&&y<HEIGHT) {
					dispatchDrawingViewEvent(DrawingViewEvent.DRAWING_MOVE, 0, bgX, bgY);	
				} else {
					_mouseDragging = false;
					dispatchDrawingViewEvent(DrawingViewEvent.DRAWING_END, 0, bgX, bgY);
				}
				
			}
		}
		
		protected function onMouseEnd(event:MouseEvent):void
		{
			_mouseDragging = false;
			dispatchDrawingViewEvent(DrawingViewEvent.DRAWING_END, 0, bgX, bgY);
		}
		
		
		
		
		
		
		private function dispatchDrawingViewEvent(drawingViewEventType:String, touchID:int, localX:Number, localY:Number):void
		{
			var e:DrawingViewEvent = new DrawingViewEvent(drawingViewEventType);
			e.touchID = touchID;
			e.localX = localX;
			e.localY = localY;
			dispatchEvent(e);
		}		
		
	}
}