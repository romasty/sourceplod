/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/13/14
 * Time: 10:28 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.helpers {
	import flash.geom.Rectangle;

	public class MeasureGrid {

		private var _measureWidth : MeasureQueue = new MeasureQueue();
		private var _measureHeight : MeasureQueue = new MeasureQueue();

		public function MeasureGrid()
		{
		}

		public function get measureWidth():MeasureQueue
		{
			return _measureWidth;
		}

		public function get measureHeight():MeasureQueue
		{
			return _measureHeight;
		}

		public function getRectangle(colIndex:uint, rowIndex:uint) : Rectangle
		{
			var result : Rectangle = new Rectangle();

			if(colIndex < _measureWidth.length) {
				result.x = _measureWidth.positions[colIndex];
				result.width = _measureWidth.sizes[colIndex];
			}

			if(rowIndex < _measureHeight.length) {
				result.y = _measureHeight.positions[rowIndex];
				result.height = _measureHeight.sizes[rowIndex];
			}

			return result;
		}

		public function getRectangle2(index : int) : Rectangle
		{
			var colIndex : int = index % _measureWidth.length;
			var rowIndex : int = index / _measureWidth.length;

			return getRectangle(colIndex, rowIndex);
		}
	}
}
