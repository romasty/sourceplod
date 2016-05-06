package ru.plod.core.service
{
	public class ServiceLocator implements IServiceLocator
	{
		private static var _instance:ServiceLocator;

		public static function get instance():ServiceLocator
		{
			return _instance ||= new ServiceLocator();
		}

		private const _srvMap:ClassDictionary = new ClassDictionary();

		public function registerService(serviceClass:Class, service:Object):void
		{
			_srvMap.setInstance(serviceClass, service)
		}

		public function getService(serviceClass:Class):Object
		{
			return _srvMap.getInstance(serviceClass);
		}
	}
}
