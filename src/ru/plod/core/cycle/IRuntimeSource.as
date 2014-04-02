/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 16.08.11
 * Time: 14:49
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.cycle {

    public interface IRuntimeSource {

        function get activeSource():Vector.<IRuntimeProcess>;

        function addProcess(process:IRuntimeProcess, awake : Boolean = true):void

        function removeProcess(process:IRuntimeProcess):void

        function refresh():void;

        function cleanUp():void;

    }
}
