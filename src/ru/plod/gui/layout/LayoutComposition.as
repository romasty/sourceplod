/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/17/14
 * Time: 12:52 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {
	import flash.display.DisplayObject;

	public class LayoutComposition implements ILayout {

		protected var _layouts : Vector.<ILayout>;

		public function LayoutComposition()
		{
		}

		public function addLayout(layout : ILayout):void
		{
			var index:int = _layouts.indexOf(layout);
			if(index!=-1) {
				_layouts.splice(index, 1);
			}
			_layouts.push(layout);
		}

		public function addLayoutAt(layout : ILayout, index:int):void
		{
			var currentIndex:int = _layouts.indexOf(layout);
			if(currentIndex!=-1) {
				_layouts.splice(currentIndex, 1);
			}
			_layouts.splice(index, 0, layout);
		}

		public function removeLayout(layout : ILayout) : void
		{
			var index:int = _layouts.indexOf(layout);
			if(index!=-1) {
				_layouts.splice(index, 1);
			}
		}

		public function getLayoutAt(index:int) : ILayout
		{
			return _layouts[index];
		}

		public function get numLayouts():uint
		{
			return _layouts.length;
		}

		public function arrange(children:Vector.<DisplayObject>):void
		{

		}
	}
}
