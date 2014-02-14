/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	import ru.plod.gui.layout.measure.ILayoutElementMeasure;
	import ru.plod.gui.layout.measure.LayoutMeasureFixed;

	public class TileLayout extends AbstractCellLayout {

		protected var _columns:int;

		public function TileLayout(columns:int, alignType:String = null)
		{
			_columns = columns;

			var hm:ILayoutElementMeasure = new LayoutMeasureFixed(140);
			var vm:ILayoutElementMeasure = new LayoutMeasureFixed(140);

			super(alignType, hm, vm);
		}


		override protected function measure(children:Vector.<DisplayObject>):void
		{
			for (var index:int = 0; index < children.length; index++) {
				var child:DisplayObject = children[index];

				var columnIndex:int = index % _columns;
				var rowIndex:int = index / _columns;

				_horizontalMeasure.measure(columnIndex, child.width);
				_verticalMeasure.measure(rowIndex, child.height);
			}
		}

		override protected function getRectangle(index:uint):Rectangle
		{
			var columnIndex:int = index % _columns;
			var rowIndex:int = index / _columns;

			_cell.x = _horizontalMeasure.getPosition(columnIndex);
			_cell.width =  _horizontalMeasure.getSize(columnIndex);
			_cell.y = _verticalMeasure.getPosition(rowIndex);
			_cell.height = _verticalMeasure.getSize(rowIndex);

			return _cell;
		}
	}
}
