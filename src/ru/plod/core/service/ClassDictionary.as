/**
 * Created by IntelliJ IDEA.
 * User: romasty
 * Date: 26.08.11
 * Time: 13:48
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.service {

	import flash.utils.Dictionary;

	public class ClassDictionary {

		protected var _services:Dictionary = new Dictionary();

		protected var _strict:Boolean = false;

		public function ClassDictionary(strict:Boolean = false)
		{
			_strict = strict;
		}

		public function registerInstance(classRef:Class, classInstance:Object):void
		{
			if (!_strict || (classInstance is classRef)) {
				_services[classRef] = classInstance;
			} else {
				throw new ArgumentError();
			}
		}

		public function getInstance(classRef:Class):Object
		{
			return _services[classRef];
		}
	}
}
