/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/13/14
 * Time: 1:16 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.math {
	public class MeasureQueue {

		private var _positions:Vector.<int> = new Vector.<int>();
		private var _sizes:Vector.<int> = new Vector.<int>();
		private var _changed:Boolean;
		private var _total:int;

		public function MeasureQueue()
		{
		}

		public function put(index:int, size:int):void
		{
			if (_sizes.length <= index) {
				_sizes.length = index;
				_sizes[index] = size;
				_changed = true;
			} else {
				if(size > _sizes[index]) {
					_sizes[index] = size;
					_changed = true;
				}
			}
		}

		public function push(size:int):void
		{
			_sizes.push(size);
			_changed = true;
		}

		public function unshift(size:int):void
		{
			_sizes.unshift(size);
			_changed = true;
		}

		public function shift() : int
		{
			_changed = true;
			return _sizes.shift();
		}

		public function pop() : int
		{
			_changed = true;
			return _sizes.pop();
		}


		public function get sizes():Vector.<int>
		{
			return _sizes;
		}

		public function get positions():Vector.<int>
		{
			if (_changed) {
				_changed = false;
				calculate();
			}
			return _positions;
		}

		public function get totalSize():int
		{
			if (_changed) {
				_changed = false;
				calculate();
			}
			return _total;
		}

		public function get length():uint
		{
			return _sizes.length;
		}

		public function set length(value:uint):void
		{
			_changed ||= value < _sizes.length;
			_sizes.length = value;
		}

		private function calculate():void
		{
			_total = 0;
			_positions.length = 0;
			_positions.push(0);
			for (var i:int = 1; i < _sizes.length; i++) {
				_total += _sizes[i - 1];
				_positions.push(_total);
			}
		}
	}
}
