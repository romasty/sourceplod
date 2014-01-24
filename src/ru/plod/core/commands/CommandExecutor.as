package ru.plod.core.commands {

    import flash.events.Event;

	import ru.plod.core.commands.ICommand;

	import ru.plod.core.commands.ro_commands;

	use namespace ro_commands;


	public class CommandExecutor {

        protected var _onCommandComplete : Function;
        //protected var _currentCommand : ICommand;
        protected var _running : Boolean;

        public function CommandExecutor()
        {
            //..
        }


        ro_commands function executeCommand(cmd : ICommand) : void
        {
            _running = true;

            if (!cmd.isAsync) {
                cmd.addEventListener(Event.COMPLETE, onComplete);
            }

            cmd.execute();

            if (cmd.isAsync) {
                commandComplete(cmd);
            }
        }

        protected function onComplete(e : Event) : void
        {
            var cmd : ICommand = e.target as ICommand;
            cmd.removeEventListener(Event.COMPLETE, onComplete);
            commandComplete(cmd);
        }

        protected function commandComplete(cmd : ICommand) : void
        {
            _running = false;
            if (_onCommandComplete != null) {
                _onCommandComplete(cmd);
            }
        }

        public function set onCommandComplete(value : Function) : void
        {
            _onCommandComplete = value;
        }


        public function get running() : Boolean
        {
            return _running;
        }
    }
}