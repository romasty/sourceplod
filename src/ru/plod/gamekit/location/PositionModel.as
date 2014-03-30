/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 3/30/14
 * Time: 11:26 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.location {
	import flash.geom.Point;

	import ru.plod.broadcaster.Broadcaster;

	public class PositionModel {

		public const eventPositionChange:Broadcaster = new Broadcaster();
		public const eventRotationChange:Broadcaster = new Broadcaster();
		internal const eventKill:Broadcaster = new Broadcaster();

		protected var _position:IPosition;
		protected var _rotation:IPosition;
		private var _killed:Boolean;

		public function PositionModel()
		{
			eventPositionChange.target = this;
			eventRotationChange.target = this;
			eventKill.target = this;
		}


		public function get position():IPosition
		{
			return _position;
		}


		public function set position(val:IPosition):void
		{
			if (_killed) return;
			if (val != _position) {
				_position = val;
				eventPositionChange.broadcast();
			}
		}

		public function get rotation():IPosition
		{
			return _rotation;
		}

		public function set rotation(val:IPosition):void
		{
			if (_killed) return;
			if (val != _rotation) {
				_rotation = val;
				eventRotationChange.broadcast();
			}
		}


		public function get inMove():Boolean
		{
			if (_position) {
				var current:Point = _position.getCurrentValue();
				var final:Point = _position.getFinalValue();
				if (current && final && !current.equals(final)) return true;
			}
			return false;
		}

		public function kill():void
		{
			if (!_killed) {
				_killed = true;
				_position = null;
				_rotation = null;
				eventKill.broadcast();
			}
		}


		public function get killed():Boolean
		{
			return _killed;
		}
	}
}
