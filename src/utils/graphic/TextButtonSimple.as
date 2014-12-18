package utils.graphic
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Multitouch;
	
	[Event(name="buttonTriggered", type="utils.graphic.TextButtonSimpleEvent")]
	[Event(name="buttonDragging", type="utils.graphic.TextButtonSimpleEvent")]
	[Event(name="buttonPressing", type="utils.graphic.TextButtonSimpleEvent")]
	
	
	public class TextButtonSimple extends Sprite
	{
		
		public static var LINE_THICKNESS:Number = 1;
		public static var LINE_COLOR:uint = 0x000000;
		
		public static var BACKGROUND:uint = 0xAAAAAA;
		public static var BACKGROUND_TOUCH:uint = 0xCCCCCC;
		
		public static var TEXTFORMAT_FONT:String = "Arial";
		public static var TEXTFORMAT_SIZE:* = 10;
		public static var TEXTFORMAT_COLOR:* = 0x000000;
		public static var TEXTFORMAT_BOLD:* = true;
		
		public static var LAST_TEXT_FORMAT:TextFormat = null;
		
		
		private var bgNormal:Sprite;
		private var bgTouch:Sprite;
		private var _tf:TextField;
		
		//private var _triggerEvent:Event;
		
		public function get triggerPos():Point {
			return _triggerPos.clone();
		}
		private var _triggerPos:Point = new Point();
		
		public function get currentPos():Point {
			return _currentPos.clone();
		}
		private var _currentPos:Point = new Point();
		
		public function get moved():Point {
			return new Point(_currentPos.x-_triggerPos.x, _currentPos.y-_triggerPos.y);
		}
		public function TextButtonSimple(text:String, w:Number=100, h:Number=20, x:Number=0, y:Number=0)
		{
			super();
			this.x = x;
			this.y = y;
			
			bgNormal = new Sprite();
			if (LINE_THICKNESS) {
				bgNormal.graphics.lineStyle(LINE_THICKNESS, LINE_COLOR);
			}
			bgNormal.graphics.beginFill(BACKGROUND);
			bgNormal.graphics.drawRoundRect(0,0,w,h,5,5);
			bgNormal.graphics.endFill();
			addChild(bgNormal);
			
			bgTouch = new Sprite();
			if (LINE_THICKNESS) {
				bgTouch.graphics.lineStyle(LINE_THICKNESS, LINE_COLOR);
			}
			bgTouch.graphics.beginFill(BACKGROUND_TOUCH);
			bgTouch.graphics.drawRoundRect(0,0,w,h,5,5);
			bgTouch.graphics.endFill();
			addChild(bgTouch);
			bgTouch.visible = false;
			
			_tf = new TextField();
			_tf.width = w;
			_tf.height = h;
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.multiline = false;
			_tf.wordWrap = false;
			
			var format:TextFormat = new TextFormat(TEXTFORMAT_FONT,TEXTFORMAT_SIZE,TEXTFORMAT_COLOR,TEXTFORMAT_BOLD);
			format.align = TextFormatAlign.CENTER;
			_tf.defaultTextFormat = format;
			LAST_TEXT_FORMAT = format;
			//print(this, "LAST_TEXT_FORMAT", LAST_TEXT_FORMAT);
			addChild(_tf);
			
			_tf.text = text;
			_tf.height = _tf.textHeight;
			_tf.y = (h-_tf.height)/2;
			_tf.height = h;
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		private function onStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			addTouchStartEvents();
		}
		
		
		private var _touchId:int = -1;
		private function addTouchStartEvents():void
		{
			if (Multitouch.supportsTouchEvents) {
				addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			} else {
				addEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin);
			}
		}
		private function removeTouchStartEvents():void
		{
			if (Multitouch.supportsTouchEvents) {
				removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			} else {
				removeEventListener(MouseEvent.MOUSE_DOWN, onTouchBegin);
			}
		}
		private function addTouchMoveEvents():void
		{
			if (Multitouch.supportsTouchEvents) {
				stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			} else {
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onTouchMove);
			}
		}
		private function removeTouchMoveEvents():void
		{
			if (Multitouch.supportsTouchEvents) {
				stage.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			} else {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onTouchMove);
			}	
		}
		private function addTouchEndEvents():void
		{
			if (Multitouch.supportsTouchEvents) {
				stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			} else {
				stage.addEventListener(MouseEvent.MOUSE_UP, onTouchEnd);
			}
		}
		private function removeTouchEndEvents():void
		{
			if (Multitouch.supportsTouchEvents) {
				stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			} else {
				stage.removeEventListener(MouseEvent.MOUSE_UP, onTouchEnd);
			}
		}
		
		
		private function onTouchBegin(e:Event):void {
			if (_touchId==-1) {
				//_triggerEvent = e;
				bgNormal.visible = false;
				bgTouch.visible = true;
				if (e is TouchEvent) {
					var te:TouchEvent = e as TouchEvent;
					_touchId = te.touchPointID;
					_triggerPos = globalToLocal(new Point(te.stageX, te.stageY)) 
				} else if (e is MouseEvent) {
					var me:MouseEvent = e as MouseEvent;
					_triggerPos = globalToLocal(new Point(me.stageX, me.stageY));
					_touchId = 0;
				} else {
					throw new Error("Illegal source");
				}
				
				removeTouchStartEvents();
				addTouchMoveEvents();
				addTouchEndEvents();
				
				if (!hasEventListener(Event.ENTER_FRAME)) {
					addEventListener(Event.ENTER_FRAME, onFramePressing);
				}
				
			}
		}
		
		private function onFramePressing(e:Event):void
		{
			dispatchEvent(new TextButtonSimpleEvent(TextButtonSimpleEvent.BUTTON_PRESSING));	
		}
		
		private function onTouchMove(e:Event):void
		{
			if (e is TouchEvent){
				var te:TouchEvent = e as TouchEvent;
				_currentPos = globalToLocal(new Point(te.stageX, te.stageY));
			} else if (e is MouseEvent) {
				var me:MouseEvent = MouseEvent(e);
				_currentPos = globalToLocal(new Point(me.stageX, me.stageY));
			} else {
				throw new Error("Illegal source");
			}
			dispatchEvent(new TextButtonSimpleEvent(TextButtonSimpleEvent.BUTTON_DRAGGING));
		}
		
		private function onTouchEnd(e:Event):void {
			if (_touchId!=-1) {
				var isTouchEnd:Boolean = true;
				if (e is TouchEvent) {
					var tid:int = (e as TouchEvent).touchPointID;
					if (_touchId != tid) {
						isTouchEnd = false;
					}
				}
				
				if (isTouchEnd) {
					_touchId = -1;
					if (e is TouchEvent){
						var te:TouchEvent = e as TouchEvent;
						_currentPos = globalToLocal(new Point(te.stageX, te.stageY));
					}else if (e is MouseEvent) {
						var me:MouseEvent = e as MouseEvent;
						_currentPos = globalToLocal(new Point(me.stageX, me.stageY));
					} else {
						throw new Error("Illegal source");
					}
					//removeEventListener(Event.ENTER_FRAME, onFrameDrag);
					bgNormal.visible = true;
					bgTouch.visible = false;
					
					addTouchStartEvents();
					removeTouchMoveEvents();
					removeTouchEndEvents();
					if (hasEventListener(Event.ENTER_FRAME)) {
						removeEventListener(Event.ENTER_FRAME, onFramePressing);
					}
					
					dispatchEvent(new TextButtonSimpleEvent(TextButtonSimpleEvent.BUTTON_TRIGGERED));
				}
			}
		}
		
		public function set text(value:String):void
		{
			_tf.text = value;
		}
		
		public function set textFormat(textFormat:TextFormat):void
		{
			_tf.defaultTextFormat = textFormat;
		}
		
	}
}
