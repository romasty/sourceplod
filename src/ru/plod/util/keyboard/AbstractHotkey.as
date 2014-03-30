/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 3/30/14
 * Time: 1:16 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.util.keyboard
{
    import ru.plod.broadcaster.Broadcaster;

    public class AbstractHotkey
    {
        public const eventChange : Broadcaster = new Broadcaster();
        public const eventEnabled : Broadcaster = new Broadcaster();

        protected var _pressed : Boolean = false;
        protected var _enabled : Boolean = true;

        public function AbstractHotkey()
        {
            eventChange.target = this;
            eventEnabled.target = this;
        }


        public function get pressed() : Boolean
        {
            return _pressed;
        }


        public function get enabled() : Boolean
        {
            return _enabled;
        }

        public function set enabled(value : Boolean) : void
        {
            if(_enabled != value) {
                _enabled = value;
                eventEnabled.broadcast();

                if(!_enabled) update(false);
            }
        }

        internal function update(pressed : Boolean) : void
        {
            if(_pressed != pressed) {
                _pressed = pressed;
                eventChange.broadcast();
            }
        }
    }
}
