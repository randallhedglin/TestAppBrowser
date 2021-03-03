package com.wb.software 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="640", height="480", frameRate="60")]

	public final class TestAppBrowser extends Sprite
	{
		// swf metadata values (must match above!)
		private const SWF_WIDTH     :int = 640;
		private const SWF_HEIGHT    :int = 480;
		private const SWF_FRAMERATE :int = 60;

		// stored objects
		private var m_app       :TestApp     = null;
		private var m_messenger :WBMessenger = null;

		// launch image
		[Embed(source="../../../../LaunchImg.png", mimeType="image/png")]
		private var LaunchImage :Class;

		// default constructor
		public function TestAppBrowser()
		{
			// defer to superclass
			super();
			
			// load launch image
			var launchImg :Bitmap = new LaunchImage();
			
			// create messenger
			m_messenger = new BrowserMessenger(this,
											   SWF_WIDTH,
											   SWF_HEIGHT,
											   SWF_FRAMERATE);
			
			// create main app
			m_app = new TestApp(this,
								m_messenger,
								WBEngine.OSFLAG_BROWSER,
								false, // renderWhenIdle
								launchImg,
								true); // testMode
			
			// listen for added-to-stage
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		// getApp() -- get reference to base app
		public function getApp() :TestApp
		{
			// return object
			return(m_app);
		}
		
		// onAddedToStage() -- callback for added-to-stage notification
		private function onAddedToStage(e :Event) :void
		{
			// listen for resize events
			addEventListener(Event.RESIZE, onResize);
			
			// initialize app
			if(m_app)
				m_app.init();
		}
		
		// onResize() -- callback for resize events
		private function onResize(e :Event) :void
		{
			// pass to app
			if(m_app)
				m_app.onResize(e);
		}
	}
}
