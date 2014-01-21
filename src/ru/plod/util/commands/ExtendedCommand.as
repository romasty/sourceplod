/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/7/14
 * Time: 7:15 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.util.commands {
	import ru.plod.core.commands.Command;
	import ru.plod.util.proxy.IResolverAware;
	import ru.plod.util.proxy.PropertyResolver;

	public class ExtendedCommand extends Command implements IResolverAware{

		public function ExtendedCommand()
		{
		}

		private var _resolver : PropertyResolver;

		public function get resolve() : PropertyResolver
		{
			if(_resolver == null) {
				_resolver = new PropertyResolver(this);
			}
			return _resolver;
		}


		override protected function run():void
		{
			if(_resolver != null) {
				_resolver.resolveTasks();
			}
			super.run();
		}
	}
}
