/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/1/14
 * Time: 12:15 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.flow {
	import ru.plod.broadcaster.IBroadcast;
	import ru.plod.core.ILifecycle;
	import ru.plod.core.IRuntime;

	public interface IRuntimeProcess extends IRuntime, ILifecycle{

		function get eventAwake():IBroadcast;

		function get eventSleep():IBroadcast;
	}
}
