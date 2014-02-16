/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/9/14
 * Time: 12:35 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {
	import flash.geom.Rectangle;

	import ru.plod.gui.layout.measure.ILayoutMeasure;
	import ru.plod.gui.layout.measure.LayoutMeasureFixed;
	import ru.plod.gui.layout.measure.LayoutMeasureType;
	import ru.plod.gui.layout.measure.LayoutMeasureUnion;

	public class HorizontalLayout extends AbstractCellLayout implements ILayout {

		public function HorizontalLayout(alignType:String = null, gap:int = 0, type:String = "individual", cellWidth:int = 0, cellHeight:int = 0)
		{
			var hm:ILayoutMeasure = cellWidth > 0 ? new LayoutMeasureFixed(cellWidth, gap) : LayoutMeasureType.getMeasure(type, gap);
			var vm:ILayoutMeasure = cellHeight > 0 ? new LayoutMeasureFixed(cellHeight) : LayoutMeasureType.getMeasure(type, gap);
			super(alignType, hm, vm);
		}

		override protected function getRectangle(index:uint):Rectangle
		{
			_cell.x = _horizontalMeasure.getPosition(index);
			_cell.y = 0;
			_cell.width = _horizontalMeasure.getSize(index);
			_cell.height = _verticalMeasure.getSize(index);

			return _cell;
		}
	}
}
