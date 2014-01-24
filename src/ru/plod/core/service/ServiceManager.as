/**
 * Created by IntelliJ IDEA.
 * User: romasty
 * Date: 26.08.11
 * Time: 11:58
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.service {


	public class ServiceManager implements IServiceManager {


		private static var _instance:ServiceManager = new ServiceManager();

		public static function getInstance():ServiceManager
		{
			return _instance;
		}

		private var _srvMap:ClassDictionary = new ClassDictionary(true);

		public function registerService(srvInterface:Class, srvImplementation:Object):void
		{

			_srvMap.registerInstance(srvInterface, srvImplementation)
		}

		public function getService(srvInterface:Class):Object
		{
			return _srvMap.getInstance(srvInterface);
		}
	}
}
