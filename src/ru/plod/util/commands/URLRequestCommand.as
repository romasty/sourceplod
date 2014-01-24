package ru.plod.util.commands {
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;

    import flash.net.URLLoaderDataFormat;

    import flash.net.URLRequest;

	import ru.plod.core.commands.Command;


	public class URLRequestCommand extends Command {

        protected var _urlLoader : URLLoader;
        protected var _request : URLRequest;
        private var _onLoad : Function;
		private var _dataFormat : String;

        public function URLRequestCommand(request : URLRequest, dataFormat : String)
        {
            if(request == null) {
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
            _urlLoader.addEventListener(Event.OPEN, onLoadStart);
            _urlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
            _urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }


        protected function removeListeners():void
        {
            _urlLoader.removeEventListener(Event.OPEN, onLoadStart);
            _urlLoader.removeEventListener(Event.COMPLETE, onLoadComplete);
            _urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
            _urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }




        protected function onLoadStart(e : Event) : void
		{
			dispatchEvent(e);
		}



        protected function onLoadComplete(e : Event):void
        {
            removeListeners();
            if(_onLoad) {
                _onLoad(data);
            }
            complete();
        }


        protected function onIOError(e : IOErrorEvent):void
        {
            removeListeners();
            //TODO: do.
        }

        protected function onSecurityError(e : SecurityErrorEvent):void
        {
            removeListeners();
            //TODO: do.
        }


        public function set onLoad(value:Function):void {
            _onLoad = value;
        }

        public function get data():Object
        {
            return _urlLoader.data;
        }

    }
}