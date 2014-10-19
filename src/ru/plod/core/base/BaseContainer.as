/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 5/22/14
 * Time: 9:17 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.base {
	import ru.plod.core.ILifecycle;
	import ru.plod.core.ILifecycle;
	import ru.plod.core.IRuntime;

	public class BaseContainer implements IBaseContainer {

		protected const _children:Vector.<ILifecycle> = new Vector.<ILifecycle>();
		protected var _active:Boolean = false;

		public function BaseContainer()
		{
		}


		public function addComponent(child:ILifecycle):ILifecycle
		{
			if (_children.indexOf(child) == -1) {
				_children.push(child);
				if(_active) child.activate();
				return child;
			}
			return null;
		}

		public function removeComponent(child:ILifecycle):ILifecycle
		{
			var index:int = _children.indexOf(child);
			if (index != -1) {
				child.sleep();
				_children.splice(index, 1);
				return child;
			}
			return null;
		}

		public function removeChildren():void
		{
			for each (var child:ILifecycle in _children) {
				child.sleep();
			}
			_children.length = 0;
		}


		public function activate():void
		{
			if (!_active) {
				_active = true;
				for each (var child:ILifecycle in _children) {
					child.activate();
				}
			}
		}

		public function sleep():void
		{
			if (_active) {
				_active = false;
				for each (var child:ILifecycle in _children) {
					child.sleep();
				}
			}
		}

		public function finalize():void
		{
			for each (var child:ILifecycle in _children) {
				child.finalize();
			}
			_children.length = 0;
		}
	}
}

