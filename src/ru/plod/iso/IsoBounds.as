/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 12/28/14
 * Time: 6:35 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.iso
{
    import flash.geom.Rectangle;

    public class IsoBounds extends IsoPoint
    {
        protected const scrBounds : Rectangle = new Rectangle();
        public var width : int;
        public var length : int;
        public var height : int;


        public function IsoBounds(width : int = 0, length : int = 0, height : int = 0, x : int = 0, y : int = 0, z : int = 0)
        {
            this.width = width;
            this.length = length;
            this.height = height;
            super(x, y, z);

        }

        public function getScreenBounds() : Rectangle
        {
            scrBounds.x = kx * (x + y);
            scrBounds.y = ky * (x - y - length - 2 * (z + height));
            scrBounds.width = kx * ( width + length);
            scrBounds.height = ky * ( width + length + 2 * height);

            return scrBounds;
        }


    }
}
