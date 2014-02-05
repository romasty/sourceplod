/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/5/14
 * Time: 11:35 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.broadcaster {
	public interface  IBroadcast {

		function subscribe(handler:Function):void

		function unsubscribe(handler:Function):void
	}
}
