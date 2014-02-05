/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/5/14
 * Time: 11:34 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.broadcaster {
	public interface IBroadcaster extends IBroadcast {
		function broadcast(...rest):void;
	}
}
