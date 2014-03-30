package ru.plod.util.keyboard
{
    import ru.plod.broadcaster.Broadcaster;

    /**
     * ...
     * @author Romasty
     */
    public class Hotkey extends AbstractHotkey
    {
        protected var _keyCode : uint;

        public const eventDown : Broadcaster = new Broadcaster();
        public const eventUp : Broadcaster = new Broadcaster();

        public function Hotkey(keyCode : uint)
        {
            eventDown.target = this;
            eventUp.target = this;
            super();
            _keyCode = keyCode;
        }

        public function get keyCode() : uint
        {
            return _keyCode;
        }


        override internal function update(pressed : Boolean) : void
        {
            if(pressed != _pressed) {
                super.update(pressed);
                if(_enabled) pressed ? eventDown.broadcast() : eventUp.broadcast();
            }

        }
    }

}