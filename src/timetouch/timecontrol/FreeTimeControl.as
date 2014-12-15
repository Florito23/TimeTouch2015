package timetouch.timecontrol
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getTimer;

	public class FreeTimeControl extends TimeControl
	{
	
		//TODO: Change into _systemTimeAtLastPlayOrLoop (for more accuracy)
		private var _systemTimeAtLastSetCurrentTime:Number;
		
		private var _timerMc:MovieClip;
		
		public function FreeTimeControl(clockMode:String)
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
				//print(this, "onFrame()", "playing", dt);
				setCurrentTimeMilliseconds(_currentTimeMilliseconds + dt);
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