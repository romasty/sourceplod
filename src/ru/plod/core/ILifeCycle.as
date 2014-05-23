/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 5/22/14
 * Time: 9:14 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core {
	public interface ILifecycle {

		function activate() : void;
		function sleep():void;
		function finalize() : void;
	}
}
