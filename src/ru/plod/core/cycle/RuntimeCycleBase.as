/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 16.08.11
 * Time: 13:05
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.cycle {

	public class RuntimeCycleBase implements ICycleProcessor {

        private var _source:IProcessSource;
        protected var _processor:ICycleProcessor;

        public function RuntimeCycleBase(source:IProcessSource = null, processor:ICycleProcessor = null)
        {
            _source = source ? source : new ProcessSourceBase();
			_processor = processor ? processor : this;
        }

        public function get source():IProcessSource
        {
            return _source;
        }

		public function process(object:Object):Boolean
		{
			//to override
			return false;
		}

		public function update():void
        {
            for each(var object:Object in _source.source) {
                if (!process(object)) {
                    _source.remove(object);
                }
            }

            _source.refresh();
        }

        public function cleanUp():void
        {
            _source.cleanUp();
        }
    }
}
