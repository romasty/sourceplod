package ru.plod.util {

    public class CallFuncProxy {


        private var _func : Function;
        private var _arguments : Array;


        public function CallFuncProxy(func : Function, ...args : Array)
        {
            _func = func;
            _arguments = args;
        }


        public function call() : void
        {
            _func.apply(NaN, _arguments);
        }


        public function setArguments(...args : Array) : void
        {
            _arguments = args;
        }

        public function get arguments() : Array
        {
            return _arguments;
        }

        public function set arguments(value : Array) : void
        {
            _arguments = value;
        }
    }
}