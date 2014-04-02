/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/1/14
 * Time: 12:15 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.cycle {
	import ru.plod.broadcaster.IBroadcast;

	public interface IRuntimeProcess {

		function get eventAwake():IBroadcast;

		function get eventSleep():IBroadcast;

		function awake():void;

		function sleep():void;

		function update(deltaTime:Number):void;
	}
}
