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

		public var start:Point;
		public var end:Point;


		public function Edge(start:Point, end:Point)
		{
			this.start = start;
			this.end = end;
		}

		public function get length():Number
		{
			return Point.distance(start, end);
		}


		public function projectionPoint(point:Point):Point
		{
			var result:Point = new Point();

			var dx:Number = end.x - start.x;
			var dy:Number = end.y - start.y;
			var sx:Number = point.x - start.x;
			var sy:Number = point.y - start.y;
			var k:Number = (sx * dx + sy * dy) / (dx * dx + dy * dy);
			result.x = start.x + dx * k;
			result.y = start.y + dy * k;

			return result;
		}

		public function distanceToPoint(point:Point):Number
		{
			return Point.distance(point, projectionPoint(point));
		}

		public function projectionEdge(edge:Edge):Edge
		{
			return new Edge(projectionPoint(edge.start), projectionPoint(edge.end));
		}

		public function intersection(edge:Edge, strict:Boolean = true):Point
		{
			var result:Point;

			var d:Number = (start.x - end.x) * (edge.end.y - edge.start.y) - (start.y - end.y) * (edge.end.x - edge.start.x);

			var da:Number = (start.x - edge.start.x) * (edge.end.y - edge.start.y) - (start.y - edge.start.y) * (edge.end.x - edge.start.x);
			var db:Number = (start.x - end.x) * (start.y - edge.start.y) - (start.y - end.y) * (start.x - edge.start.x);

			var ta:Number = da / d;
			var tb:Number = db / d;
			if (isNaN(ta) || isNaN(tb)) return null;

			if (!strict || (ta >= 0 && ta <= 1 && tb >= 0 && tb <= 1)) {
				var dx:Number = start.x + ta * (end.x - start.x);
				var dy:Number = start.y + ta * (end.y - start.y);

				return new Point(dx, dy);
			}

			return result;
		}

		public function containsPoint(point:Point, strict:Boolean = true):Boolean
		{
			var res:Boolean = Math.abs(( point.x - start.x) * (end.y - start.y) - (point.y - start.y) * (end.x - start.x)) <.000001;
			if(strict) res &&= ((start.x < point.x && point.x < end.x) || (end.x < point.x && point.x < start.x));

			return res;
		}

		public function equals(edge:Edge):Boolean
		{
			return start.equals(edge.start) && end.equals(edge.end);
		}

		public function clone():Edge
		{
			return new Edge(start.clone(), end.clone());
		}

		public function toString():String
		{
			return "[Edge {start:" + start + "; end:" + end + "; length:" + length + "}]";
		}
	}
}
