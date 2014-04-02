/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 4/1/14
 * Time: 5:09 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.path2d {

	public class RealtimePath {

		private var _speed : Number = 1;
		private var _startTime : Number = 0;

		public function RealtimePath()
		{
		}
		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(speed : Number) : void
		{
			if(_speed != speed) {
				if(speed <= 0) throw new ArgumentError();

				_speed = speed;
				//TODO; recalculate points
			}
		}

		public function get startTime(): Number
		{
			return _startTime;
		}

		public function set startTime(value : Number):void
		{
			if(_startTime != value) {
				_startTime = value;
				//TODO; recalculate points
			}
		}
	}
}
