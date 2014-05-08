/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 3/30/14
 * Time: 11:28 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.attitude {
	import flash.geom.Point;

	public interface IPositionLogic {

		/*function getStartValue() : Point;
		function getValue(time : uint) : Point;
		function getCurrentValue() : Point;
		function getFinalValue() : Point;*/

		function update(time : Number, result : Point) : Point;

	}
}
