/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 03.11.11
 * Time: 15:55
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.geom {

	import flash.geom.Point;

	public class ParametricPoint extends Point {

		public var t:Number;

		public function ParametricPoint(x:Number = 0, y : Number = 0, t : Number = 0)
		{
			this.t = t;
			super(x, y);
		}

		override public function equals(p:Point):Boolean
		{
			var tp:ParametricPoint = p as ParametricPoint;
			if (tp == null) return false;
			return x == tp.x && y == tp.y && t == tp.t;
		}

		override public function clone():Point
		{
			return new ParametricPoint(x, y, t);
		}

		public override function toString():String
		{
			return "[ParametricPoint {x:" + x + "; y:" + y + "; t:" + t + "}]";
		}
	}
}
