package timetouch
{
	import flash.events.EventDispatcher;
	
	import logger.print;
	
	import timetouch.linestorage.LineStorage;
	import timetouch.linestorage.LineVO;
	import timetouch.surface.DrawingSurface;
	import timetouch.surface.DrawingSurfaceEvent;
	import timetouch.timecontrol.TimeControl;
	import timetouch.timecontrol.TimeControlEvent;
	
	public class TimeTouch extends EventDispatcher
	{
		
		private var _timeControl:TimeControl;
		private var _drawingSurface:DrawingSurface;
		
		private var _storage:LineStorage;
		private var _creatingLines:LineStorage;		

		public function TimeTouch()
		{
			super();
			
			_storage = new LineStorage();
			_creatingLines = new LineStorage();
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
		
		protected function onUpdateTime(event:TimeControlEvent):void
		{
			//trace("onUpdateTime()",(event.target as AbstractTimeControl).currentMilliseconds);
			//TODO:
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
			var time:Number = _timeControl.currentTimeMilliseconds;
			_creatingLines.startLineByID(e.touchID, e.x, e.y, time);
		}
		
		protected function onDrawMove(e:DrawingSurfaceEvent):void {
			print(this, "onDrawMove()", e.touchID, e.x, e.y);
			var time:Number = _timeControl.currentTimeMilliseconds;
			_creatingLines.continueLineByID(e.touchID, e.x, e.y, time);
		}
		protected function onDrawEnd(e:DrawingSurfaceEvent):void {
			print(this, "onDrawEnd()", e.touchID, e.x, e.y);
			var time:Number = _timeControl.currentTimeMilliseconds;
			var line:LineVO = _creatingLines.finishLineByID(e.touchID, e.x, e.y, time);
			_storage.addLine(line);
		}
		
	}
}