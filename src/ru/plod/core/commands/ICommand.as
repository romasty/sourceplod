package ru.plod.core.commands
{
	import ru.plod.broadcaster.IBroadcast;

	public interface ICommand
	{
		function get eventComplete():IBroadcast;

		function execute():void;

		function get isAsync():Boolean;

		function get status():int;
	}

}