package ru.plod.core.commands
{
	public class MacroCommandQueued extends Command implements IMacroCommand
	{
		protected var _queue:CommandQueue;

		public function MacroCommandQueued(commands:Vector.<ICommand> = null)
		{
			init(commands);
		}

		protected function init(commands:Vector.<ICommand>):void
		{
			_queue = new CommandQueue(true);
			_queue.onCommandComplete = commandComplete;
			_queue.addList(commands);
		}

		public function add(cmd:ICommand, atIndex:int = -1):void
		{
			_queue.add(cmd, atIndex);
		}

		public function addList(commands:Vector.<ICommand>):void
		{
			_queue.addList(commands);
		}

		override protected function run():void
		{
			super.run();

			if (_queue.length > 0)
			{
				_queue.unlock();
			}
			else
			{
				super.complete();
			}
		}

		protected function commandComplete(cmd:ICommand):void
		{
			if (_queue.length == 0)
			{
				super.complete();
			}
		}
	}
}