/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/15/14
 * Time: 12:36 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {
	public class LayoutMeasureFixed implements ILayoutElementMeasure {

		private var _size:int;
		private var _totalSize:int;

		public function LayoutMeasureFixed(size:int)
		{
			_size = size;
		}

		public function measure(index:uint, size:int):void
		{
			//do nothimg
		}

		public function getPosition(index:uint):int
		{
			return _size * index;
		}

		public function getSize(index:uint):int
		{
			return _size;
		}

		public function get totalSize():int
		{
			return _totalSize;
		}
	}
}
