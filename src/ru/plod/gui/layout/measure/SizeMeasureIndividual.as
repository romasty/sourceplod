/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/15/14
 * Time: 12:35 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {

	import ru.plod.helpers.MeasureQueue;

	public class SizeMeasureIndividual implements ISizeMeasure {

		private var _queue:MeasureQueue = new MeasureQueue();

		public function SizeMeasureIndividual()
		{
		}

		public function measure(index:uint, size:int):void
		{
			_queue.put(index, size);
		}

		public function getPosition(index:uint):int
		{
			return _queue.positions[index];
		}

		public function getSize(index:uint):int
		{
			return _queue.sizes[index];
		}

		public function get totalSize():int
		{
			return _queue.totalSize;
		}
	}
}
