package ru.plod.core.service
{
	public function getService(serviceClass:Class):Object
	{
		return ServiceLocator.instance.getService(serviceClass);
	}
}
