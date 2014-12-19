package timetouch
{
	import flash.events.EventDispatcher;
	
	import logger.print;
	
	import timetouch.linestorage.LineVO;
	import timetouch.linestorage.Storage;
	import timetouch.renderer.Renderer;
	import timetouch.surface.TouchSurfaceEvent;
	import timetouch.surface.IDrawingSurface;
	import timetouch.surface.TouchSurface;
	import timetouch.timecontrol.DefaultTimeControl;
	import timetouch.timecontrol.TimeControl;
	import timetouch.timecontrol.TimeControlEvent;
	
	public class TimeTouch extends EventDispatcher
	{
		
		private var _timeControl:TimeControl;
		
		private var _touchSurface:TouchSurface;
		private var _drawingSurface:IDrawingSurface;
		
		private var _storage:Storage;
		//private var _creatingLines:LineStorage;		

		private var _renderer:Renderer;
		
		public function TimeTouch()
		{
			super();
			
			_storage = new Storage();
		//	_creatingLines = new LineStorage();
			_renderer = new Renderer();
			
			timeControl = new DefaultTimeControl(TimeControl.INTERNAL_CLOCK);
			//drawingSurface = new IDrawingSurface();
			
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
		
		
		
		public function set touchSurface(s:TouchSurface):void
		{
			if (_touchSurface) {
				_touchSurface.removeEventListener(TouchSurfaceEvent.DRAWING_BEGIN, onDrawBegin);
				_touchSurface.removeEventListener(TouchSurfaceEvent.DRAWING_MOVE, onDrawMove);
				_touchSurface.removeEventListener(TouchSurfaceEvent.DRAWING_END, onDrawEnd);
			}
			_touchSurface = s;
			_touchSurface.addEventListener(TouchSurfaceEvent.DRAWING_BEGIN, onDrawBegin);
			_touchSurface.addEventListener(TouchSurfaceEvent.DRAWING_MOVE, onDrawMove);
			_touchSurface.addEventListener(TouchSurfaceEvent.DRAWING_END, onDrawEnd);
		}
		
		public function set drawingSurface(s:IDrawingSurface):void
		{
			_drawingSurface = s;
		}
		
		
		
		protected function onDrawBegin(e:TouchSurfaceEvent):void {
			
			print(this, "onDrawBegin()", e.touchID, e.x, e.y);
			
			var lastTime:Number = _timeControl.lastTimeMilliseconds;
			var time:Number = _timeControl.currentTimeMilliseconds;
			
			_storage.startLineByID(e.touchID, e.x, e.y, time, time+3000);
		}
		
		protected function onDrawMove(e:TouchSurfaceEvent):void {
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
		
		protected function onDrawEnd(e:TouchSurfaceEvent):void {
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