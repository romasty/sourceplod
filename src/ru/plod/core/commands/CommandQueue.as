package ru.plod.core.commands
{
	public class CommandQueue extends CommandPool
	{
		protected var _locked:Boolean;

		public function CommandQueue(locked:Boolean = false)
		{
			_locked = locked;
			super();
		}

		override public function add(cmd:ICommand, atIndex:int = -1):void
		{
			super.add(cmd, atIndex);
			run();
		}

		protected function run():void
		{
			if (_commands.length > 0 && !_running && !_locked)
			{
				_running = true;
				executeNext();
			}
		}

		override protected function commandComplete(cmd:ICommand):void
		{
			_running = false;
			super.commandComplete(cmd);
			run();
		}

		public function lock():void
		{
			_locked = true;
		}

		public function unlock():void
		{
			_locked = false;
			run();
		}
	}
}