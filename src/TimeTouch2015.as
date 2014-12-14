package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import logger.disableTraceForClass;
	import logger.print;
	
	import timetouch.TimeTouch;
	import timetouch.timecontrol.FreeTimeControl;
	import timetouch.timecontrol.TimeControl;
	import timetouch.timecontrol.TimeControlEvent;
	import timetouch.view.DrawingView;
	import timetouch.view.DrawingViewEvent;
	import timetouch.view.TimeControlView;
	import timetouch.view.TimeControlViewEvent;
	
	public class TimeTouch2015 extends Sprite
	{
		
		private var engine:TimeTouch;
		
		/*
		*	VIEWS
		*/
		
		private var _timeControlView:TimeControlView;
		private var _drawingView:DrawingView;
		
		
		public function TimeTouch2015()
		{
			super();
			
			disableTraceForClass(TimeControlView);
			
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		protected function onStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			initEngine();
			initGUI();
			initLinkage();
			
		}
		
		
		private function initEngine():void
		{
			engine = new TimeTouch();
			engine.timeControl = new FreeTimeControl();
		}
				
		
		
		
		
		/*
		*
		*		GUI
		*
		*/
		
		
		
		private function initGUI():void
		{
			
			print(this, "initGUI()", stage.stageWidth, stage.stageHeight);
			
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.align = StageAlign.TOP_LEFT;
			
			var border:Sprite = new Sprite();
			border.graphics.lineStyle(2,0x880000);
			border.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			addChild(border);
			
			if (Multitouch.supportsTouchEvents) {
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			}
			
			// time view
			_timeControlView = new TimeControlView();
			_timeControlView.x = 10;
			_timeControlView.y = 10;
			addChild(_timeControlView);
			
			// drawing view
			_drawingView = new DrawingView(stage.stageWidth-20, stage.stageHeight-30-_timeControlView.height);
			_drawingView.x = _timeControlView.getBounds(this).x;
			_drawingView.y = _timeControlView.getBounds(this).bottom + 10;
			addChild(_drawingView);
			
		}
		
		
		
		
		/*
		*
		*		LINKAGES
		*
		*/
		
		private function initLinkage():void {
			
			// engine time -> time control view
			engine.timeControl.addEventListener(TimeControlEvent.UPDATE_TIME, onUpdateTime);
			
			// time control play/pause -> engine play/pause
			_timeControlView.addEventListener(TimeControlViewEvent.PLAY_PRESSED, onPlay);
			_timeControlView.addEventListener(TimeControlViewEvent.PAUSE_PRESSED, onPause);
			
			// time control play/pause -> engine FFD / REW
			_timeControlView.addEventListener(TimeControlViewEvent.FFD_PRESSING, onFFD);
			_timeControlView.addEventListener(TimeControlViewEvent.REW_PRESSING, onREW);
			
			// drawing view
			_drawingView.addEventListener(DrawingViewEvent.DRAWING_BEGIN, onDrawBegin);
			_drawingView.addEventListener(DrawingViewEvent.DRAWING_MOVE, onDrawMove);
			_drawingView.addEventListener(DrawingViewEvent.DRAWING_END, onDrawEnd);
		}
		
		protected function onUpdateTime(event:TimeControlEvent):void
		{
			_timeControlView.showTime = (event.target as TimeControl).currentTimeMilliseconds;
		}
		
		protected function onPause(event:TimeControlViewEvent):void
		{
			engine.timeControl.pause();
		}
		
		protected function onPlay(event:TimeControlViewEvent):void
		{
			engine.timeControl.play();
		}
		
		protected function onFFD(event:TimeControlViewEvent):void 
		{
			var add:Number = 100 - (engine.timeControl.playing ? (1000/stage.frameRate) : 0);
			engine.timeControl.setCurrentTimeMilliseconds(
				engine.timeControl.currentTimeMilliseconds + add );
		}
		
		protected function onREW(event:TimeControlViewEvent):void
		{
			var remove:Number = - 100 - (engine.timeControl.playing ? (1000/stage.frameRate) : 0);
			var newTime:Number = Math.max(0, engine.timeControl.currentTimeMilliseconds + remove);
			engine.timeControl.setCurrentTimeMilliseconds(newTime);
		}
		
		protected function onDrawBegin(e:DrawingViewEvent):void {
			print(this, "onDrawBegin()", e.touchID, e.localX, e.localY);
		}
		protected function onDrawMove(e:DrawingViewEvent):void {
			print(this, "onDrawMove()", e.touchID, e.localX, e.localY);
		}
		protected function onDrawEnd(e:DrawingViewEvent):void {
			print(this, "onDrawEnd()", e.touchID, e.localX, e.localY);
		}
		
	}
}