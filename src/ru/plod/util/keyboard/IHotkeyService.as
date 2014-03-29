/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 3/30/14
 * Time: 1:50 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.util.keyboard
{
    public interface IHotkeyService
    {
        function getHotkey(keyCode : uint) : Hotkey;

        function getCombo(...args) : HotkeyCombo ;
    }
}
