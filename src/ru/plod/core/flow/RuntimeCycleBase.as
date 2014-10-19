/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 16.08.11
 * Time: 13:05
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.flow {

	public class RuntimeCycleBase extends AbstractRuntimeProcess implements IRuntimeProcess {

		protected var _source:IProcessSource;

        public function RuntimeCycleBase(source:IProcessSource = null)
        {
            _source = source ? source : new ProcessSourceBase();
        }

        public function get source():IProcessSource
        {
            return _source;
        }

		override public function updateTime(time:uint, delta:uint):void
        {
			if(!_running) return;

			_source.refresh();
            for each(var process:IRuntimeProcess in _source.activeSource) {
				process.updateTime(time, delta);
            }
            _source.refresh();
        }

		public function cleanUp():void
        {
            _source.cleanUp();
        }

		override public function finalize():void
		{
			_source.cleanUp();
			_source = null;
		}
    }
}
