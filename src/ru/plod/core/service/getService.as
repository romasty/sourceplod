/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/7/14
 * Time: 6:55 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.service {

	public function getService(srvClassRef:Class):*
	{
		return ServiceManager.getInstance().getService(srvClassRef);
	}
}
