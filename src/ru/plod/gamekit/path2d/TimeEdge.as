/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/25/14
 * Time: 11:23 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {

	import flash.geom.Point;

	public  class TimeEdge {

		private var _start:TimePoint;
		private var _end:TimePoint;
		private var _length : Number;
		private var _followTime:Number;
		private var _rotation:Number;

		public function TimeEdge(start:TimePoint, end:TimePoint)
		{
			if(start.time < end.time) throw new ArgumentError();

			this._start = start;
			this._end = end;
			_length = Point.distance(start, end);
			_followTime = end.time - start.time;
			_rotation = Math.atan2(end.y - start.y, end.x - start.x);
		}

		public function get start():TimePoint
		{
			return _start;
		}

		public function get end():TimePoint
		{
			return _end;
		}

		public function get length():Number
		{
			return _length;
		}

		public function get followTime():Number
		{
			return _followTime;
		}

		public function getAtTime(time:Number):TimePoint
		{
			if (time < _start.time || time > _end.time) {
				return null;
			}

			if (time == _start.time) {
				return _start;
			} else if (time == _end.time) {
				return _end;
			} else {

				var k:Number = (time - _start.time) / _followTime;

				var x:Number = approximate(_start.x, _end.x, k);
				var y:Number = approximate(_start.y, _end.y, k);

				return new TimePoint(time, new Point(x, y));
			}
		}

		public function atTime(time : Number) : Boolean
		{
			return time >= _start.time && time <= _end.time;
		}

		public function get rotation():Number
		{
			return _rotation;
		}

		private function approximate(startValue:Number, endValue:Number, k:Number):Number
		{
			return startValue + k * (endValue - startValue);
		}
	}
}
