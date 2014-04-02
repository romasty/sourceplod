/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/1/14
 * Time: 5:57 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {
	import flash.geom.Point;

	public interface IPath2d {

		function getPosition(t:Number):Point

		function getDirection(t:Number):Number;

		function get length():Number;

		function equals(path:IPath2d):Boolean;

		function clone():IPath2d;
	}
}
