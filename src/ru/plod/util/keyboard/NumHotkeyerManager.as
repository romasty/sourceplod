package ru.plod.util.keyboard
{
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import ru.plod.broadcaster.Broadcaster;

    /**
     * ...
     * @author Romasty
     */
    public class NumHotkeyerManager extends AbstractHotkeyManager
    {
        public const eventChange : Broadcaster = new Broadcaster();
        private var _useNumPad : Boolean;
        private const _valueMap : Object = new Object();
        private var _currentValue : int = 0;

        public function NumHotkeyerManager(useNumPad : Boolean = false)
        {
            eventChange.target = this;
            _useNumPad = useNumPad;
            super();
        }


        public function get currentValue() : int
        {
            return _currentValue;
        }

        override protected function init() : void
        {
            super.init();

            initHotKey(Keyboard.NUMBER_1, 1);
            initHotKey(Keyboard.NUMBER_2, 2);
            initHotKey(Keyboard.NUMBER_3, 3);
            initHotKey(Keyboard.NUMBER_4, 4);
            initHotKey(Keyboard.NUMBER_5, 5);
            initHotKey(Keyboard.NUMBER_6, 6);
            initHotKey(Keyboard.NUMBER_7, 7);
            initHotKey(Keyboard.NUMBER_8, 8);
            initHotKey(Keyboard.NUMBER_9, 9);
            initHotKey(Keyboard.NUMBER_0, 0);

            if (_useNumPad) {
                initHotKey(Keyboard.NUMPAD_1, 1);
                initHotKey(Keyboard.NUMPAD_2, 2);
                initHotKey(Keyboard.NUMPAD_3, 3);
                initHotKey(Keyboard.NUMPAD_4, 4);
                initHotKey(Keyboard.NUMPAD_5, 5);
                initHotKey(Keyboard.NUMPAD_6, 6);
                initHotKey(Keyboard.NUMPAD_7, 7);
                initHotKey(Keyboard.NUMPAD_8, 8);
                initHotKey(Keyboard.NUMPAD_9, 9);
                initHotKey(Keyboard.NUMPAD_0, 0);
            }
        }

        private function initHotKey(keyCode : uint, value : int) : void
        {
            var hotkey : Hotkey = getHotkey(keyCode);
            hotkey.eventChange.subscribe(onKeyPress);
            _valueMap[hotkey.keyCode] = value;
        }

        private function onKeyPress(hotkey : Hotkey) : void
        {
            if(hotkey.pressed) {
                var value : int = _valueMap[hotkey.keyCode];
                if (value != _currentValue) {
                    _currentValue = value;
                    eventChange.broadcast();
                }
            }
        }

    }

}