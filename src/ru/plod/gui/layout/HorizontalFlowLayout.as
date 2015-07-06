/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/16/14
 * Time: 5:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;


	import ru.plod.gui.layout.measure.ILayoutMeasure;
	import ru.plod.gui.layout.measure.LayoutMeasureFixed;
	import ru.plod.gui.layout.measure.LayoutMeasureIndividual;
	import ru.plod.gui.layout.measure.LayoutMeasureType;
	import ru.plod.gui.layout.measure.LayoutMeasureUnion;

	public class HorizontalFlowLayout extends AbstractCellLayout implements ILayout {

		private var _maxWidth : int  = 300;

		private var _indexList :Vector.<Object> = new Vector.<Object>();
		private var _horizontalList :Vector.<ILayoutMeasure> = new Vector.<ILayoutMeasure>();

		public function HorizontalFlowLayout(alignType:String = null, gap:int = 0, type:String = "individual", cellWidth:int = 0, cellHeight:int = 0)
		{
			var hm:ILayoutMeasure = cellWidth > 0 ? new LayoutMeasureFixed(cellWidth, gap) : LayoutMeasureType.getMeasure(type, gap);
			var vm:ILayoutMeasure = cellHeight > 0 ? new LayoutMeasureFixed(cellHeight) : LayoutMeasureType.getMeasure(type, gap);
			super(alignType, hm, vm);
		}


		override protected function measure(children:Vector.<DisplayObject>):void
		{

			var colIndex:uint;
			var rowIndex : uint;
			var measureIntermediate : ILayoutMeasure = new LayoutMeasureIndividual();
			_horizontalList.push(measureIntermediate);

			for (var index:int = 0; index < children.length; index++) {
				var child:DisplayObject = children[index];

				if(measureIntermediate.totalSize + child.width + measureIntermediate.gap > _maxWidth) {
					measureIntermediate = new LayoutMeasureIndividual();
					_horizontalList.push(measureIntermediate);
					colIndex = 0;
					rowIndex++;
				}

				measureIntermediate.measure(colIndex, child.width);
				_verticalMeasure.measure(rowIndex, child.height);
				_indexList[index] = {colIndex:colIndex, rowIndex : rowIndex};
				colIndex ++;
			}
		}

		override protected function getRectangle(index:uint):Rectangle
		{
			var indexObj : Object = _indexList[index];
			var colIndex : uint = indexObj.colIndex;
			var rowIndex : uint = indexObj.rowIndex;

			var horizontal : ILayoutMeasure = _horizontalList[rowIndex];

			_cell.x = horizontal.getPosition(colIndex);
			_cell.width = horizontal.getSize(colIndex);
			_cell.y = _verticalMeasure.getPosition(rowIndex);
			_cell.height = _verticalMeasure.getSize(rowIndex);

			return _cell;
		}
	}
}
