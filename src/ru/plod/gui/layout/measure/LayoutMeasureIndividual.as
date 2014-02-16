/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/15/14
 * Time: 12:35 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {

	import ru.plod.helpers.MeasureQueue;

	public class LayoutMeasureIndividual implements ILayoutMeasure {

		private var _queue:MeasureQueue = new MeasureQueue();
		private var _gap : int;

		public function LayoutMeasureIndividual(gap : int = 0)
		{
			_gap = gap;
		}

		public function get gap():int
		{
			return _gap;
		}

		public function set gap(value:int):void
		{
			_gap = value;
		}

		public function measure(index:uint, size:int):void
		{
			_queue.put(index, size);
		}

		public function getPosition(index:uint):int
		{
			return _queue.positions[index] + index * _gap;
		}

		public function getSize(index:uint):int
		{
			return _queue.sizes[index];
		}

		public function get totalSize():int
		{
			return _queue.totalSize + (_queue.length - 1) * _gap;
		}
	}
}
