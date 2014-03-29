/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 3/30/14
 * Time: 12:49 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.util.keyboard
{
    public class HotkeyCombo extends AbstractHotkey
    {
        private const hotkeys : Vector.<Hotkey> = new Vector.<Hotkey>();

        public function HotkeyCombo()
        {
            super();
        }

        internal function addHotkey(hotkey : Hotkey):void
        {
            if(hotkeys.indexOf(hotkey) == -1) {
                hotkeys.push(hotkey);
                hotkey.eventPressed.subscribe(onChange);
            }
        }

        protected function onChange(hotkey : Hotkey) : void
        {
            var pressed : Boolean = false;
            for each (var h : Hotkey in hotkeys) {
                pressed ||= h.pressed;
            }
            update(pressed);
        }
    }
}
