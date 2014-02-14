/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 1/28/14
 * Time: 7:37 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout {
	import flash.display.DisplayObject;

	public interface ILayout {

		function arrange(children : Vector.<DisplayObject>) : void
	}
}
