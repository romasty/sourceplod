/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/1/14
 * Time: 12:19 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.cycle {

	import ru.plod.broadcaster.Broadcaster;
	import ru.plod.broadcaster.IBroadcast;

	public class AbstractRuntimeProcess implements IRuntimeProcess{

		protected const _eventAwake : Broadcaster = new Broadcaster();
		protected const _eventSleep : Broadcaster = new Broadcaster();
		protected var _running : Boolean = false;

		public function AbstractRuntimeProcess()
		{
			_eventAwake.target = this;
			_eventSleep.target = this;
		}

		public function get eventAwake():IBroadcast
		{
			return _eventAwake;
		}

		public function get eventSleep():IBroadcast
		{
			return _eventSleep;
		}

		public function awake():void
		{
			if(!_running) {
				_running = true;
				_eventAwake.broadcast();
			}
		}

		public function sleep():void
		{
			if(_running) {
				_running = false;
				_eventSleep.broadcast();
			}
		}

		public function update(deltaTime:Number):void
		{

		}
	}
}
