/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/18/14
 * Time: 11:00 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {
	import flash.geom.Point;

	public interface IPath2dSegment {

		function get start() : Point;

		function get end() : Point;

		function getPosition(distance:Number, point : Point = null):Point

		function getDirection(distance:Number):Number;

		function slice(start : Number, end : Number) : IPath2dSegment;

		function get length():Number;
	}
}
