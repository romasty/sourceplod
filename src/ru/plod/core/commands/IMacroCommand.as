package ru.plod.core.commands {

    public interface IMacroCommand extends ICommand {
        
        function add(cmd : ICommand, atIndex : int = -1) : void;
		function addList(arr : Array) : void;
    }
}