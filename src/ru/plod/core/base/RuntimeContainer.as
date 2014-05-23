/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 5/22/14
 * Time: 9:29 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.base {
	import ru.plod.core.ILifecycle;
	import ru.plod.core.IRuntime;

	public class RuntimeContainer extends BaseContainer implements IRuntime {

		protected const runtimeChildren:Vector.<IRuntime> = new Vector.<IRuntime>();

		public function updateTime(time:uint, delta:uint):void
		{
			if (_active) {
				for each (var child:IRuntime in runtimeChildren) {
					child.updateTime(time, delta);
				}
			}
		}

		override public function addComponent(child:ILifecycle):ILifecycle
		{
			child = super.addComponent(child);
			if (child is IRuntime) {
				runtimeChildren.push(child as IRuntime);
			}
			return child;
		}

		override public function removeComponent(child:ILifecycle):ILifecycle
		{
			child = super.removeComponent(child);
			if (child is IRuntime) {
				var index:int = runtimeChildren.indexOf(child);
				runtimeChildren.splice(index, 1);

			}
			return child;
		}

		override public function finalize():void
		{
			super.finalize();
			runtimeChildren.length = 0;
		}
	}
}