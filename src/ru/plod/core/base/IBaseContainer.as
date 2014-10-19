/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 5/22/14
 * Time: 9:26 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.base {
	import ru.plod.core.ILifecycle;

	public interface IBaseContainer extends ILifecycle {
		function addComponent(child : ILifecycle) : ILifecycle;
		function removeComponent(child : ILifecycle) : ILifecycle;
		function removeChildren() : void;
	}
}
