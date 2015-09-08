package ru.plod.util.keyboard {
	import ru.plod.core.service.getService;


	/**
	 * ...
	 * @author Romasty
	 */
	public class AbstractHotkeyManager {

		private var keyService:IHotkeyService = getService(IHotkeyService);

		public function AbstractHotkeyManager()
		{
			init();
		}

		protected function init():void
		{
			//to override
		}


		public function getHotkey(keyCode:uint):Hotkey
		{
			return keyService.getHotkey(keyCode);
		}

	}

}