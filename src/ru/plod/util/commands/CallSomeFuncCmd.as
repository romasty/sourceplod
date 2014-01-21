package ru.plod.util.commands
{
    import flash.utils.setTimeout;



	import ru.plod.core.commands.Command;
	import ru.plod.util.CallFuncProxy;


	/**
     * ...
     * @author Romasty
     */

    
    public class CallSomeFuncCmd extends Command
    {
        private var _caller : CallFuncProxy;
        private var _timeout : uint = 0;
        private var _timer : uint;


        public function CallSomeFuncCmd(func : Function, timeout : uint =0, ...args : Array)
        {
            _caller = new CallFuncProxy(func);
            _caller.arguments = args;
            _timeout = timeout;
        }


        public function set timeout(value : uint) : void
        {
            _timeout = value;
        }

        override protected function run() : void
        {
            super.run();

            if(_timeout) {
                _timer = setTimeout(call, _timeout)
            } else {
                call();
            }

        }

        protected function call():void
        {
            _caller.call();
            complete();
        }

    }

}