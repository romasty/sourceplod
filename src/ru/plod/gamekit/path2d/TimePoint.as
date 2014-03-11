/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 03.11.11
 * Time: 15:55
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {

	import flash.geom.Point;

	public class TimePoint extends Point {

		private var _time:Number;

		public function TimePoint(time:Number, point:Point)
		{
			_time = time;
			super(point.x, point.y);
		}

		public function get time():Number
		{
			return _time;
		}

		public function set time(value:Number):void
		{
			_time = value;
		}

		override public function equals(p:Point):Boolean
		{
			var p3d:TimePoint = p as TimePoint;
			if (p3d == null) return false;
			return x == p3d.x && y == p3d.y && _time == p3d._time;
		}

		override public function clone():Point
		{
			return new TimePoint(_time, super.clone())
		}

		public override function toString():String
		{
			return "[TimedPoint3D {x:" + x + "; y:" + y + "; time:" + _time + "}]";
		}
	}
}
