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
	import timetouch.linestorage.Storage;
	import timetouch.timecontrol.TimeControl;
	import timetouch.timecontrol.TimeControlEvent;
	
	import view.CurvedBackground;
	import view.DrawingSurface;
	import view.TimeControlView;
	import view.TimeControlViewEvent;
	
	public class TimeTouch2015 extends Sprite
	{
		
		private var engine:TimeTouch;
		
		/*
		*	VIEWS
		*/
		
		private var _timeControlView:TimeControlView;
		
		
		public function TimeTouch2015()
		{
			super();
			
			disableTraceForClass(TimeControlView);
			disableTraceForClass(TimeTouch);
			disableTraceForClass(Storage);
			
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
			//engine.timeControl = new DefaultTimeControl(TimeControl.EXTERNAL_CLOCK);
			
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
			_timeControlView.setLoopInButton(engine.timeControl.loopIn);
			_timeControlView.setLoopOutButton(engine.timeControl.loopOut);
			addChild(_timeControlView);
			
			// touch view
			var touch:CurvedBackground = new CurvedBackground(0,0,stage.stageWidth-20, stage.stageHeight-30-_timeControlView.height);
			touch.x = _timeControlView.getBounds(this).x;
			touch.y = _timeControlView.getBounds(this).bottom + 10;
			addChild(touch);
			
			// drawing view
			var drawingView:DrawingSurface = new DrawingSurface();
			drawingView.x = touch.x;
			drawingView.y = touch.y;
			addChild(drawingView);
			
			// set engine drawing / touch
			engine.touchSurface = touch;
			engine.drawingSurface = drawingView;
			
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
			
			// time control loop
			_timeControlView.addEventListener(TimeControlViewEvent.LOOP_OFF_PRESSED, onLoopOff);
			_timeControlView.addEventListener(TimeControlViewEvent.LOOP_ON_PRESSED, onLoopOn);
			
			// time control inpoint
			_timeControlView.addEventListener(TimeControlViewEvent.INPOINT_MOVED, onInpointMove);
			_timeControlView.addEventListener(TimeControlViewEvent.OUTPOINT_MOVED, onOutpointMove);
			
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		
		protected function onFrame(event:Event):void
		{
			engine.render();
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
		
		protected function onLoopOff(event:TimeControlViewEvent):void
		{
			engine.timeControl.loop = true;
		}
		
		protected function onLoopOn(event:TimeControlViewEvent):void
		{
			engine.timeControl.loop = false;
		}
		
		
		protected function onInpointMove(event:TimeControlViewEvent):void
		{
			engine.timeControl.loopIn += event.deltaTime;
			_timeControlView.setLoopInButton(engine.timeControl.loopIn);
		}
		
		protected function onOutpointMove(event:TimeControlViewEvent):void
		{
			engine.timeControl.loopOut += event.deltaTime;
			_timeControlView.setLoopOutButton(engine.timeControl.loopOut);
		}
		
		
		
		
		
	}
}