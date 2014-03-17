/**
 * Created with IntelliJ IDEA.
 * User: user1
 * Date: 16.05.13
 * Time: 14:24
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.stats {

	public class StatAggregator {


		private var _base : StatMap;
		private var _delta : StatMap;
		private var _result : StatMap = new StatMap();

		protected var _modified : Boolean;

		public function StatAggregator(baseStats : StatMap, delta : StatMap = null)
		{
			_base = baseStats;

			if (delta) {
				_delta = delta;
				_modified = true;
			} else {
				_delta = new StatMap();
				_result.copy(_base);
			}
		}


		public function get base() : StatMap
		{
			return _base;
		}

		public function get result() : StatMap
		{
			if (_modified) updateResult();
			return _result;
		}

		public function get delta() : StatMap
		{
			return _delta;
		}


		public function add(mod : StatMap, op : StatOperator) : void
		{
			var modStats : StatMap = mod.clone();
			if (op == StatOperator.MULTIPLY) {

				modStats.modify(.01, StatOperator.MULTIPLY);
				modStats.concatMap(_base, StatOperator.MULTIPLY);
				_delta.concatMap(modStats, StatOperator.ADD);

			} else if (op == StatOperator.OVERRIDE) {
				//TODO: OVERRIDE

			} else {
				_delta.concatMap(modStats, op);
			}


			_modified = true;

		}

		protected function updateResult() : void
		{
			_modified = false;
			_result = _base.clone();

			//TODO:
			//_resultStats.copy(_baseStats);
			_result.concatMap(_delta, StatOperator.ADD);
		}


	}
}
