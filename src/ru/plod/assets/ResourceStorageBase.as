/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/7/14
 * Time: 8:20 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.assets {
	import flash.utils.Dictionary;

	public class ResourceStorageBase implements IResourceStorage{


		protected var _storage : Dictionary;

		public function ResourceStorageBase() {
			_storage = new Dictionary();
		}

		public function addSource(key : String, src : *) : void
		{
			_storage[key] = src;
		}

		public function getSource(key : *) : Object
		{
			return _storage[key];
		}

	}
}
