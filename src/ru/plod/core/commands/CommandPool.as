package ru.plod.core.commands {
	import ru.plod.core.commands.ICommand;
	import ru.plod.core.commands.ro_commands;

	use namespace ro_commands;


	public class CommandPool extends CommandExecutor {

        protected var _commands : Array;

        public function CommandPool()
        {
            _commands = new Array();
        }


        public function add(cmd : ICommand, atIndex : int = -1) : void
        {
            if(cmd == null) {
                throw new Error("Error! Command is null!");
            }

            if (atIndex < -1 || atIndex > _commands.length) {
                throw(new Error("Error! Invalid index!!!"))
            }

            if (atIndex == -1) {
                _commands.push(cmd);
            } else if (atIndex == 0) {
                _commands.unshift(cmd);
            } else {
                _commands.splice(atIndex, 0, cmd);
            }
        }


        public function addAll(arr : Array) : void
        {
            var cmd : ICommand;
            for each(cmd in arr) {
                add(cmd);
            }
        }

        public function get length() : int
        {
            return _commands.length;
        }

        public function executeNext() : ICommand
        {
            var cmd : ICommand = _commands.shift() as ICommand;
            ro_commands::executeCommand(cmd);
            return cmd;
        }

        public function cleanUp():void
        {
            _commands = new Array();
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