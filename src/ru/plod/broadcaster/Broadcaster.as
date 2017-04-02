/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/5/14
 * Time: 9:53 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.broadcaster
{
    public class Broadcaster implements IBroadcaster
    {
        public var target:* = null;

        protected const _handlers:Vector.<Function> = new Vector.<Function>();
        protected var _broadcasting:Boolean = false;

        private var _count:uint;
        private var _executionCount:uint;

        public function Broadcaster(target:* = null)
        {
            this.target = target;
        }

        public function subscribe(handler:Function):void
        {
            if(handler == null) throw new ArgumentError("handler is null");

            var i:int = _handlers.indexOf(handler);
            if (i != -1) return;

            _handlers.push(handler);
        }

        public function unsubscribe(handler:Function):void
        {
            var i:int = _handlers.indexOf(handler);
            if (i == -1) return;

            if (_broadcasting)
            {
                _executionCount--;
                if (i <= _count)
                {
                    _count--;
                }
            }
            _handlers.splice(i, 1);
        }

        public function broadcast(...rest):void
        {
            _broadcasting = true;

            _executionCount = _handlers.length;

            if (target) rest.unshift(target);

            for (_count = 0; _count < _executionCount; _count++)
            {
                var handler:Function = _handlers[_count];
                handler.apply(NaN, rest);
            }

            _broadcasting = false;
        }
    }
}