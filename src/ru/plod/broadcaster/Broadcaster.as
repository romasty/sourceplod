/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/5/14
 * Time: 9:53 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.broadcaster {

	public class Broadcaster implements IBroadcaster {

		protected const handlers:Vector.<Function> = new Vector.<Function>();
		protected const toUnsubscribe:Vector.<Function> = new Vector.<Function>();

		public var target:* = null;
		protected var _broadcasting:Boolean = false;

		public function Broadcaster()
		{
		}

		public function subscribe(handler:Function):void
		{
			var i:int = handlers.indexOf(handler);
			if (i != -1) return;
			handlers.push(handler);
		}

		public function unsubscribe(handler:Function):void
		{
			if (_broadcasting) {
				if(toUnsubscribe.indexOf(handler) == -1) toUnsubscribe.push(handler);
				return;
			}

			var i:int = handlers.indexOf(handler);
			if (i == -1) return;
			handlers.splice(i, 1);
		}

		public function broadcast(...rest):void
		{
			_broadcasting = true;
			for each (var handler:Function in handlers) {
				handle(handler, rest);
			}
			_broadcasting = false;

			for each (handler in toUnsubscribe) {
			 	unsubscribe(handler);
			}
			toUnsubscribe.length = 0;
		}

		protected function handle(handler:Function, args:Array = null):void
		{
			args = args ||= new Array();
			args.unshift(target);
			handler.apply(NaN, args);
		}
	}
}
