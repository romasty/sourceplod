package ru.plod.core.commands
{
	import ru.plod.core.commands.CommandQueue;


	/**
	 * ...
	 * @author Romasty
	 */
	public class MacroCommandQueued extends Command implements IMacroCommand
	{

        protected var _queue : CommandQueue;

		public function MacroCommandQueued(commands : Array = null)
		{
            init(commands);
		}

        protected function init(commands : Array) : void
        {
            _queue = new CommandQueue(true);
            _queue.onCommandComplete = commandComplete;
            _queue.addAll(commands);
        }

        public function add(cmd : ICommand, atIndex : int = -1) : void
		{
            _queue.add(cmd, atIndex);
		}

		public function addList(arr : Array) : void
		{
            _queue.addAll(arr);
		}
		
		
		override protected function run():void
		{
			super.run();
			
			if (_queue.length > 0) {
				
				(_queue as CommandQueue).unlock();
				
			} else {
				
				super.complete();
			}
		}
		
		
		protected function commandComplete(cmd : ICommand) : void
		{
			if (_queue.length == 0) {

                trace("MACRO QUEUED:", "commandComplete");
                super.complete();
            }
		}
	}
}