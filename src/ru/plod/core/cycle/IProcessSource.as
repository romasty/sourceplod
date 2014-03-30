/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 16.08.11
 * Time: 14:49
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.cycle {

    public interface IProcessSource {

        function get source():Array;

        function add(item:Object):void

        function remove(item:Object):void

        function refresh():void;

        function cleanUp():void;

    }
}
