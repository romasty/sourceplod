/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 04.06.12
 * Time: 13:37
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.stats {
	import ru.plod.broadcaster.Broadcaster;

	public class StatValue {

		public const eventChange : Broadcaster = new Broadcaster();

        public var name:*;
		protected var _value:int;

        public function StatValue(name:*, val:int = 0)
        {
            this.name = name;
			_value = val;
			eventChange.target = this;
        }


		public function get value():int
		{
			return _value;
		}

		public function set value(val:int):void
		{
			if(_value != val) {
				_value = value;
				eventChange.broadcast();
			}
		}

		public function clone():StatValue
        {
            return new StatValue(name, value);
        }

		public function equals(stat : StatValue) : Boolean
		{
			return stat ? stat.name == name && stat.value == value : false;
		}

        public function toString():String
        {
            return "[StatValue {name=" + name + "; value=" + value + ";}]";
        }
    }
}
