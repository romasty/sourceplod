package ru.plod.core.service
{
	public function getService(serviceClass:Class):*
	{
		return ServiceLocator.instance.getService(serviceClass);
	}
}
