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

	/**
	 * ...
	 * @author Romasty
	 */
	public class LoaderCommand extends Command
	{
		protected var _path : String;
		protected var _loader : Loader;
		
		protected var _appDomain : ApplicationDomain;

        protected var _onLoad : Function;
        private var _onError : Function;
		
		public function LoaderCommand(path : String, appDomain : ApplicationDomain = null) 
		{
			_path = path;
			_appDomain = appDomain;
		}
		
		override protected function run() : void
		{
			super.run();
			
			_loader = new Loader();
			assignListeners();
			
			var request : URLRequest = new URLRequest(_path);
			
			if(_appDomain == null) {
				_loader.load(request);
			} else {
				var context : LoaderContext = new LoaderContext(false, _appDomain);
				_loader.load(request, context);
			}
		}
		
		protected function assignListeners() : void
		{
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, onLoadStart);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		protected function removeListeners() : void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.OPEN, onLoadStart);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			_loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		
		
		
		
		protected function onLoadStart(e : Event) : void
		{
			dispatchEvent(e);
		}
		
		protected function onLoadProgress(e : ProgressEvent) : void
		{
			dispatchEvent(e);
		}
		
		protected function onLoadComplete(e : Event) : void
		{
			trace("onLoadComplete", _path);

            if(_onLoad) {
                _onLoad(this);
            }

			removeListeners();
			complete();
		}
		
		
		protected function onLoadError(e : IOErrorEvent) : void
		{
			trace(e);
            if(_onError) {
                _onError(this);
            }
            dispatchEvent(e);
		}
		
		protected function onSecurityError(e : SecurityErrorEvent) : void
		{
			trace(e);
            if(_onError) {
                _onError(this);
            }
            dispatchEvent(e);
		}
		
		
		
		
		public function get path() : String { 
			return _path; 
		}
		
		public function get loader() : Loader { 
			return _loader; 
		}


        public function set onLoad(value : Function) : void
        {
            _onLoad = value;
        }


        public function set onError(value:Function):void {
            _onError = value;
        }
    }

}