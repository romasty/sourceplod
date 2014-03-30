/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 03.11.11
 * Time: 15:57
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {
	import flash.geom.Point;

	public class TimePath {

		public static function getTimePoints(points:Vector.<Point>, speed:Number, startTime:Number):Vector.<TimePoint>
		{
			if (speed <= 0) {
				throw new ArgumentError();
			}

			var timePoints:Vector.<TimePoint> = new Vector.<TimePoint>();

			var timePoint:TimePoint = new TimePoint(startTime, points[0]);
			timePoints.push(timePoint);
			if (points.length > 0) {
				for (var i:int = 1; i < points.length; i++) {
					var point:Point = points[i];
					var distance:Number = Point.distance(timePoint, point);
					var time:Number = timePoint.time + distance / speed;
					timePoint = new TimePoint(time, point);
					timePoints.push(timePoint);
				}
			}

			return timePoints;
		}


		private var _start:TimePoint;
		private var _end:TimePoint;
		private var _points:Vector.<TimePoint>;
		private var _edges:Vector.<TimeEdge>;

		public function TimePath(path:Vector.<TimePoint>)
		{
			_points = path;
			if (_points == null || _points.length < 2) {
				throw new ArgumentError();
			}

			_start = _points[0];
			_end = _points[_points.length - 1];

			createEdges();
		}

		private function createEdges():void
		{
			_edges = new Vector.<TimeEdge>();
			var t1:TimePoint;
			var t2:TimePoint;

			for (var i:int = 1; i < _points.length; i++) {
				t1 = _points[i - 1];
				t2 = _points[i];
				_edges.push(new TimeEdge(t1, t2));
			}
		}


		public function getPosition(time:Number):TimePoint
		{
			if (time <= _start.time) {
				return _start;
			} else if (time >= _end.time) {
				return _end;
			} else {
				return getEdge(time).getAtTime(time);
			}
		}


		public function getDirection(time:Number):Number
		{
			if (time <= _start.time) {
				return _edges[0].direction;
			} else if (time >= _end.time) {
				return _edges[_edges.length - 1].direction;
			} else {
				return getEdge(time).direction;
			}
		}

		public function getEdge(time:Number):TimeEdge
		{
			for each (var timedEdge:TimeEdge in _edges) {
				if (timedEdge.atTime(time)) return timedEdge;
			}

			return null;
		}

		public function get points():Vector.<TimePoint>
		{
			return _points;
		}

		public function get edges():Vector.<TimeEdge>
		{
			return _edges;
		}

		public function get start():TimePoint
		{
			return _start;
		}

		public function get end():TimePoint
		{
			return _end;
		}

		public function get length() : Number
		{
			var l : Number = 0;
			for each (var timeEdge:TimeEdge in _edges) {
				l+=timeEdge.length;
			}
			return l;
		}

		public function get followTime():Number
		{
			var t : Number = 0;
			for each (var timeEdge:TimeEdge in _edges) {
				t+=timeEdge.followTime;
			}
			return t;
		}
	}
}