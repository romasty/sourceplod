/**
 * Created by IntelliJ IDEA.
 * User: romasty
 * Date: 26.08.11
 * Time: 13:46
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.service {
	public interface IServiceManager {

		function registerService(srvClassRef:Class, srvImplementation:Object):void

		function getService(srvClassRef:Class):Object

	}
}
