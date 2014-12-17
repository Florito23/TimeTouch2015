package timetouch.timecontrol
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class DefaultTimeControl extends TimeControl
	{
	
		//TODO: Change into _systemTimeAtLastPlayOrLoop (for more accuracy)
		private var _systemTimeAtLastSetCurrentTime:Number;
		
		private var _timerMc:MovieClip;
		
		public function DefaultTimeControl(clockMode:String)
		{
			super(clockMode);
			_currentTimeMilliseconds = 0;
			_lastTimeMilliseconds = 0;
			_systemTimeAtLastSetCurrentTime = getTimer();
			if (clockMode==INTERNAL_CLOCK) {
				_timerMc = new MovieClip();
				_timerMc.addEventListener(Event.ENTER_FRAME, updateTime);
			}
		}
		
		override public function updateTime(event:Event = null):void
		{
			var ti:Number = getTimer();
			if (_playing) {
				var dt:Number = ti - _systemTimeAtLastSetCurrentTime;
				var newTime:Number = _currentTimeMilliseconds + dt;
				//print(this, "onFrame()", "playing", dt);
				if (newTime>10000) {
					newTime = 0;
				}
				setCurrentTimeMilliseconds(newTime);
			} else {
				_systemTimeAtLastSetCurrentTime = ti;
			}
			
			dispatchEvent(new TimeControlEvent(TimeControlEvent.UPDATE_TIME));
		}
		
		override public function setCurrentTimeMilliseconds(milliseconds:Number):Boolean
		{
			_systemTimeAtLastSetCurrentTime = getTimer();
			_lastTimeMilliseconds = _currentTimeMilliseconds;
			_currentTimeMilliseconds = milliseconds;
			return true;
		}
		
		override public function pause():void
		{
			_playing = false;
			super.pause();
		}
		
		override public function play():void
		{
			_playing = true;
			super.play();
		}
		
		
	}
}