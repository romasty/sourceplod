package ru.plod.util.keyboard
{
    import flash.geom.Point;
    import flash.ui.Keyboard;

    import ru.plod.broadcaster.Broadcaster;

    /**
     * ...
     * @author Romasty
     */
    public class ArrowHotkeyer extends AbstractHKMap
    {
        public const eventDirectionChange : Broadcaster = new Broadcaster();
        public const direction : Point = new Point();
        private var _useWASD : Boolean;
        private var _normalizeDirection : Boolean;

        public function ArrowHotkeyer(useWASD : Boolean = true, normalizeDirection : Boolean = false)
        {
            eventDirectionChange.target = this;
             _useWASD = useWASD;
            _normalizeDirection = normalizeDirection;

            super();
        }



        override protected function init() : void
        {
            super.init();

            getHotkey(Keyboard.LEFT).eventPressed.subscribe(leftKeyChange);
            getHotkey(Keyboard.RIGHT).eventPressed.subscribe(rightKeyChange);
            getHotkey(Keyboard.UP).eventPressed.subscribe(upKeyChange);
            getHotkey(Keyboard.DOWN).eventPressed.subscribe(downKeyChange);

            if (_useWASD) {

                getHotkey(Keyboard.A).eventPressed.subscribe(leftKeyChange);
                getHotkey(Keyboard.D).eventPressed.subscribe(rightKeyChange);
                getHotkey(Keyboard.W).eventPressed.subscribe(upKeyChange);
                getHotkey(Keyboard.S).eventPressed.subscribe(downKeyChange);
            }
        }

        private function leftKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                setX(-1);
            } else {
                var rightPressed : Boolean = getHotkey(Keyboard.RIGHT).pressed || (_useWASD && getHotkey(Keyboard.D).pressed);
                setX(rightPressed ? 1 : 0);
            }
        }


        private function rightKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                setX(1);
            } else {
                var leftPressed : Boolean = getHotkey(Keyboard.LEFT).pressed || (_useWASD && getHotkey(Keyboard.A).pressed);
                setX(leftPressed ? -1 : 0);
            }
        }


        private function upKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                setY(-1);
            } else {
                var downPressed : Boolean = getHotkey(Keyboard.DOWN).pressed || (_useWASD && getHotkey(Keyboard.S).pressed);
                setY(downPressed ? 1 : 0);
            }
        }


        private function downKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                setY(1);
            } else {
                var upPressed : Boolean = getHotkey(Keyboard.UP).pressed || (_useWASD && getHotkey(Keyboard.W).pressed);
                setY(upPressed ? -1 : 0);
            }
        }

        private function setX(x : int) : void
        {
            direction.x = x;
            if(_normalizeDirection) direction.normalize(1);
            eventDirectionChange.broadcast();
        }

        private function setY(y : int) : void
        {
            direction.y = y;
            if(_normalizeDirection) direction.normalize(1);
            eventDirectionChange.broadcast();
        }
    }

}