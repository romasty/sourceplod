/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/1/14
 * Time: 7:47 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.geom {
	import flash.geom.Point;


	public class Edge {

		public var startPoint:Point;
		public var endPoint:Point;


		public function Edge(start:Point, end:Point)
		{
			this.startPoint = start;
			this.endPoint = end;
		}

		public function get length():Number
		{
			return Point.distance(startPoint, endPoint);
		}


		public function projectionPoint(point:Point):Point
		{
			var result:Point = new Point();

			var dx:Number = endPoint.x - startPoint.x;
			var dy:Number = endPoint.y - startPoint.y;
			var sx:Number = point.x - startPoint.x;
			var sy:Number = point.y - startPoint.y;
			var k:Number = (sx * dx + sy * dy) / (dx * dx + dy * dy);
			result.x = startPoint.x + dx * k;
			result.y = startPoint.y + dy * k;

			return result;
		}

		public function distanceToPoint(point:Point):Number
		{
			return Point.distance(point, projectionPoint(point));
		}

		public function projectionEdge(edge:Edge):Edge
		{
			return new Edge(projectionPoint(edge.startPoint), projectionPoint(edge.endPoint));
		}

		public function intersection(edge:Edge, strict:Boolean = true):Point
		{
			var result:Point;

			var d:Number = (startPoint.x - endPoint.x) * (edge.endPoint.y - edge.startPoint.y) - (startPoint.y - endPoint.y) * (edge.endPoint.x - edge.startPoint.x);

			var da:Number = (startPoint.x - edge.startPoint.x) * (edge.endPoint.y - edge.startPoint.y) - (startPoint.y - edge.startPoint.y) * (edge.endPoint.x - edge.startPoint.x);
			var db:Number = (startPoint.x - endPoint.x) * (startPoint.y - edge.startPoint.y) - (startPoint.y - endPoint.y) * (startPoint.x - edge.startPoint.x);

			var ta:Number = da / d;
			var tb:Number = db / d;
			if (isNaN(ta) || isNaN(tb)) return null;

			if (!strict || (ta >= 0 && ta <= 1 && tb >= 0 && tb <= 1)) {
				var dx:Number = startPoint.x + ta * (endPoint.x - startPoint.x);
				var dy:Number = startPoint.y + ta * (endPoint.y - startPoint.y);

				return new Point(dx, dy);
			}

			return result;
		}

		public function containsPoint(point:Point, strict:Boolean = true):Boolean
		{
			var res:Boolean = Math.abs(( point.x - startPoint.x) * (endPoint.y - startPoint.y) - (point.y - startPoint.y) * (endPoint.x - startPoint.x)) <.000001;
			if(strict) res &&= ((startPoint.x < point.x && point.x < endPoint.x) || (endPoint.x < point.x && point.x < startPoint.x));

			return res;
		}

		/*public function equals(edge:Edge):Boolean
		{
			return startPoint.equals(edge.startPoint) && endPoint.equals(edge.endPoint);
		}

		public function clone():Edge
		{
			return new Edge(startPoint.clone(), endPoint.clone());
		}*/

		public function toString():String
		{
			return "[Edge {start:" + startPoint + "; end:" + endPoint + "; length:" + length + "}]";
		}
	}
}
