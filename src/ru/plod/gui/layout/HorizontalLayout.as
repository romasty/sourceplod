/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/9/14
 * Time: 12:35 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {
	import flash.geom.Rectangle;

	import ru.plod.gui.layout.measure.ISizeMeasure;
	import ru.plod.gui.layout.measure.SizeMeasureUnion;

	public class HorizontalLayout extends AbstractCellLayout implements ILayout {

		public function HorizontalLayout(alignType:String = null)
		{
			var hm:ISizeMeasure = new SizeMeasureUnion();
			var vm:ISizeMeasure = new SizeMeasureUnion();

			super(alignType, hm, vm);
		}


		override protected function getRectangle(index:uint):Rectangle
		{
			_cell.x = _horizontalMeasure.getPosition(index);
			//_cell.y = _verticalMeasure.getPosition(index);
			_cell.width = _horizontalMeasure.getSize(index);
			_cell.height = _verticalMeasure.getSize(index);

			return _cell;
		}
	}
}
