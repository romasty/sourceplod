/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 30.01.12
 * Time: 14:25
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.display {
    import flash.events.Event;

    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;

    public class DisplaySrv implements IDisplay {

        private var _stage : Stage;
        private var _rootDisplayObject : DisplayObjectContainer;


        public function DisplaySrv(stage:Stage, rootDisplayObject:DisplayObjectContainer)
        {
            _stage = stage;
            _rootDisplayObject = rootDisplayObject;
        }

        public function get stage():Stage
        {
            return _stage;
        }

        public function get root():DisplayObjectContainer
        {
            return _rootDisplayObject;
        }



        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            _stage.addEventListener(type, listener, useCapture, priority,useWeakReference);
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            _stage.removeEventListener(type, listener, useCapture);
        }

        public function dispatchEvent(event:Event):Boolean
        {
            return _stage.dispatchEvent(event);
        }

        public function hasEventListener(type:String):Boolean
        {
            return _stage.hasEventListener(type);
        }

        public function willTrigger(type:String):Boolean
        {
            return _stage.willTrigger(type);
        }
    }
}
