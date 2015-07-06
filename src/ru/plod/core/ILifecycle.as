/**
 * Created by Roman on 01.07.2015.
 */
package ru.plod.core
{
	public interface ILifecycle
	{
			function activate() : void;
			function sleep():void;
			function finalize() : void;
	}
}
