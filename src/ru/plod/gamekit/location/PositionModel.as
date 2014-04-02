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

		protected var _position:Point = new Point();
		protected var _rotation:Point = new Point();

		protected var _logicPosition:IPositionLogic;
		protected var _logicRotation:IPositionLogic;

		public function PositionModel()
		{
			eventPositionChange.target = this;
			eventRotationChange.target = this;
		}

		public function getPosition(time:Number = NaN):Point
		{
			if (!isNaN(time) && _logicPosition) _position = _logicPosition.update(time, _position);
			return _position;
		}

		public function setPosition(position:Point, stopMove : Boolean = true):void
		{
			_position.copyFrom(position);
			if(stopMove) _logicPosition = null;
			eventPositionChange.broadcast();
		}

		public function getRotation(time:Number = NaN):Point
		{
			if (!isNaN(time) && _logicRotation) _position = _logicRotation.update(time, _rotation);
			return _rotation;
		}

		public function setRotation(rotation:Point, stopRotate : Boolean = true):void
		{
			_rotation.copyFrom(rotation);
			if(stopRotate) _logicRotation = null;
			eventPositionChange.broadcast();
		}


		public function setLogicPosition(val:IPositionLogic, startPosition:Point = null):void
		{
			if (val != _logicPosition) {
				_logicPosition = val;
				if (startPosition) _position.copyFrom(startPosition);
				eventPositionChange.broadcast();
			}
		}

		public function setLogicRotation(val:IPositionLogic, startRotation:Point = null):void
		{
			if (val != _logicRotation) {
				_logicRotation = val;
				if (startRotation) _rotation.copyFrom(startRotation);
				eventRotationChange.broadcast();
			}
		}

		public function clear():void
		{
			_logicPosition = null;
			_logicRotation = null;
			eventPositionChange.broadcast();
			eventRotationChange.broadcast();
		}
	}
}
