package timetouch.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Multitouch;
	
	import logger.print;
	
	import timetouch.timecontrol.TimeControlEvent;
	
	import utils.graphic.TextButton;
	import utils.graphic.TextButtonSimple;
	import utils.graphic.TextButtonSimpleEvent;
	
	[Event(name="pausePressed", type="timetouch.view.TimeControlViewEvent")]
	[Event(name="playPressed", type="timetouch.view.TimeControlViewEvent")]
	
	[Event(name="ffdPressing", type="timetouch.view.TimeControlViewEvent")]
	[Event(name="rewPressing", type="timetouch.view.TimeControlViewEvent")]
	
	public class TimeControlView extends MovieClip
	{
		
		private var _pauseButton:TextButtonSimple;
		private var _playButton:TextButtonSimple;
		private var _revButton:TextButtonSimple;
		private var _ffdButton:TextButtonSimple;
		private var _timeField:TextField;
		
		private var _revPressing:Boolean = false;
		private var _ffdPressing:Boolean = false;
		
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
			if (Multitouch.supportsTouchEvents) {
				_revButton.addEventListener(TouchEvent.TOUCH_BEGIN, onRevBegin);
				_revButton.addEventListener(TouchEvent.TOUCH_END, onRevEnd);
				_revButton.addEventListener(TouchEvent.TOUCH_OUT, onRevEnd);
			} else {
				_revButton.addEventListener(MouseEvent.MOUSE_DOWN, onRevBegin);
				stage.addEventListener(MouseEvent.MOUSE_UP, onRevEnd);
			}
			addChild(_revButton);
			
			
			
			_ffdButton = new TextButtonSimple(">>>",25,15,_revButton.getBounds(this).right+5,5);
			if (Multitouch.supportsTouchEvents) {
				_ffdButton.addEventListener(TouchEvent.TOUCH_BEGIN, onFfdBegin);
				_ffdButton.addEventListener(TouchEvent.TOUCH_END, onFfdEnd);
				_ffdButton.addEventListener(TouchEvent.TOUCH_OUT, onFfdEnd);
			} else {
				_ffdButton.addEventListener(MouseEvent.MOUSE_DOWN, onFfdBegin);
				stage.addEventListener(MouseEvent.MOUSE_UP, onFfdEnd);
			}
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
			
			
			var bg:CurvedBackground = new CurvedBackground(0,0,_timeField.getBounds(this).right+5, _ffdButton.getBounds(this).bottom+5);
			addChildAt(bg, 0);
			
			
			addEventListener(Event.ENTER_FRAME, onFrame);
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
		
		protected function onRevBegin(e:Event):void
		{
			_revPressing = true;
		}
		protected function onRevEnd(e:Event):void
		{
			_revPressing = false;
		}
		protected function onFfdBegin(e:Event):void
		{
			_ffdPressing = true;
		}
		protected function onFfdEnd(e:Event):void
		{
			_ffdPressing = false;
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
		
		
		private function onFrame(e:Event):void
		{
			if (_revPressing) {
				print(this, "onFrame()", "revPressing");
				dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.REW_PRESSING));
			}
			if (_ffdPressing) {
				print(this, "onFrame()", "ffdPressing");
				dispatchEvent(new TimeControlViewEvent(TimeControlViewEvent.FFD_PRESSING));
			}
		}
	}
}