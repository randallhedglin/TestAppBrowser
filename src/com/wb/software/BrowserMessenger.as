package com.wb.software
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class BrowserMessenger extends WBMessenger
	{
		// calling class
		private var m_caller :TestAppBrowser = null;
		
		// default constructor
		public function BrowserMessenger(caller       :TestAppBrowser,
										 swfWidth     :int,
										 swfHeight    :int,
										 swfFrameRate :int)
		{
			// defer to superclass
			super(swfWidth,
				  swfHeight,
				  swfFrameRate);
			
			// save caller
			m_caller = caller;
		}
		
		// send() -- override specific to this app
		override public function send(message :String, ...argv) :int
		{
			// verify caller
			if(!m_caller)
				return(0);
			
			// check message
			if(message)
			{
				// process message
				switch(message)
				{
				// getLongestDisplaySide()
				case("getLongestDisplaySide"):
					
					// get width & height
					var w :int = m_caller.stage.stageWidth;
					var h :int = m_caller.stage.stageHeight;
					
					// return longest side
					return((w > h) ? w : h);
						
				// messageBox()
				case("messageBox"):
						
					// check content
					if(argv.length != 2)
						break;
						
					// prepare message box
					var url:URLRequest = new URLRequest(
						"javascript:alert(\"" +
						(argv[1] as String)   +
						"\");");
						
					// display message box
					navigateToURL(url, "_self");
						
					// ok
					return(1);
				}
			}
			
			// throw error
			throw new Error("com.wb.software.BrowserMessenger.send(): " +
				"Internal message cannot be sent due to invalid data: " +
				message);
			
			// failed
			return(0);
		}
	}
}