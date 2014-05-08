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
	import ru.plod.gamekit.path2d.IPath2dSegment;


	public class PathBase implements IPath2d{

		private var _segments:Vector.<IPath2dSegment>;
		private var iterator:SegmentIterator;

		public function PathBase(segments:Vector.<IPath2dSegment> = null)
		{
			_segments = segments ? segments : new Vector.<IPath2dSegment>();

			iterator = new SegmentIterator();
			iterator.segments = _segments;
		}

		/*private function createSegments():void
		 {
		 _segments = new Vector.<IPath2dSegment>();

		 if(_points.length > 2) {
		 var t1:ParametricPoint;
		 var t2:ParametricPoint;
		 for (var i:int = 1; i < _points.length; i++) {
		 t1 = _points[i - 1];
		 t2 = _points[i];
		 _segments.push(new LineSegment(t1, t2));
		 }
		 } else {
		 _segments.push(new LineSegment(_start, _end));
		 }
		 }*/

		public function get segments():Vector.<IPath2dSegment>
		{
			return _segments;
		}


		public function getPosition(distance:Number, point : Point = null):Point
		{
			var s:IPath2dSegment = iterator.getCurrent(distance);
			return s.getPosition(iterator.segmentDistance, point);
		}

		public function getDirection(distance:Number):Number
		{
			var s:IPath2dSegment = iterator.getCurrent(distance);
			return s.getDirection(iterator.segmentDistance);
		}

		public function getSegment(distance:Number):IPath2dSegment
		{
			return iterator.getCurrent(distance);
		}



		public function get start():Point
		{
			return _segments.length ? _segments[0].start : null;
		}

		public function get end():Point
		{
			return _segments.length ? _segments[_segments.length - 1].end : null;
		}

		public function get length():Number
		{
			var l:Number = 0;
			for each (var segment:IPath2dSegment in _segments) {
				l += segment.length;
			}
			return l;
		}


		public function offset(dx:Number, dy:Number):void
		{
			//TODO
			/*for each (var point:Point in _points) {
			 point.offset(dx, dy)
			 }*/
		}


		public function slice(start:Number, end:Number):IPath2dSegment
		{
			//TODO
			return null;
		}

		public function equals(path:PathBase):Boolean
		{
			//TODO:
			/*if(path.points.length != _points.length) return false;

			 for (var i:int = 0; i < _points.length; i++) {
			 var p:ParametricPoint = _points[i];
			 if(!_points[i].equals(path.points[i])) return false;
			 }*/

			return true;
		}

		public function clone():PathBase
		{
			return new PathBase(_segments.concat() as Vector.<IPath2dSegment>);
		}
	}
}

import ru.plod.gamekit.path2d.IPath2dSegment;

//TODO;
class SegmentIterator {

	internal var segments:Vector.<IPath2dSegment>;

	internal var currentIndex:int = 0;
	internal var currentSegment:IPath2dSegment = null;
	internal var currentDistance:Number = 0;
	internal var segmentDistance:Number = 0;

	internal function getCurrent(distance:Number):IPath2dSegment
	{
		if (distance != currentDistance) {
			currentDistance = segmentDistance = distance;
			for each (var segment:IPath2dSegment in segments) {
				var segmentLength:Number = segment.length;
				if (segmentDistance <= segmentLength) {
					break;
				}
				segmentDistance -= segmentLength;
				currentIndex++;
			}

			currentSegment = segment;
			segmentDistance += segmentLength;
		}
		return currentSegment;
	}


}