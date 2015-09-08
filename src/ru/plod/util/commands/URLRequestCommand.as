package ru.plod.util.commands
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import ru.plod.core.commands.Command;

	public class URLRequestCommand extends Command
	{

		protected var _urlLoader:URLLoader;
		protected var _request:URLRequest;
		private var _onLoadComplete:Function;
		private var _dataFormat:String;

		public function URLRequestCommand(request:URLRequest, dataFormat:String)
		{
			if (request == null)
			{
				throw new ArgumentError("URLRequest is null!");
			}
			_request = request;
			_dataFormat = dataFormat;
		}


		override protected function run():void
		{
			super.run();

			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = _dataFormat;
			assignListeners();
			_urlLoader.load(_request)
		}

		protected function assignListeners():void
		{
			_urlLoader.addEventListener(Event.OPEN, onLoadStartHandler);
			_urlLoader.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
		}


		protected function removeListeners():void
		{
			_urlLoader.removeEventListener(Event.OPEN, onLoadStartHandler);
			_urlLoader.removeEventListener(Event.COMPLETE, onLoadCompleteHandler);
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
		}


		public function set onLoadComplete(value:Function):void
		{
			_onLoadComplete = value;
		}

		public function get data():Object
		{
			return _urlLoader.data;
		}

		protected function onLoadStartHandler(e:Event):void
		{
		}


		protected function onLoadCompleteHandler(e:Event):void
		{
			removeListeners();
			if (_onLoadComplete)
			{
				_onLoadComplete(data);
			}
			complete();
		}


		protected function onIOErrorHandler(e:IOErrorEvent):void
		{
			removeListeners();
			//TODO: do.
		}

		protected function onSecurityErrorHandler(e:SecurityErrorEvent):void
		{
			removeListeners();
			//TODO: do.
		}
	}
}