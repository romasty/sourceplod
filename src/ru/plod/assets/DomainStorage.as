/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/7/14
 * Time: 8:16 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.assets {
	import flash.system.ApplicationDomain;

	public class DomainStorage implements IResourceStorage{

		protected var _appDomain : ApplicationDomain;

		public function DomainStorage(appDomain:ApplicationDomain = null)
		{
			setDomain(appDomain);
		}


		public function get appDomain():ApplicationDomain
		{
			return _appDomain;
		}

		public function setDomain(appDomain:ApplicationDomain) : void
		{
			_appDomain = appDomain;
		}

		public function getDefinition(className : String) : Class
		{
			return _appDomain.getDefinition(className) as Class;
		}

		public function getSource(key : *) : Object
		{
			var cl : Class = getDefinition(key);
			return new cl();
		}
	}
}
