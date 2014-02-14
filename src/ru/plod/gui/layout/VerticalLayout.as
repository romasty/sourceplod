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
	import ru.plod.gui.layout.measure.SizeMeasureFixed;
	import ru.plod.gui.layout.measure.SizeMeasureIndividual;

	public class VerticalLayout extends AbstractCellLayout{

		public function VerticalLayout(alignType:String = null)
		{
			var hm:ISizeMeasure = new SizeMeasureFixed(300);
			var vm:ISizeMeasure = new SizeMeasureIndividual();

			super(alignType, hm, vm);
		}


		override protected function getRectangle(index:uint):Rectangle
		{
			//_cell.x = _horizontalMeasure.getPosition(index);
			_cell.y = _verticalMeasure.getPosition(index);
			_cell.width = _horizontalMeasure.getSize(index);
			_cell.height = _verticalMeasure.getSize(index);

			return _cell;
		}
	}
}
