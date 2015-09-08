package ru.plod.core.commands
{
	public class CommandPool extends CommandExecutor
	{
		protected const _commands:Vector.<ICommand> = new Vector.<ICommand>();

		public function CommandPool()
		{
		}

		public function add(cmd:ICommand, atIndex:int = -1):void
		{
			if (cmd == null)
			{
				throw new Error("Error! Command is null!");
			}

			if (atIndex < -1 || atIndex > _commands.length)
			{
				throw(new Error("Error! Invalid index!"))
			}

			if (atIndex == -1)
			{
				_commands.push(cmd);
			}
			else
			{
				_commands.splice(atIndex, 0, cmd);
			}
		}

		public function addList(commands:Vector.<ICommand>):void
		{
			for each(var cmd:ICommand in commands)
			{
				add(cmd);
			}
		}

		public function get length():int
		{
			return _commands.length;
		}

		public function executeNext():ICommand
		{
			var cmd:ICommand = _commands.shift() as ICommand;
			executeCommand(cmd);
			return cmd;
		}

		public function cleanUp():void
		{
			_commands.length = 0;
		}

		/*public function interrupt():void
		 {
		 for each(var cmd : ICommand in _commands) {
		 //cmd.interrupt();
		 }
		 cleanUp();
		 }*/
	}
}