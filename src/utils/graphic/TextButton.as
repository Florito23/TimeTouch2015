package utils.graphic
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class TextButton extends SimpleButton
	{
		
		public static var LINE_THICKNESS:Number = 1;
		public static var LINE_COLOR:uint = 0x000000;
		
		public static var BACKGROUND_UP:uint = 0xAAAAAA;
		public static var BACKGROUND_OVER:uint = 0xCCCCCC;
		public static var BACKGROUND_DOWN:uint = 0x888888;
		
		public static var TEXTFORMAT_FONT:String = "Arial";
		public static var TEXTFORMAT_SIZE:* = 10;
		public static var TEXTFORMAT_COLOR:* = 0x000000;
		public static var TEXTFORMAT_BOLD:* = true;
		
		public static var LAST_TEXT_FORMAT:TextFormat = null;
		
		private static const UP:String = "up";
		private static const OVER:String = "over";
		private static const DOWN:String = "down";
		private static const TEST:String = "test";
		
		
		private var _textfields:Vector.<TextField> = new Vector.<TextField>();
		
		public function TextButton(text:String, w:Number=100, h:Number=20, x:Number=0, y:Number=0)
		{
			var up:Sprite = create(text,w,h,UP);
			var over:Sprite = create(text,w,h,OVER);
			var down:Sprite = create(text,w,h,DOWN);
			var hitTest:Sprite = create(text,w,h,TEST);
			super(up, over, down, hitTest);//upState, overState, downState, hitTestState);
			this.x = x;
			this.y = y;
		}
		
		public function set text(value:String):void
		{
			for (var i:int=0;i<_textfields.length;i++) {
				_textfields[i].text=value;
			}
			
		}
		
		public function set textFormat(textFormat:TextFormat):void
		{
			for (var i:int=0;i<_textfields.length;i++) {
				_textfields[i].defaultTextFormat = textFormat;
			}
		}
		
		private function create(text:String, w:Number, h:Number, which:String):Sprite
		{
			var out:Sprite = new Sprite();
			
			var bg:Sprite = new Sprite();
			var col:uint;
			switch(which)
			{
				case UP: col=BACKGROUND_UP; break;
				case OVER: col=BACKGROUND_OVER; break;
				case TEST:
				case DOWN: col=BACKGROUND_DOWN; break;
			}
			if (LINE_THICKNESS) {
				bg.graphics.lineStyle(LINE_THICKNESS, LINE_COLOR);
			}
			bg.graphics.beginFill(col);
			bg.graphics.drawRoundRect(0,0,w,h,5,5);
			bg.graphics.endFill();
			out.addChild(bg);
			
			if (which!=TEST) {
				var tf:TextField = new TextField();
				tf.width = w;
				tf.height = h;
				tf.selectable = false;
				tf.mouseEnabled = false;
				tf.multiline = false;
				tf.wordWrap = false;
				//tf.border = true;
				_textfields.push(tf);
				var format:TextFormat = new TextFormat(TEXTFORMAT_FONT,TEXTFORMAT_SIZE,TEXTFORMAT_COLOR,TEXTFORMAT_BOLD);
				format.align = TextFormatAlign.CENTER;
				tf.defaultTextFormat = format;
				LAST_TEXT_FORMAT = format;
				out.addChild(tf);
				
				tf.text = text;
				tf.height = tf.textHeight;
				tf.y = (h-tf.height)/2;
				tf.height = h;
				//tf.cacheAsBitmap = true;
			}
			return out;
		}		
		
	}
}
