/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/9/14
 * Time: 12:35 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {
	import flash.geom.Rectangle;

	import ru.plod.gui.layout.measure.ILayoutElementMeasure;
	import ru.plod.gui.layout.measure.LayoutMeasureFixed;
	import ru.plod.gui.layout.measure.LayoutMeasureIndividual;
	import ru.plod.gui.layout.measure.LayoutMeasureType;
	import ru.plod.gui.layout.measure.LayoutMeasureUnion;

	public class VerticalLayout extends AbstractCellLayout{

		public function VerticalLayout(alignType:String = null, type : String = "individual", cellWidth:int=0, cellHeight:int=0)
		{
			var hm:ILayoutElementMeasure = cellWidth ? new LayoutMeasureFixed(cellWidth) : new LayoutMeasureUnion();
			var vm:ILayoutElementMeasure = LayoutMeasureType.getMeasure(type, cellHeight);

			super(alignType, hm, vm);
		}


		override protected function getRectangle(index:uint):Rectangle
		{
			_cell.x = 0;
			_cell.y = _verticalMeasure.getPosition(index);
			_cell.width = _horizontalMeasure.getSize(index);
			_cell.height = _verticalMeasure.getSize(index);

			return _cell;
		}
	}
}
