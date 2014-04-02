/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/25/14
 * Time: 11:23 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {

	import ru.plod.core.geom.Edge;

	import ru.plod.core.geom.ParametricPoint;

	public class TimeEdge extends Edge {

		protected var tStart:ParametricPoint;
		protected var tEnd:ParametricPoint;

		public function TimeEdge(start:ParametricPoint, end:ParametricPoint)
		{
			if (start.t < end.t) throw new ArgumentError();

			tStart = start as ParametricPoint;
			tEnd = tEnd as ParametricPoint;
			super(start, end);
		}


		public function get followTime():Number
		{
			return tEnd.t - tStart.t;
		}

		public function getAtTime(time:Number):ParametricPoint
		{
			if (time < tStart.t || time > tEnd.t) {
				return null;
			}

			if (time == tStart.t) {
				return tStart;
			} else if (time == tEnd.t) {
				return tEnd;
			} else {

				var k:Number = (time - tStart.t) / followTime;
				var x:Number = tStart.x + k * (tEnd.x - tStart.x);
				var y:Number = tStart.y + k * (tEnd.y - tStart.y);

				return new ParametricPoint(x, y, time);
			}
		}

		public function atTime(time:Number):Boolean
		{
			return time >= tStart.t && time <= tEnd.t;
		}

		public function get direction():Number
		{
			if (tStart.x == tEnd.x && tStart.y == tEnd.y) return undefined;
			return Math.atan2(end.y - start.y, end.x - start.x);
		}

	}
}
