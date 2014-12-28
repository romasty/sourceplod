/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 12/27/14
 * Time: 3:13 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.iso
{
    import flash.geom.Point;

    public class IsoPoint
    {
        private const scrPoint : Point = new Point();
        private static const kx : Number = 1 / Math.sqrt(2);
        private static const ky : Number = 1 / Math.sqrt(6);

        public var x : int;
        public var y : int;
        public var z : int;

        public function IsoPoint(x : int = 0, y : int = 0, z : int = 0)
        {
            this.x = x;
            this.y = y;
            this.z = z;
        }

        public function toScreen() : Point
        {
            scrPoint.x = kx * (x - y);
            scrPoint.y = ky * (x - 2 * z + y);
            return scrPoint;
        }

    }
}
