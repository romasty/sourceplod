package ru.plod.util.proxy {

    internal class ResolverTask {

        private var _source : *;
        private var _sourceProperty : String;
        private var _target : *;
        private var _targetProperty : String;

        private var _sourceFunc : String;
        private var _args : Array = [];



        public function resolveTask() : void
        {
            if(_sourceProperty) {

                _target[_targetProperty] = _source[_sourceProperty];

            } else if(_sourceFunc) {

                var func : Function = _source[_sourceFunc];
                _target[_targetProperty] = func.apply(NaN, _args)
            }
        }





    
        public function get source() : *
        {
            return _source;
        }

        public function set source(value : *) : void
        {
            _source = value;
        }



        public function get sourceProperty() : String
        {
            return _sourceProperty;
        }

        public function set sourceProperty(value : String) : void
        {
            _sourceProperty = value;
        }



        public function get target() : *
        {
            return _target;
        }

        public function set target(value : *) : void
        {
            _target = value;
        }



        public function get targetProperty() : String
        {
            return _targetProperty;
        }

        public function set targetProperty(value : String) : void
        {
            _targetProperty = value;
        }



        public function get sourceFunc() : String
        {
            return _sourceFunc;
        }

        public function set sourceFunc(value : String) : void
        {
            _sourceFunc = value;
        }



        public function get args() : Array
        {
            return _args;
        }

        public function set args(value : Array) : void
        {
            _args = value;
        }

    }
}