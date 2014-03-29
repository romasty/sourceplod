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

        public function Hotkey(keyCode : uint)
        {
            super();
            _keyCode = keyCode;
        }

        public function get keyCode() : uint
        {
            return _keyCode;
        }
    }

}