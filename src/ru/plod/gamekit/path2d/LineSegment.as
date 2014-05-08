/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/25/14
 * Time: 11:23 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {

	import flash.geom.Point;

	import ru.plod.core.geom.Edge;

	public class LineSegment extends Edge implements IPath2dSegment{

		public function LineSegment(start:Point = null, end:Point = null)
		{
			start = start ? start : new Point();
			end = end ? end : new Point();
			super(start, end);
		}


		public function get start():Point
		{
			return startPoint;
		}

		public function get end():Point
		{
			return endPoint;
		}


		public function getPosition(distance:Number, point : Point = null):Point
		{
			if(distance < 0) distance = 0;
			else if(distance > length) distance = length;

			point = point ? point : new Point();
			var k:Number = distance / length;
			point.x = startPoint.x + k * (endPoint.x - startPoint.x);
			point.y = startPoint.y + k * (endPoint.y - startPoint.y);

			return point;
		}


		public function getDirection(time : Number):Number
		{
			if (startPoint.x == endPoint.x && startPoint.y == endPoint.y) return undefined;
			return Math.atan2(endPoint.y - startPoint.y, endPoint.x - startPoint.x);
		}


		public function equals(segment:LineSegment):Boolean
		{
			return false;
		}

		public function clone():LineSegment
		{
			return new LineSegment(startPoint.clone(), endPoint.clone());
		}


		public function slice(start:Number, end:Number):IPath2dSegment
		{
			var segment : LineSegment = new LineSegment();
			segment.startPoint = getPosition(start, segment.startPoint);
			segment.endPoint = getPosition(end, segment.endPoint);
			return segment;
		}
	}
}
