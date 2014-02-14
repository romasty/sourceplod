/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/15/14
 * Time: 12:36 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {
	public class SizeMeasureUnion implements ISizeMeasure{

		private var _size:int;
		private var _lastIndex : uint;

		public function SizeMeasureUnion()
		{
		}

		public function measure(index:uint, size:int):void
		{
			if(index> _lastIndex) _lastIndex = index;
			if(size > _size) _size = size;
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
			return _lastIndex * _size;
		}
	}
}
