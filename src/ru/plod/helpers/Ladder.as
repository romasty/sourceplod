/**
 * Created by IntelliJ IDEA.
 * User: Roman
 * Date: 11/22/14
 * Time: 6:11 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.helpers
{
    public class Ladder
    {
        public const values : Vector.<int> = new Vector.<int>();

        public function Ladder(...values)
        {
            if(values.length) {
                addValues.apply(null, values);
            }
        }

        public function add(value : int) : void
        {
            for (var i : int = 0; i < values.length; i++) {
                var v : int = values[i];
                if (value < v) {
                    break;
                } else if (value == v) {
                    return;
                }
            }
            values.splice(i, 0, value);
        }

        public function addValues(...values) : void
        {
            var vals : *;
            if (values.length == 1 && values[0] is Array || Vector.<int>(values[0])) {
                vals = values[0];
            } else {
                vals = values;
            }

            for each(var v : int in vals) {
                add(v);
            }
        }

        public function outOfBounds(value : Number):Boolean
        {
            return false //TODO
        }

        public function getLEValue(value : Number) : int
        {
            return 0 //TODO
        }

        public function getLEIndex(value : Number) : int
        {
            return 0 //TODO
        }

        public function getGEValue(value : Number) : int
        {
            return 0 //TODO
        }

        public function getGEIndex(value : Number) : int
        {
            return 0 //TODO
        }

        public function getDiapason(value : Number) : Diapason
        {
            return null //TODO
        }

    }
}
