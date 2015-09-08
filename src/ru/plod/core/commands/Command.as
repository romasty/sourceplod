package ru.plod.core.commands
{
	import flash.errors.IllegalOperationError;

	import ru.plod.broadcaster.Broadcaster;
	import ru.plod.broadcaster.IBroadcast;

	public class Command implements ICommand
	{
		protected const _eventComplete : Broadcaster = new Broadcaster(this);

		public static const PURE:int = 0;
		public static const RUNNING:int = 1;
		public static const COMPLETED:int = 2;

		protected var _isAsync:Boolean = false;
		private var _status:int = PURE;

		public function get eventComplete():IBroadcast
		{
			return _eventComplete;
		}

		public function Command()
		{
			//..
		}

		final public function execute():void
		{
			if (_status == PURE)
			{
				_status = RUNNING;
				run();
			}
			else
			{
				throw(new IllegalOperationError("Error! Command is stale! " + this));
			}
		}

		protected function run():void
		{
			//..
		}

		final protected function complete():void
		{
			_status = COMPLETED;
			_eventComplete.broadcast();
		}

		public function get isAsync():Boolean
		{
			return _isAsync;
		}

		public function get status():int
		{
			return _status;
		}
	}
}