/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/9/14
 * Time: 1:54 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	import ru.plod.gui.layout.measure.ILayoutElementMeasure;
	import ru.plod.gui.layout.measure.LayoutMeasureFixed;
	import ru.plod.gui.layout.measure.LayoutMeasureType;

	public class AbstractCellLayout implements ILayout {

		public var checkBounds : Boolean = true;
		protected var _alignType : String;
		protected var _horizontalMeasure : ILayoutElementMeasure;
		protected var _verticalMeasure : ILayoutElementMeasure;
		protected var _cell : Rectangle = new Rectangle();

		public function AbstractCellLayout(alignType:String, horizontalMeasure:ILayoutElementMeasure, verticalMeasure:ILayoutElementMeasure)
		{
			_alignType = alignType;
			_horizontalMeasure = horizontalMeasure;
			_verticalMeasure = verticalMeasure;
		}


		public function get horizontalMeasure():ILayoutElementMeasure
		{
			return _horizontalMeasure;
		}

		public function set horizontalMeasure(value:ILayoutElementMeasure):void
		{
			if(value != null && value != _horizontalMeasure) {
				_horizontalMeasure = value;
			}
		}

		public function get verticalMeasure():ILayoutElementMeasure
		{
			return _verticalMeasure;
		}

		public function set verticalMeasure(value:ILayoutElementMeasure):void
		{
			if(value != null && value != _verticalMeasure) {
				_verticalMeasure = value;
			}
		}

		public function setHorizontalMeasure(...args):void
		{
			horizontalMeasure = guessMeasure.apply(this, args);
		}

		public function setVerticalMeasure(...args):void
		{
			verticalMeasure = guessMeasure.apply(this, args);
		}

		public function arrange(children:Vector.<DisplayObject>):void
		{
			measure(children);
			var i:int;
			for each(var child:DisplayObject in children) {
				var cell : Rectangle = getRectangle(i);
				arrangeChild(child, cell);
				if(checkBounds) levelBounds(child);
				i++;
			}
		}

		protected function measure(children:Vector.<DisplayObject>):void
		{
			for (var index:int = 0; index < children.length; index++) {
				var child:DisplayObject = children[index];
				_horizontalMeasure.measure(index, child.width);
				_verticalMeasure.measure(index, child.height);
			}
		}

		protected function getRectangle(index:uint):Rectangle
		{
			return _cell;
		}

		protected function levelBounds(child:DisplayObject) : void
		{
			if (child.parent) {
				var bounds:Rectangle = child.getRect(child.parent);
				child.x += (child.x - bounds.x);
				child.y += (child.y - bounds.y);
			}
		}

		protected function arrangeChild(child:DisplayObject, cell : Rectangle):void
		{
			switch (_alignType) {
				case AlignType.LEFT:
				case AlignType.TOP_LEFT:
				case AlignType.BOTTOM_LEFT:
					child.x = cell.x;
					break;
				case AlignType.TOP :
				case AlignType.CENTER :
				case AlignType.BOTTOM :
					child.x = cell.x + .5 * (cell.width - child.width);
					break;
				case AlignType.RIGHT:
				case AlignType.TOP_RIGHT:
				case AlignType.BOTTOM_RIGHT:
					child.x = cell.x + (cell.width - child.width);
					break;
				default : //
			}

			switch (_alignType) {
				case AlignType.TOP_LEFT:
				case AlignType.TOP:
				case AlignType.TOP_RIGHT:
					child.y = cell.y;
					break;
				case AlignType.LEFT :
				case AlignType.CENTER :
				case AlignType.RIGHT :
					child.y = cell.y + .5 * (cell.height - child.height);
					break;
				case AlignType.BOTTOM_LEFT:
				case AlignType.BOTTOM:
				case AlignType.BOTTOM_RIGHT:
					child.y = cell.y + (cell.height - child.height);
					break;
				default : //
			}
		}

		private function guessMeasure(...args) : ILayoutElementMeasure
		{
			if(args.length == 0) {
				throw new ArgumentError("expected one or more argumens");
			}

			var value :* = args.shift();
			if(value is ILayoutElementMeasure) {
				return value;
			} else if(value is String) {
				args.unshift(value);
				return LayoutMeasureType.getMeasure.apply(null, args);
			} else if(value is int) {
				return new LayoutMeasureFixed(value);
			}

			return null;
		}
	}
}
