/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/2/14
 * Time: 12:02 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.geom {
	import flash.geom.Point;

	public class Line {

		//ax + by + c = 0

		public var a:Number;
		public var b:Number;
		public var c:Number;

		public function Line()
		{
		}


		//TODO
		public function getNormal() : Line
		{
			var l : Line = new Line();
			l.a = b;
			l.b = -a;
			l.c = 200

			return l;

		}

		public function getY(x:Number):Number
		{
			return -(a * x + c) / b;
		}

		public function getX(y:Number):Number
		{
			return -(b * y + c) / a
		}

		public function projectionPoint(point:Point):Point
		{
			var result:Point = new Point()

			result.x = (b * b * point.x - b * a * point.y - a * c) / (a * a + b * b);
			result.y = -( a * result.x + c) / b;

			return result;
		}

	}
}
