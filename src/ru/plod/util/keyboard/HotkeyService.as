package ru.plod.util.keyboard
{


    import flash.display.Stage;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.utils.Dictionary;

    public class  HotkeyService
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


        private function onKeyDown(event : KeyboardEvent) : void
		{
			getHotkey(event.keyCode).update(true);
		}


		private function onKeyUp(event : KeyboardEvent) : void
		{
            getHotkey(event.keyCode).update(false);
		}

        public function getHotkey(keyCode : uint) : Hotkey
        {
            var hk : Hotkey = _keyMap[keyCode] ||= new Hotkey(keyCode);
            return hk;
        }

        public function getCombo() : HotkeyCombo
        {
            //TODO
            return null;
        }

    }

}