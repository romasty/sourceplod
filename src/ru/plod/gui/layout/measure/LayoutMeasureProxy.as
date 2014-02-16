/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/16/14
 * Time: 11:29 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {
	public class LayoutMeasureProxy implements ILayoutMeasure {

		private var _measure : ILayoutMeasure;


		public function LayoutMeasureProxy(measure:ILayoutMeasure)
		{
			_measure = measure;
		}

		public function measure(index:uint, size:int):void
		{
			_measure.measure(index, size);
		}

		public function getPosition(index:uint):int
		{
			return _measure.getPosition(index);
		}

		public function getSize(index:uint):int
		{
			return _measure.getSize(index);
		}

		public function get totalSize():int
		{
			return _measure.totalSize;
		}

		public function get gap():int
		{
			return 0;
		}

		public function set gap(value:int):void
		{
		}
	}
}
