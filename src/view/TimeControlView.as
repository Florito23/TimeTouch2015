package view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Multitouch;
	
	import logger.print;
	
	import utils.graphic.TextButton;
	import utils.graphic.TextButtonSimple;
	import utils.graphic.TextButtonSimpleEvent;
	import utils.math.timeFormat;
	
	[Event(name="pausePressed", type="view.TimeControlViewEvent")]
	[Event(name="playPressed", type="view.TimeControlViewEvent")]
	
	[Event(name="ffdPressing", type="view.TimeControlViewEvent")]
	[Event(name="rewPressing", type="view.TimeControlViewEvent")]
	
	[Event(name="loopOnPressed", type="view.TimeControlViewEvent")]
	[Event(name="loopOffPressed", type="view.TimeControlViewEvent")]
	
	[Event(name="inpointMoved", type="view.TimeControlViewEvent")]
	[Event(name="outpointMoved", type="view.TimeControlViewEvent")]
	
	
	public class TimeControlView extends MovieClip
	{
		
		private var _pauseButton:TextButtonSimple;
		private var _playButton:TextButtonSimple;
		private var _revButton:TextButtonSimple;
		private var _ffdButton:TextButtonSimple;
		private var _timeField:TextField;
		
		private var _loopOnButton:TextButtonSimple;
		private var _loopOffButton:TextButtonSimple;
		
		private var _inPointButton:TextButtonSimple;
		private var _outPointButton:TextButtonSimple;
		
		public function TimeControlView()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		protected function onStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			initGUI();
		}
		
		private function initGUI():void
		{
			
			TextButton.TEXTFORMAT_SIZE = 8;
			
			
			_pauseButton = new TextButtonSimple("PAUSE",40,15,5,5);
			_pauseButton.addEventListener(TextButtonSimpleEvent.BUTTON_TRIGGERED, onPause);
			_pauseButton.visible = false;
			addChild(_pauseButton);
			
			
			
			_playButton = new TextButtonSimple("PLAY",40,15,5,5);
			_playButton.addEventListener(TextButtonSimpleEvent.BUTTON_TRIGGERED, onPlay);
			_playButton.visible = true;
			addChild(_playButton);
			
			
			
			_revButton = new TextButtonSimple("<<<",25,15,_playButton.getBounds(this).right+5,5);
			_revButton.addEventListener(TextButtonSimpleEvent.BUTTON_PRESSING, function(e:Event):void {
				dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.REW_PRESSING));
			});
			addChild(_revButton);
			
			
			
			_ffdButton = new TextButtonSimple(">>>",25,15,_revButton.getBounds(this).right+5,5);
			_ffdButton.addEventListener(TextButtonSimpleEvent.BUTTON_PRESSING, function(e:Event):void {
				dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.FFD_PRESSING));
			});
			addChild(_ffdButton);
			
			
			
			_timeField = new TextField();
			//trace(TextButtonSimple.LAST_TEXT_FORMAT);
			var tf:TextFormat = TextButtonSimple.LAST_TEXT_FORMAT;
			tf.align = TextFormatAlign.LEFT;
			_timeField.defaultTextFormat = tf;//TextButtonSimple.LAST_TEXT_FORMAT;
			_timeField.text = "Time = 0:00.00";
			_timeField.selectable = false;
			_timeField.x = _ffdButton.getBounds(this).right+5;
			_timeField.y = 5;
			_timeField.width = _timeField.textWidth;
			_timeField.height = 20;
			addChild(_timeField);
			
			
			
			
			_loopOffButton = new TextButtonSimple("LOOP OFF", 50, 15, _timeField.getBounds(this).right + 10, 5);
			_loopOffButton.addEventListener(TextButtonSimpleEvent.BUTTON_TRIGGERED, onLoopOffButton);
			addChild(_loopOffButton);
			
			_loopOnButton = new TextButtonSimple("LOOP ON", 50, 15, _timeField.getBounds(this).right + 10, 5);
			_loopOnButton.addEventListener(TextButtonSimpleEvent.BUTTON_TRIGGERED, onLoopOnButton);
			_loopOnButton.visible = false;
			addChild(_loopOnButton);
			
			_inPointButton = new TextButtonSimple("IN: ", 60,15,_loopOnButton.getBounds(this).right + 5, 5);
			_inPointButton.addEventListener(TextButtonSimpleEvent.BUTTON_DRAGGING, onInPointPressing);
			addChild(_inPointButton);
			
			_outPointButton = new TextButtonSimple("OUT: ", 60,15,_inPointButton.getBounds(this).right + 5, 5);
			_outPointButton.addEventListener(TextButtonSimpleEvent.BUTTON_DRAGGING, onOutPointPressing);
			addChild(_outPointButton);
			
			//setLoopInButton(0);
			//setLoopOutButton(5000);
			
			var bg:CurvedBackground = new CurvedBackground(0,0,_outPointButton.getBounds(this).right+5, _ffdButton.getBounds(this).bottom+5);
			addChildAt(bg, 0);
			
		}
		
		
		protected function onPlay(event:Event):void
		{
			print(this, "onPlay()");
			_pauseButton.visible = true;
			_playButton.visible = false;
			dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.PLAY_PRESSED));
		}
		
		protected function onPause(event:Event):void
		{
			print(this, "onPause()");
			_pauseButton.visible = false;
			_playButton.visible = true;
			dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.PAUSE_PRESSED));
		}
		
		
		public function set showTime(ms:Number):void
		{
			
			var sms:String = ((ms/1000)%1.0).toFixed(3);
			var allSeconds:int = int(ms/1000);
			var seconds:int = allSeconds % 60;
			var minutes:int = int(allSeconds / 60);
			var ss:String = (seconds<10 ? "0" : "") + seconds;
			var mm:String = sms.substr(2);//.substr(2);
			_timeField.text = "Time = "+minutes+":"+ss+"."+mm;
		}
		
		
		private function onLoopOnButton(e:Event):void
		{
			_loopOnButton.visible = false;
			_loopOffButton.visible = true;
			dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.LOOP_ON_PRESSED));
		}
		
		private function onLoopOffButton(e:Event):void
		{
			_loopOnButton.visible = true;
			_loopOffButton.visible = false;
			dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.LOOP_OFF_PRESSED));
		}
		
		
		protected function onInPointPressing(event:TextButtonSimpleEvent):void
		{
			var tb:TextButtonSimple = event.target as TextButtonSimple;
			var e:TimeControlViewEvent = new TimeControlViewEvent(TimeControlViewEvent.INPOINT_MOVED);
			e.deltaTime = tb.moved.x;// * 0.5;
			dispatchEvent(e);
		}		
		
		public function setLoopInButton(loopIn:Number):void
		{
			var txt:String = "IN: "+timeFormat(loopIn);
			_inPointButton.text = txt;
		}
		
		protected function onOutPointPressing(event:TextButtonSimpleEvent):void
		{
			var tb:TextButtonSimple = event.target as TextButtonSimple;
			var e:TimeControlViewEvent = new TimeControlViewEvent(TimeControlViewEvent.OUTPOINT_MOVED);
			e.deltaTime = tb.moved.x;// * 0.5;
			dispatchEvent(e);
		}		
		
		public function setLoopOutButton(loopIn:Number):void
		{
			var txt:String = "OUT: "+timeFormat(loopIn);
			_outPointButton.text = txt;
		}
		
		
	}
}