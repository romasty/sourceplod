package ru.plod.util.keyboard
{
    import ru.plod.broadcaster.Broadcaster;

    /**
     * ...
     * @author Romasty
     */
    public class Hotkey
    {
        public const eventChange : Broadcaster = new Broadcaster();
        public const eventEnabledChange : Broadcaster = new Broadcaster();

        protected var _keyCode : int;
        protected var _pressed : Boolean = false;
        protected var _enabled : Boolean = true;
        protected var _value : *;

        public function Hotkey(code : int, value : * = null)
        {
            eventChange.target = this;
            eventEnabledChange.target = this;

            _keyCode = code;
            _value = value;
        }

        public function get keyCode() : int
        {
            return _keyCode;
        }


        public function get pressed() : Boolean
        {
            return _pressed;
        }


        public function get enabled() : Boolean
        {
            return _enabled;
        }

        public function set enabled(value : Boolean) : void
        {
            if(_enabled != value) {
                _enabled = value;
                eventEnabledChange.broadcast();

                if(!_enabled) update(false);
            }
        }

        public function get value() : *
        {
            return _value;
        }


        internal function update(pressed : Boolean) : void
        {
            if(_pressed != pressed) {
                _pressed = pressed;
                eventChange.broadcast();
            }
        }

    }

}