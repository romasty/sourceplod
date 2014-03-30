/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 16.08.11
 * Time: 15:10
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.cycle {
	public class ProcessSourceBase implements IProcessSource {

		protected const _objects:Vector.<Object> = new Vector.<Object>();
		protected const _objectsToAdd:Vector.<Object> = new Vector.<Object>();
		protected const _objectsToRemove:Vector.<Object> = new Vector.<Object>();

		public function ProcessSourceBase()
		{

		}

		public function get source():Vector.<Object>
		{
			return _objects;
		}

		public function add(object:Object):void
		{
			_objectsToAdd.push(object);
		}

		public function remove(object:Object):void
		{
			_objectsToRemove.push(object);
		}


		public function cleanUp():void
		{
			_objects.length = 0;
			_objectsToAdd.length = 0;
			_objectsToRemove.length = 0;
		}


		public function refresh():void
		{
			removeDeleted();
			pushAdded();
		}


		protected function pushAdded():void
		{
			if (_objectsToAdd.length == 0) return;

			for each(var object:Object in _objectsToAdd) {
				if (_objects.indexOf(object) == -1) _objects.push(object);
			}

			_objectsToAdd.length = 0;
		}

		protected function removeDeleted():void
		{
			if (_objectsToRemove.length == 0) return;

			for each(var object:Object in _objectsToRemove) {
				var index:int = _objects.indexOf(object);
				if (index != -1)  _objects.splice(index, 1)
			}

			_objectsToRemove.length = 0;
		}
	}
}
