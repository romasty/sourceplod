/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/6/14
 * Time: 10:44 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.helpers {

	public class Diapason {

		private var _min:Number;
		private var _max:Number;
		private var _value:Number;

		public function Diapason(min:Number = 0, max:Number = 1, value:Number = 0)
		{
			_min = min;
			_max = max;
			_value = value;
			validateValue();
		}

		public function get min():Number
		{
			return _min;
		}

		public function set min(value:Number):void
		{
			if (_min == value) return;
			_min = value;
			validateValue();
		}

		public function get max():Number
		{
			return _max;
		}

		public function set max(value:Number):void
		{
			if (_max == value) return;
			_max = value;
			validateValue();
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			if (_value == value) return;
			_value = value;
			validateValue();
		}


		public function get ratio():Number
		{
			return _min == _max ? 0 : (_value - _min) / (_max - _min);
		}

		public function set ratio(pos:Number):void
		{
			if (pos < 0) pos = 0;
			if (pos > 1) pos = 1;
			if (_min == _max) _value = _min;

			_value = pos * (_max - _min) + _min;
		}

		public function get inverted():Boolean
		{
			return _min > _max;
		}

		public function get degenerate():Boolean
		{
			return _min == _max;
		}

		public function change(min:Number, max:Number):void
		{
			if (_min == min && _max == max) return;
			var pos:Number = ratio;
			_min = min;
			_max = max;
			ratio = pos;
		}

		public function offset(x:Number):void
		{
			_min += x;
			_max += x;
			_value += x;
		}

		public function reverse():void
		{
			change(_max, _min);
		}

		public function normalize():void
		{
			change(0, 1);
		}

		public function get span():Number
		{
			return Math.abs(_max - _min);
		}

		public function contains(target : Diapason):Boolean
		{
			return containsValue(target._min) && containsValue(target._max);
		}

		public function intersects(target : Diapason):Boolean
		{
			var thisMin : Number = _min < _max ? _min : _max;
			var thisMax : Number = _min < _max ? _max : _min;

			var targetMin : Number = target._min < target._max ? target._min : target._max;
			var targetMax : Number = target._min < target._max ? target._max : target._min;

			return (thisMin < targetMin && targetMin < thisMax && targetMax > thisMax) ||
					(thisMin < targetMax && targetMax < thisMax && targetMin < thisMin)
		}

		public function intersection(target : Diapason, result : Diapason = null):Diapason
		{
			if(!intersects(target)) return null;

			if(result == null) result = new Diapason();

			var thisMin : Number = _min < _max ? _min : _max;
			var thisMax : Number = _min < _max ? _max : _min;

			var targetMin : Number = target._min < target._max ? target._min : target._max;
			var targetMax : Number = target._min < target._max ? target._max : target._min;

			if(thisMin < targetMin && targetMin < thisMax) {
				result._min = targetMin;
				result._max = thisMax;
			} else {
				result._min = targetMin;
				result._max = targetMax;
			}

			result.validateValue();

			return result;
		}

		public function containsValue(value : Number):Boolean
		{
			return _min < _max ? (value >= _min && value <= _max) : (value >= _max && value <= _min);
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

		public function clone():Diapason
		{
			return new Diapason(_min, _max, _value);
		}

		public function equals(target:Diapason):Boolean
		{
			return  target._min == _min && target._max == _max && target._value == _value;
		}

		public function copy(source:Diapason):void
		{
			_min = source._min;
			_max = source._max;
			_value = source._value;
		}

		public function toString():String
		{
			var str:String = "[Segment {"
			str += "min:" + _min + "; ";
			str += "max:" + _max + "; ";
			str += "value:" + _value + "; ";
			str += "ratio:" + ratio + "; ";
			str += "span:" + span + "; ";
			str += "}]"
			return str;
		}
	}
}
