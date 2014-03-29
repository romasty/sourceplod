﻿package ru.plod.util.keyboard
{
    import flash.ui.Keyboard;

    /**
     * ...
     * @author Romasty
     */
    public class ArrowHotKeyer extends AbstractHKMap
    {

        private var _xFunc : Function;
        private var _yFunc : Function;

        private var _useWASD : Boolean;

        public function ArrowHotKeyer(xFunc : Function, yFunc : Function, useWASD : Boolean = true)
        {
            _xFunc = xFunc;
            _yFunc = yFunc;

            _useWASD = useWASD;

            super();
        }


        override protected function init() : void
        {
            super.init();

            getHotkey(Keyboard.LEFT).eventChange.subscribe(leftKeyChange);
            getHotkey(Keyboard.RIGHT).eventChange.subscribe(rightKeyChange);
            getHotkey(Keyboard.UP).eventChange.subscribe(upKeyChange);
            getHotkey(Keyboard.DOWN).eventChange.subscribe(downKeyChange);

            if (_useWASD) {

                getHotkey(Keyboard.A).eventChange.subscribe(leftKeyChange);
                getHotkey(Keyboard.D).eventChange.subscribe(rightKeyChange);
                getHotkey(Keyboard.W).eventChange.subscribe(upKeyChange);
                getHotkey(Keyboard.S).eventChange.subscribe(downKeyChange);
            }

        }

        private function leftKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                _xFunc(-1);
            } else {
                var other : Boolean = getHotkey(Keyboard.RIGHT).pressed || getHotkey(Keyboard.D).pressed;
                var x : int = other ? 1 : 0;
                _xFunc(x);
            }
        }


        private function rightKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                _xFunc(1);
            } else {
                var other : Boolean = getHotkey(Keyboard.LEFT).pressed || getHotkey(Keyboard.A).pressed;
                var x : int = other ? -1 : 0;
                _xFunc(x);
            }
        }


        private function upKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                _yFunc(-1);
            } else {
                var other : Boolean = getHotkey(Keyboard.DOWN).pressed || getHotkey(Keyboard.S).pressed;
                var y : int = other ? 1 : 0;
                _yFunc(y);
            }
        }


        private function downKeyChange(hk : Hotkey) : void
        {
            if (hk.pressed) {
                _yFunc(1);
            } else {
                var other : Boolean = getHotkey(Keyboard.UP).pressed || getHotkey(Keyboard.W).pressed;
                var y : int = other ? -1 : 0;
                _yFunc(y);
            }
        }

    }

}