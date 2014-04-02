/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/1/14
 * Time: 5:50 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.geom {
	import flash.geom.Point;

	import ru.plod.core.geom.ParametricPoint;

	public class GeomUtil {

		public static function getParametricPoints(points:Vector.<Point>, speed:Number = 1, startTime:Number = 0):Vector.<ParametricPoint>
		{
			if (speed <= 0 || points.length == 0) {
				throw new ArgumentError();
			}

			var timePoints:Vector.<ParametricPoint> = new Vector.<ParametricPoint>();
			var point:Point = points[0];
			var timePoint:ParametricPoint = new ParametricPoint(point.x, point.y, startTime);
			timePoints.push(timePoint);
			if (points.length > 1) {
				for (var i:int = 1; i < points.length; i++) {
					point = points[i];
					var distance:Number = Point.distance(timePoint, point);
					var time:Number = timePoint.t + distance / speed;
					timePoint = new ParametricPoint(point.x, point.y, time);
					timePoints.push(timePoint);
				}
			}

			return timePoints;
		}


		public static function getAngle(point : Point) : Number
		{
			return Math.atan2(point.y, point.x);
		}

		public function getAngle(angle : Number, point : Point) : void
		{
			var l : Number = length;
			point.x = l * Math.cos(angle);
			point.y = l * Math.sin(angle);
		}
	}
}
