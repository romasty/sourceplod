/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 16.08.11
 * Time: 15:10
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.core.flow {
	public class ProcessSourceBase implements IProcessSource {

		protected const _processList:Vector.<IRuntimeProcess> = new Vector.<IRuntimeProcess>();
		protected const _activeProcessList:Vector.<IRuntimeProcess> = new Vector.<IRuntimeProcess>();
		protected const _processToActivate:Vector.<IRuntimeProcess> = new Vector.<IRuntimeProcess>();
		protected const _processToDeactivate:Vector.<IRuntimeProcess> = new Vector.<IRuntimeProcess>();

		public function ProcessSourceBase()
		{

		}

		public function get activeSource():Vector.<IRuntimeProcess>
		{
			return _activeProcessList;
		}

		public function addProcess(process:IRuntimeProcess, awake:Boolean = true):void
		{
			if (_processList.indexOf(process) == -1) {
				_processList.push(process);
				process.eventAwake.subscribe(onProcessAwake);
				process.eventSleep.subscribe(onProcessSleep);
				if(awake) process.activate();
			}
		}

		public function removeProcess(process:IRuntimeProcess):void
		{
			var index:int = _processList.indexOf(process);
			if (index != -1) {
				_processList.splice(index, 1);
				process.sleep();
				process.eventAwake.unsubscribe(onProcessAwake);
				process.eventSleep.unsubscribe(onProcessSleep);
			}
		}

		public function refresh():void
		{
			removeDeleted();
			pushAdded();
		}

		public function cleanUp():void
		{
			for each (var process:IRuntimeProcess in _processList) {
				process.eventAwake.unsubscribe(onProcessAwake);
				process.eventSleep.unsubscribe(onProcessSleep);
			}

			_processList.length = 0;
			_activeProcessList.length = 0;
			_processToActivate.length = 0;
			_processToDeactivate.length = 0;
		}

		protected function pushAdded():void
		{
			for each(var process:IRuntimeProcess in _processToActivate) {
				if (_activeProcessList.indexOf(process) == -1) {
					_activeProcessList.push(process);
				}
			}
			_processToActivate.length = 0;
		}

		protected function removeDeleted():void
		{
			for each(var process:IRuntimeProcess in _processToDeactivate) {
				var index:int = _activeProcessList.indexOf(process);
				if (index != -1) _activeProcessList.splice(index, 1);
			}

			_processToDeactivate.length = 0;
		}

		protected function onProcessAwake(process:IRuntimeProcess):void
		{
			var index:int = _processToActivate.indexOf(process);
			if (index == -1) _processToActivate.push(process);

			index = _processToDeactivate.indexOf(process);
			if (index != -1) _processToDeactivate.splice(index, 1);
		}

		protected function onProcessSleep(process:IRuntimeProcess):void
		{
			var index:int = _processToDeactivate.indexOf(process);
			if (index == -1) _processToDeactivate.push(process);

			index = _processToActivate.indexOf(process);
			if (index != -1) _processToActivate.splice(index, 1);
		}


		//for test
		private function traceSt(phase:String) : void
		{
			trace(phase,"all:", _processList, "  active:",_activeProcessList, "  toAdd:", _processToActivate, "  toRemov",_processToDeactivate)
		}
	}
}
