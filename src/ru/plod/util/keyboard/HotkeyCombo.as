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

        public function addHotkey(hotkey : Hotkey):void
        {
            if(hotkeys.indexOf(hotkey) == -1) {
                hotkeys.push(hotkey);
                hotkey.eventChange.subscribe(onChange);
            }
        }

        protected function onChange(hotkey : Hotkey) : void
        {
            var combo : Boolean = false;
            for each (var h : Hotkey in hotkeys) {
                combo &&= h.pressed;
            }
            update(combo);
        }
    }
}
