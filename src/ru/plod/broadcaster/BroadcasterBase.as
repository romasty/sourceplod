/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/5/14
 * Time: 9:53 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.broadcaster {

	public class BroadcasterBase implements IBroadcaster {

		protected var handlers:Vector.<Function> = new Vector.<Function>();

		public function BroadcasterBase()
		{
		}

		public function subscribe(handler : Function) : void
		{
			var i : int = handlers.indexOf(handler);
			if (i != -1) return;
			handlers.push(handler);
		}

		public function unsubscribe(handler : Function) : void
		{
			var i : int = handlers.indexOf(handler);
			if (i == -1) return;
			handlers.splice(i, 1);
		}

		public function broadcast(...rest):void
		{
			var handlerList:Vector.<Function> = handlers.concat();
			for each (var handler:Function in handlerList) {
				handle(handler, rest);
			}
		}

		protected function handle(handler:Function, args:Array = null):void
		{
			handler.apply(NaN, args);
		}
	}
}
