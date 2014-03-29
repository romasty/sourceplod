package ru.plod.util.keyboard
{
	import flash.events.KeyboardEvent;
    import flash.utils.Dictionary;

    /**
	 * ...
	 * @author Romasty
	 */
	public class AbstractHKMap
	{
		private var keyService : HotkeyService;
		
		public function AbstractHKMap()
		{
			init();
		}
		
		protected function init() : void
		{
		    //to override
		}


        public function getHotkey(keyCode : uint) : Hotkey
        {
            return keyService.getHotkey(keyCode);
        }
		
	}

}