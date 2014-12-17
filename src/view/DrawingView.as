package view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	
	import logger.print;
	
	import timetouch.surface.DrawingSurface;
	import timetouch.surface.DrawingSurfaceEvent;
	
	public class DrawingView extends DrawingSurface
	{
		
		private var bg:Sprite;
		private var draw:Sprite;
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
			
			bg = new CurvedBackground(0,0,WIDTH,HEIGHT);
			addChild(bg);
			
			draw = new Sprite();
			draw.mouseEnabled = false;
			addChild(draw);
			
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
		
		
		override public function getDrawingContainter():DisplayObjectContainer
		{
			return draw;
		}
		
		
		
		
		
		private var _mouseDragging:Boolean = false;
		
		protected function onMouseBegin(event:MouseEvent):void
		{
			if (!_mouseDragging) {
				_mouseDragging = true;
				var loc:Point = bg.globalToLocal(new Point(event.stageX, event.stageY));
				dispatchDrawingSurfaceEvent(DrawingSurfaceEvent.DRAWING_BEGIN, 0, loc.x, loc.y);
			}
		}
		
		protected function onMouseMove(event:MouseEvent):void
		{
			
			if (_mouseDragging) {
				var loc:Point = bg.globalToLocal(new Point(event.stageX, event.stageY));
				if (loc.x>=0&&loc.x<WIDTH&&loc.y>=0&&loc.y<HEIGHT) {
					dispatchDrawingSurfaceEvent(DrawingSurfaceEvent.DRAWING_MOVE, 0, loc.x, loc.y);	
				} else {
					_mouseDragging = false;
					dispatchDrawingSurfaceEvent(DrawingSurfaceEvent.DRAWING_END, 0, loc.x, loc.y);
				}
				
			}
		}
		
		protected function onMouseEnd(event:MouseEvent):void
		{
			if (_mouseDragging) {
				_mouseDragging = false;
				var loc:Point = bg.globalToLocal(new Point(event.stageX, event.stageY));
				dispatchDrawingSurfaceEvent(DrawingSurfaceEvent.DRAWING_END, 0, loc.x, loc.y);
			}
		}
		
		
		
		
				
		
	}
}