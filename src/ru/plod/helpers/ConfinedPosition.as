/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/6/14
 * Time: 10:44 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.helpers {

	public class ConfinedPosition {

		private var _min:Number;
		private var _max:Number;
		private var _value:Number;

		public function ConfinedPosition(min:Number, max:Number, value:Number = NaN)
		{
			_min = min;
			_max = max;
			_value = isNaN(value) ? _min : value;
			validateValue();
		}

		public function get min():Number
		{
			return _min;
		}

		public function set min(value:Number):void
		{
			if(_min == value) return;
			_min = value;
			validateValue();
		}

		public function get max():Number
		{
			return _max;
		}

		public function set max(value:Number):void
		{
			if(_max == value) return;
			_max = value;
			validateValue();
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			if(_value == value) return;
			_value = value;
			validateValue();
		}


		public function get position():Number
		{
			return _min == _max ? 0 : (_value - _min)/(_max - _min);
		}

		public function set position(pos : Number) : void
		{
			if(pos < 0) pos =  0;
			if(pos > 1) pos = 1;
			if(_min == _max) _value = _min;

			_value = pos * (_max - _min) + _min;
		}

		public function get inverted() : Boolean
		{
			return _min > _max;
		}

		public function get degenerate() : Boolean
		{
			return _min == _max;
		}

		public function change(min : Number, max : Number) : void
		{
			if(_min == min && _max == max) return;
			var pos : Number = position;
			_min = min;
			_max = max;
			position = pos;
		}

		public function offset(x : Number) : void
		{
			_min += x;
			_max += x;
			_value += x;
		}

		public function reverse() : void
		{
			change(_max, _min);
		}

		public function normalize() : void
		{
			change(0, 1);
		}

		public function get length() : Number
		{
			return Math.abs(_max - _min);
		}

		private function validateValue():void
		{
			if (_min < _max) {

				if (_value < _min) _value = _min;
				else if (_value > _max) _value = _max;

			} else if (_min > _max) {

				if (_value < _max) _value = _max;
				else if (_value > _min) _value = _min;

			} else {
				_value = _min;
			}
		}

		public function clone() : ConfinedPosition
		{
			return new ConfinedPosition(_min, _max, _value);
		}

		public function equals(s : ConfinedPosition) : Boolean
		{
			return s ? s._min == _min && s._max == _max && s._value == _value : false;
		}

		public function toString():String
		{
			var str:String = "Segment {"
			           str += "min:"+_min+"; ";
			           str += "max:"+_max+"; ";
			           str += "value:"+_value+"; ";
			           str += "position:"+position+"; ";
			           str += "length:"+length+"; ";
			str+="}"
			return str;
		}
	}
}
