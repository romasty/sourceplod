/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 03.11.11
 * Time: 15:57
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {
	import flash.geom.Point;

	import ru.plod.core.geom.GeomUtil;

	import ru.plod.core.geom.ParametricPoint;


	public class PathBase {

		private var _start:ParametricPoint;
		private var _end:ParametricPoint;
		private var _points:Vector.<ParametricPoint>;
		private var _edges:Vector.<TimeEdge>;



		public function PathBase(path:Vector.<Point>)
		{
			if (path == null || path.length == 0) {
				throw new ArgumentError();
			}

			if(path is Vector.<ParametricPoint>) {
				_points = Vector.<ParametricPoint>(path);
			} else {
				_points = GeomUtil.getParametricPoints(path, 1, 0);
			}

			_start = _points[0];
			_end = _points[_points.length - 1];

			createEdges();
		}

		private function createEdges():void
		{
			_edges = new Vector.<TimeEdge>();

			if(_points.length > 2) {
				var t1:ParametricPoint;
				var t2:ParametricPoint;
				for (var i:int = 1; i < _points.length; i++) {
					t1 = _points[i - 1];
					t2 = _points[i];
					_edges.push(new TimeEdge(t1, t2));
				}
			} else {
				_edges.push(new TimeEdge(_start, _end));
			}
		}


		public function getPosition(time:Number):ParametricPoint
		{
			if (time <= _start.t) {
				return _start;
			} else if (time >= _end.t) {
				return _end;
			} else {
				return getEdge(time).getAtTime(time);
			}
		}


		public function getDirection(time:Number):Number
		{
			if (time <= _start.t) {
				return _edges[0].direction;
			} else if (time >= _end.t) {
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

		public function get points():Vector.<ParametricPoint>
		{
			return _points;
		}

		public function get edges():Vector.<TimeEdge>
		{
			return _edges;
		}

		public function get start():ParametricPoint
		{
			return _start;
		}

		public function get end():ParametricPoint
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


		public function offset(x : Number, y : Number, time : Number) : void
		{
			for each (var point:ParametricPoint in _points) {
				point.x += x;
				point.y += y;
				point.t += time;
			}
		}

		public function equals(path : PathBase) : Boolean
		{
			if(path.points.length != _points.length) return false;

			for (var i:int = 0; i < _points.length; i++) {
				var p:ParametricPoint = _points[i];
				if(!_points[i].equals(path.points[i])) return false;
			}

			return true;
		}

		public function clone() : PathBase
		{
			return new PathBase(_points.concat() as Vector.<Point>);
		}
	}
}