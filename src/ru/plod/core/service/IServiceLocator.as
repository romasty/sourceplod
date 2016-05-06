package ru.plod.core.service
{
	public interface IServiceLocator
	{
		function registerService(serviceClass:Class, service:Object):void

		function getService(serviceClass:Class):Object

	}
}
