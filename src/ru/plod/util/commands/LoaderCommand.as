package ru.plod.util.commands
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	import ru.plod.core.commands.Command;

	public class LoaderCommand extends Command
	{
		protected var _path:String;
		protected var _loader:Loader;

		protected var _appDomain:ApplicationDomain;

		protected var _onLoadComplete:Function;
		private var _onError:Function;

		public function LoaderCommand(path:String, appDomain:ApplicationDomain = null)
		{
			_path = path;
			_appDomain = appDomain;
		}

		override protected function run():void
		{
			super.run();

			_loader = new Loader();
			assignListeners();

			var request:URLRequest = new URLRequest(_path);

			if (_appDomain == null)
			{
				_loader.load(request);
			}
			else
			{
				var context:LoaderContext = new LoaderContext(false, _appDomain);
				_loader.load(request, context);
			}
		}

		protected function assignListeners():void
		{
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, onLoadStartHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
		}

		protected function removeListeners():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.OPEN, onLoadStartHandler);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgressHandler);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadCompleteHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadErrorHandler);
			_loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
		}


		protected function onLoadStartHandler(e:Event):void
		{
		}

		protected function onLoadProgressHandler(e:ProgressEvent):void
		{
		}

		protected function onLoadCompleteHandler(e:Event):void
		{
			if (_onLoadComplete)
			{
				_onLoadComplete(this);
			}

			removeListeners();
			complete();
		}


		protected function onLoadErrorHandler(e:IOErrorEvent):void
		{
			if (_onError)
			{
				_onError(this);
			}
		}

		protected function onSecurityErrorHandler(e:SecurityErrorEvent):void
		{
			if (_onError)
			{
				_onError(this);
			}
		}


		public function get path():String
		{
			return _path;
		}

		public function get loader():Loader
		{
			return _loader;
		}


		public function set onLoadComplete(value:Function):void
		{
			_onLoadComplete = value;
		}


		public function set onError(value:Function):void
		{
			_onError = value;
		}
	}

}