package com.palDeveloppers.ane
{
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	public class Appirater
	{
		private static var _instance:Appirater;
		private static var _canInstatiate:Boolean;
		
		private var extCtx:ExtensionContext = null;
		
		private var _alertDisplayed:Function;
		private var _declinedToRate:Function;
		private var _didOptToRate:Function;
		private var _didOptToRemindLater:Function;
		
		public function Appirater()
		{
			if (!_canInstatiate)
				throw Error("Singleton, use instance property");
			
			extCtx = ExtensionContext.createExtensionContext("com.palDeveloppers.ane.Appirater", null);
			if (extCtx != null)
			{
				extCtx.addEventListener(StatusEvent.STATUS, onStatus);
			} 
			else
			{
				trace('[Appirater-ANE] Error - Extension Context is null.');
			}
		}
		
		public static function get instance():Appirater
		{
			if (_instance == null)
			{
				_canInstatiate = true;
				
				_instance = new Appirater();
				
				_canInstatiate = false;
			}
			
			return _instance;
		}
		
		public function get didOptToRemindLater():Function
		{
			return _didOptToRemindLater;
		}
		
		public function set didOptToRemindLater(value:Function):void
		{
			_didOptToRemindLater = value;
		}
		
		public function get didOptToRate():Function
		{
			return _didOptToRate;
		}
		
		public function set didOptToRate(value:Function):void
		{
			_didOptToRate = value;
		}
		
		public function get declinedToRate():Function
		{
			return _declinedToRate;
		}
		
		public function set declinedToRate(value:Function):void
		{
			_declinedToRate = value;
		}
		
		public function get alertDisplayed():Function
		{
			return _alertDisplayed;
		}
		
		public function set alertDisplayed(value:Function):void
		{
			_alertDisplayed = value;
		}
				
		public static function isSupported():Boolean
		{
			return Capabilities.os.toLowerCase().indexOf("ip") > -1;
		}
		
		public function appEnteredForeground(canPromptForRating:Boolean):void
		{
			extCtx.call("appEnteredForeground", canPromptForRating);
		}
		
		public function userDidSignificantEvent(canPromptForRating:Boolean):void
		{
			extCtx.call("userDidSignificantEvent", canPromptForRating);
		}
		
		public function rateApp():void
		{
			extCtx.call("rateApp");
		}
		
		public function setAppId(value:String):void
		{
			extCtx.call("setAppId", value);
		}
		
		public function setDaysUntilPrompt(value:Number):void
		{
			extCtx.call("setDaysUntilPrompt", value);
		}
		
		public function setUsesUntilPrompt(value:int):void
		{
			extCtx.call("setUsesUntilPrompt", value);
		}
		
		public function setSignificantEventsUntilPrompt(value:int):void
		{
			extCtx.call("setSignificantEventsUntilPrompt", value);
		}
		
		public function setTimeBeforeReminding(days:Number):void
		{
			extCtx.call("setTimeBeforeReminding", days);
		}
		
		public function setDebug(value:Boolean):void
		{
			extCtx.call("setDebug", value);
		}
		
		private function onStatus( event : StatusEvent ) : void
		{
			switch (event.code) {
				case "alertDisplayed":
					if (_alertDisplayed != null)
						_alertDisplayed();
					
					break;
				
				case "declinedToRate":
					if (_declinedToRate != null)
						_declinedToRate();
					
					break;
					
				case "didOptToRate":
					if (_didOptToRate != null)
						_didOptToRate();
						
					break;
				
				case "didOptToRemindLater":
					if (_didOptToRemindLater != null)
						_didOptToRemindLater();
					
					break;
			}
		}

	}
}
