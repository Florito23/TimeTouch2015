package utils.math
{
	public function timeFormat(ms:Number):String
	{
		
		var justSeconds:Number = (ms/1000)%60.0;
		var justMinutes:int = int(ms/60000);
		
		var ss:String = (justSeconds<10 ? "0":"") + justSeconds.toFixed(2);
		var mm:String = String(justMinutes);
		
		return mm+":"+ss;
		
	}
	
}