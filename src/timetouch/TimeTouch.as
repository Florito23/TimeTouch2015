package timetouch
{
	import flash.events.EventDispatcher;
	
	import logger.print;
	
	import timetouch.linestorage.LineStorage;
	import timetouch.linestorage.LineVO;
	import timetouch.renderer.Renderer;
	import timetouch.surface.DrawingSurface;
	import timetouch.surface.DrawingSurfaceEvent;
	import timetouch.timecontrol.DefaultTimeControl;
	import timetouch.timecontrol.TimeControl;
	import timetouch.timecontrol.TimeControlEvent;
	
	public class TimeTouch extends EventDispatcher
	{
		
		private var _timeControl:TimeControl;
		private var _drawingSurface:DrawingSurface;
		
		private var _storage:LineStorage;
		//private var _creatingLines:LineStorage;		

		private var _renderer:Renderer;
		
		public function TimeTouch()
		{
			super();
			
			_storage = new LineStorage();
		//	_creatingLines = new LineStorage();
			_renderer = new Renderer();
			
			timeControl = new DefaultTimeControl(TimeControl.INTERNAL_CLOCK);
			drawingSurface = new DrawingSurface();
			
		}
		
		public function set timeControl(v:TimeControl):void
		{
			if (_timeControl) {
				_timeControl.pause();
				_timeControl.removeEventListener(TimeControlEvent.UPDATE_TIME, onUpdateTime);
			}
			_timeControl = v;
			_timeControl.addEventListener(TimeControlEvent.UPDATE_TIME, onUpdateTime);
		}
		
		public function get timeControl():TimeControl {
			return _timeControl;
		}
		
		public function render():void
		{
			_renderer.render(_storage, _timeControl.currentTimeMilliseconds, _drawingSurface);
		}
		
		protected function onUpdateTime(event:TimeControlEvent):void
		{
			//trace("onUpdateTime()",(event.target as TimeControl).currentTimeMilliseconds);
			//TODO:
			var past:Number = _timeControl.lastTimeMilliseconds;
			var current:Number = _timeControl.currentTimeMilliseconds;
			if (past>current) {
				finishAndRestartCurrentLines();
			}
		}
		
		
		
		public function set drawingSurface(s:DrawingSurface):void
		{
			if (_drawingSurface) {
				_drawingSurface.removeEventListener(DrawingSurfaceEvent.DRAWING_BEGIN, onDrawBegin);
				_drawingSurface.removeEventListener(DrawingSurfaceEvent.DRAWING_MOVE, onDrawMove);
				_drawingSurface.removeEventListener(DrawingSurfaceEvent.DRAWING_END, onDrawEnd);
			}
			_drawingSurface = s;
			_drawingSurface.addEventListener(DrawingSurfaceEvent.DRAWING_BEGIN, onDrawBegin);
			_drawingSurface.addEventListener(DrawingSurfaceEvent.DRAWING_MOVE, onDrawMove);
			_drawingSurface.addEventListener(DrawingSurfaceEvent.DRAWING_END, onDrawEnd);
		}
		
		
		
		protected function onDrawBegin(e:DrawingSurfaceEvent):void {
			
			print(this, "onDrawBegin()", e.touchID, e.x, e.y);
			
			var lastTime:Number = _timeControl.lastTimeMilliseconds;
			var time:Number = _timeControl.currentTimeMilliseconds;
			
			_storage.startLineByID(e.touchID, e.x, e.y, time, time+3000);
		}
		
		protected function onDrawMove(e:DrawingSurfaceEvent):void {
			print(this, "onDrawMove()", e.touchID, e.x, e.y);
			
			var lastTime:Number = _timeControl.lastTimeMilliseconds;
			var time:Number = _timeControl.currentTimeMilliseconds;
			
			// pause or playing forward
			//if (lastTime<=time) {
				_storage.continueLineByID(e.touchID, e.x, e.y, time, time+3000);	
			//}
			// rewind or loop point: stop line, start new one
			/*else {
				_storage.finishAndStoreLineByID(e.touchID);
				_storage.startLineByID(e.touchID, e.x, e.y, time, time+3000);
			}*/
			
			
		}
		
		protected function finishAndRestartCurrentLines():void
		{
			var time:Number = _timeControl.currentTimeMilliseconds;
			_storage.finishAndRestartCurrentLines(time, time+3000);
		}
		
		protected function onDrawEnd(e:DrawingSurfaceEvent):void {
			print(this, "onDrawEnd()", e.touchID, e.x, e.y);
			
			var lastTime:Number = _timeControl.lastTimeMilliseconds;
			var time:Number = _timeControl.currentTimeMilliseconds;
			// pause or playing forward
			//if (lastTime<=time) {
				_storage.continueAndFinishLineByID(e.touchID, e.x, e.y, time, time+3000);
			//}
			// rewind or loop point: stop line
			/*else {
				_storage.finishAndStoreLineByID(e.touchID);
				//_storage.startLineByID(e.touchID, e.x, e.y, time, time+3000);
			}*/
		}
		
	}
}