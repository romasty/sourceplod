package ru.plod.util.keyboard
{


    import flash.display.Stage;
    import flash.events.KeyboardEvent;
    import flash.utils.Dictionary;

    public class  HotkeyService implements IHotkeyService
    {
        private const _keyMap : Dictionary = new Dictionary();

        public function HotkeyService(stage : Stage = null)
        {
            initialize(stage);
        }

        public function initialize(stage : Stage) : void
        {
            if (stage) {
                stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
                stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
            }
        }

        public function getHotkey(keyCode : uint) : Hotkey
        {
            trace(keyCode, _keyMap[keyCode])
            var hk : Hotkey = _keyMap[keyCode] ||= new Hotkey(keyCode);

            return hk;
        }

        /*public function getCombo(...args) : HotkeyCombo
        {
            //TODO cache
            var combo : HotkeyCombo = new HotkeyCombo();
            for each (var keyCode : uint in args) {
                combo.addHotkey(getHotkey(keyCode));
            }
            return combo;
        }*/


        private function onKeyDown(event : KeyboardEvent) : void
		{
			getHotkey(event.keyCode).update(true);
		}


		private function onKeyUp(event : KeyboardEvent) : void
		{
            getHotkey(event.keyCode).update(false);
		}

    }

}