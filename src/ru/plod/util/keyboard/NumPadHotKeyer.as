package ru.plod.util.keyboard
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Romasty
	 */
	public class NumPadHotKeyer extends AbstractHKMap
	{
		private var _callback : Function;
		private var _useNumPad : Boolean

		public function NumPadHotKeyer(callback : Function, useNumPad : Boolean = false) 
		{
			_callback = callback;
			_useNumPad = useNumPad;
			super();
		}
		
		
		override protected function init() : void
		{
			super.init();

            //TODO
			/*getHotkey(Keyboard.NUMBER_1, numKeyDown, null, 1);
			getHotkey(Keyboard.NUMBER_2, numKeyDown, null, 2);
			getHotkey(Keyboard.NUMBER_3, numKeyDown, null, 3);
			getHotkey(Keyboard.NUMBER_4, numKeyDown, null, 4);
			getHotkey(Keyboard.NUMBER_5, numKeyDown, null, 5);
			getHotkey(Keyboard.NUMBER_6, numKeyDown, null, 6);
			getHotkey(Keyboard.NUMBER_7, numKeyDown, null, 7);
			getHotkey(Keyboard.NUMBER_8, numKeyDown, null, 8);
			getHotkey(Keyboard.NUMBER_9, numKeyDown, null, 9);
			getHotkey(Keyboard.NUMBER_0, numKeyDown, null, 0);

			if (_useNumPad) {

                getHotkey(Keyboard.NUMPAD_1, numKeyDown, null, 1);
                getHotkey(Keyboard.NUMPAD_2, numKeyDown, null, 2);
                getHotkey(Keyboard.NUMPAD_3, numKeyDown, null, 3);
                getHotkey(Keyboard.NUMPAD_4, numKeyDown, null, 4);
                getHotkey(Keyboard.NUMPAD_5, numKeyDown, null, 5);
                getHotkey(Keyboard.NUMPAD_6, numKeyDown, null, 6);
                getHotkey(Keyboard.NUMPAD_7, numKeyDown, null, 7);
                getHotkey(Keyboard.NUMPAD_8, numKeyDown, null, 8);
                getHotkey(Keyboard.NUMPAD_9, numKeyDown, null, 9);
                getHotkey(Keyboard.NUMPAD_0, numKeyDown, null, 0);
			}*/
		}
		
		private function numKeyDown(hk : Hotkey) : void
		{
			_callback(hk.value);
		}
	}

}