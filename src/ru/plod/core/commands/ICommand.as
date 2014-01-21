package ru.plod.core.commands
{
    import flash.events.IEventDispatcher;

    /**
	 * ...
	 * @author Romasty
	 */
	public interface ICommand extends IEventDispatcher
	{
		
		function execute() : void;
		function get isAsync():Boolean;
		function get status():int;
		
	}

}