/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/15/14
 * Time: 12:24 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {
	public interface ISizeMeasure {

		function measure(index:uint, size:int):void;
		function getPosition(index:uint):int;
		function getSize(index:uint):int;
		function get totalSize():int;
	}
}
