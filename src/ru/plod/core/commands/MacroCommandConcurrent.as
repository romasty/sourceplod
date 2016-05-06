package ru.plod.core.commands
{
	public class MacroCommandConcurrent extends Command implements IMacroCommand
	{
		protected var _uncompletedNum:int;
		protected var _pool:CommandPool;

		public function MacroCommandConcurrent(commands:Vector.<ICommand> = null)
		{
			_pool = new CommandPool();
			_pool.onCommandComplete = commandComplete;
			if (commands) _pool.addList(commands);
		}

		public function add(cmd:ICommand, atIndex:int = -1):void
		{
			_pool.add(cmd, atIndex);
		}

		public function addList(commands:Vector.<ICommand>):void
		{
			_pool.addList(commands);
		}

		override protected function run():void
		{
			if (_pool.length > 0)
			{
				_uncompletedNum = _pool.length;

				while (_pool.length)
				{
					_pool.executeNext();
				}
			}
			else
			{
				super.complete();
			}
		}

		protected function commandComplete(cmd:ICommand):void
		{
			_uncompletedNum--;
			if (_uncompletedNum == 0)
			{
				super.complete();
			}
		}
	}
}