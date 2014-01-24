package ru.plod.core.commands
{
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    import flash.events.EventDispatcher;


    /**
     * ...
     * @author Romasty
     */
    public class Command extends EventDispatcher implements ICommand
    {

        public static const PURE : int = 0;
        public static const RUNNING : int = 1;
        public static const COMPLETED : int = 2;

        protected var _isAsync : Boolean = false;
        private var _status : int = PURE;

        public function Command()
        {
            //..
        }


        final public function execute() : void
        {
            if (_status == PURE) {
                
                _status = RUNNING;
                dispatchEvent(new Event(Event.OPEN));
                run();

            } else {
                throw(new IllegalOperationError("Error! Command is stale! " + this));
            }
        }


        protected function run() : void
        {
            //..
        }


        final protected function complete() : void
        {
            _status = COMPLETED;
            dispatchEvent(new Event(Event.COMPLETE));
        }


        public function get isAsync() : Boolean
        {
            return _isAsync;
        }

        public function get status():int
        {
            return _status;
        }







    }

}