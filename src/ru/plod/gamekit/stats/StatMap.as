/**
 * Created with IntelliJ IDEA.
 * User: user1
 * Date: 10.05.13
 * Time: 12:53
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.stats {

	import flash.utils.Dictionary;

	import ru.plod.broadcaster.Broadcaster;

	public class StatMap {

		public const eventChange : Broadcaster = new Broadcaster();
		public const eventStatChange : Broadcaster = new Broadcaster();

		protected const _statMap:Dictionary = new Dictionary();
		protected const _statList:Vector.<StatValue> = new Vector.<StatValue>();
		protected var _modified:Boolean = true;

		public function StatMap()
		{
			eventChange.target = this;
			eventStatChange.target = this;
		}

		public function getValue(name:*):int
		{
			var stat:StatValue = getStat(name);
			return stat ? stat.value : 0
		}

		public function setValue(name:*, val:int):void
		{
			var statValue:StatValue = getStatInternal(name);
			statValue.value = val;
		}

		public function getStat(name:*):StatValue
		{
			return _statMap[name];
		}

		public function getStatList():Vector.<StatValue>
		{
			if (_modified) {
				_modified = false;
				_statList.length = 0;
				for each (var statValue:StatValue in _statMap) {
					if (statValue.value != 0) _statList.push(statValue);
				}
			}
			return _statList;
		}

		public function setStatList(list:Vector.<StatValue>):void
		{
			for each (var stat:StatValue in list) {
				if (stat) setValue(stat.name, stat.value);
			}
		}

		public function concatValue(stat:StatValue, op:StatOperator):void
		{
			var name : * = stat.name;
			setValue(name, op.result(getValue(name), stat.value));
		}

		public function concatList(list:Vector.<StatValue>, op:StatOperator):void
		{
			for each (var stat:StatValue in list) {
				concatValue(stat, op)
			}
		}

		public function concatMap(map:StatMap, op:StatOperator):void
		{
			concatList(map.getStatList(), op);
		}

		public function modify(modifier:Number, op:StatOperator = null):void
		{
			var list:Vector.<StatValue> = getStatList();
			for each (var stat:StatValue in list) {
				stat.value = op.result(stat.value, modifier);
			}
		}

		public function copy(source:StatMap):void
		{
			var list:Vector.<StatValue> = source.getStatList();
			for each (var stat:StatValue in list) {
				setValue(stat.name, stat.value);
			}
		}

		public function equals(map:StatMap):Boolean
		{
			var stat1:StatValue;
			var stat2:StatValue;
			var list:Vector.<StatValue> = map.getStatList();
			for each (stat1 in list) {
				stat2 = this.getStat(stat1.name);
				if (!stat1.equals(stat2)) return false;
			}
			list = this.getStatList();
			for each (stat1 in list) {
				stat2 = map.getStat(stat1.name);
				if (!stat1.equals(stat2)) return false;
			}
			return true;
		}

		public function diff(map:StatMap):StatMap
		{
			var diffMap:StatMap = new StatMap();
			var compared:Dictionary = new Dictionary();

			var stat1:StatValue;
			var stat2:StatValue;
			var values:Vector.<StatValue> = map.getStatList();
			for each (stat1 in values) {
				stat2 = this.getStat(stat1.name);
				compared[stat1.name] = true;
				if (!stat1.equals(stat2)) {
					diffMap.setValue(stat1.name, StatOperator.DELTA.result(stat2 ? stat2.value : 0, stat1.value));
				}
			}
			values = this.getStatList();
			for each (stat1 in values) {
				if (compared[stat1.name]) continue;
				stat2 = map.getStat(stat1.name);
				if (!stat1.equals(stat2)) {
					diffMap.setValue(stat1.name, StatOperator.DELTA.result(stat1.value, stat2 ? stat2.value : 0));
				}
			}

			return diffMap;
		}

		public function clone():StatMap
		{
			var map:StatMap = new StatMap();
			map.copy(this);
			return map;
		}

		public function clear() : void
		{
			for each (var stat:StatValue in getStatList()) {
			 	stat.eventChange.unsubscribe(onStatChange);
				delete _statMap[stat.name];
			}
			_statList.length = 0;
		}

		protected function getStatInternal(name:*):StatValue
		{
			var stat:StatValue = _statMap[name];
			if (stat == null) {
				stat = new StatValue(name);
				_statMap[name] = stat;
				stat.eventChange.subscribe(onStatChange);
				eventChange.broadcast();
				_modified = true;
			}
			return stat;
		}

		protected function onStatChange(target : StatValue) : void
		{
			eventStatChange.broadcast(target);
		}
	}
}
