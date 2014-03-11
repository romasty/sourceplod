/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 30.01.12
 * Time: 14:22
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.display {

    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.events.IEventDispatcher;

    public interface IDisplay extends IEventDispatcher {

        function get stage() : Stage;
        function get root() : DisplayObjectContainer;
    }
}
