/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/15/14
 * Time: 12:36 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {
	public class LayoutMeasureFixed implements ILayoutMeasure {

		private var _size:int;
		private var _gap : int;
		private var _lastIndex : uint;

		public function LayoutMeasureFixed(size:int, gap : int = 0)
		{
			_size = size;
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
			if(index> _lastIndex) _lastIndex = index;
		}

		public function getPosition(index:uint):int
		{
			return (_size + _gap) * index;
		}

		public function getSize(index:uint):int
		{
			return _size;
		}

		public function get totalSize():int
		{
			return _lastIndex * (_size + _gap);
		}
	}
}
