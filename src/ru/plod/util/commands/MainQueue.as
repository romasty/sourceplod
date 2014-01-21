package ru.plod.util.commands
{
	import ru.plod.core.commands.ICommand;
	import ru.plod.core.commands.CommandQueue;


	/**
     * ...
     * @author Romasty
     */
    public class MainQueue
    {
        
        private static var _commandQueue : CommandQueue = new CommandQueue();


        public static function add(cmd : ICommand, atEnd : Boolean = true) : void
        {
            if (atEnd) {
                _commandQueue.add(cmd, -1);
            } else {
                _commandQueue.add(cmd, 0);
            }
        }


        public static function addCommands(arr : Array) : void
        {
            _commandQueue.addAll(arr);
        }


        public static function cleanUp() : void
        {
            _commandQueue.cleanUp();
            _commandQueue = new CommandQueue();
        }


    }

}