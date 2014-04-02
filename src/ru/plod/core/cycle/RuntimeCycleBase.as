/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 16.08.11
 * Time: 13:05
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.cycle {

	public class RuntimeCycleBase extends AbstractRuntimeProcess implements IRuntimeProcess {

		protected var _source:IRuntimeSource;

        public function RuntimeCycleBase(source:IRuntimeSource = null)
        {
            _source = source ? source : new ProcessSourceBase();
        }

        public function get source():IRuntimeSource
        {
            return _source;
        }

		override public function update(deltaTime : Number):void
        {
			if(!_running) return;
			_source.refresh();
            for each(var process:IRuntimeProcess in _source.activeSource) {
				process.update(deltaTime);
            }
            _source.refresh();
        }

		public function cleanUp():void
        {
            _source.cleanUp();
        }
    }
}
