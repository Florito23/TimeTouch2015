package logger
{
	import avmplus.getQualifiedClassName;

	public function disableTraceForClass(c:Class):void
	{
		
		var cn:String = getQualifiedClassName(c);
		
		if (Tracer.qualifiedClassNamesThatDontTrace.indexOf(cn)==-1) {
			Tracer.qualifiedClassNamesThatDontTrace.push(cn);
		}
		
	}
	
}