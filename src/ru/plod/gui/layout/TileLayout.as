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

	import ru.plod.gui.layout.measure.ILayoutMeasure;
	import ru.plod.gui.layout.measure.LayoutMeasureFixed;
	import ru.plod.gui.layout.measure.LayoutMeasureType;

	public class TileLayout extends AbstractCellLayout {

		protected var _columns:int;

		public function TileLayout(columns:int,
								   alignType:String = null,
								   horizontalGap:int = 0, verticalGap:int = 0,
								   type:String = "union",
								   cellWidth:int = 0, cellHeight:int = 0)
		{
			_columns = columns;

			var hm:ILayoutMeasure = cellWidth > 0 ? new LayoutMeasureFixed(cellWidth, horizontalGap) : LayoutMeasureType.getMeasure(type, horizontalGap);
			var vm:ILayoutMeasure = cellHeight > 0 ? new LayoutMeasureFixed(cellHeight, verticalGap) : LayoutMeasureType.getMeasure(type, verticalGap);

			super(alignType, hm, vm);
		}

		public function set horizontalGap(value:int):void
		{
			_horizontalMeasure.gap = value;
		}

		public function set verticalGap(value:int):void
		{
			_horizontalMeasure.gap = value;
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
			_cell.width = _horizontalMeasure.getSize(columnIndex);
			_cell.y = _verticalMeasure.getPosition(rowIndex);
			_cell.height = _verticalMeasure.getSize(rowIndex);

			return _cell;
		}
	}
}