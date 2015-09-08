package ru.plod.core.service
{
	import flash.utils.Dictionary;

	public class ClassDictionary
	{
		protected var _instanceByClass:Dictionary = new Dictionary();

		public function ClassDictionary()
		{
		}

		public function setInstance(classRef:Class, instance:Object):void
		{
			if (instance is classRef)
			{
				_instanceByClass[classRef] = instance;
			}
			else
			{
				throw new ArgumentError();
			}
		}

		public function getInstance(classRef:Class):Object
		{
			return _instanceByClass[classRef];
		}
	}
}
