package ru.plod.core.commands
{
	public class CommandExecutor
	{
		protected var _onCommandComplete:Function;
		protected var _running:Boolean;

		public function CommandExecutor()
		{
			//..
		}

		public function executeCommand(cmd:ICommand):void
		{
			_running = true;

			if (!cmd.isAsync)
			{
				cmd.eventComplete.subscribe(onComplete);
			}

			cmd.execute();

			if (cmd.isAsync)
			{
				commandComplete(cmd);
			}
		}

		protected function onComplete(cmd : ICommand):void
		{
			cmd.eventComplete.unsubscribe(onComplete);
			commandComplete(cmd);
		}

		protected function commandComplete(cmd:ICommand):void
		{
			_running = false;
			if (_onCommandComplete != null)
			{
				_onCommandComplete(cmd);
			}
		}

		public function set onCommandComplete(value:Function):void
		{
			_onCommandComplete = value;
		}

		public function get running():Boolean
		{
			return _running;
		}
	}
}