/**
 * Created by IntelliJ IDEA.
 * User: romasty
 * Date: 26.08.11
 * Time: 11:58
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.service {


	public class ServiceManager implements IServiceManager {


		private static var _instance:ServiceManager;

		public static function get instance():ServiceManager
		{
			return _instance ||= new ServiceManager();
		}

		private var _srvMap:ClassDictionary = new ClassDictionary(true);

		public function registerService(srvClassRef:Class, srvImplementation:Object):void
		{
			_srvMap.registerInstance(srvClassRef, srvImplementation)
		}

		public function getService(srvClassRef:Class):Object
		{
			return _srvMap.getInstance(srvClassRef);
		}
	}
}
