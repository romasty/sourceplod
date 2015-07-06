/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 3/16/14
 * Time: 11:22 PM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.stats {

	public class StatModifier {

		public var stat : StatValue = null;
		public var operator : StatOperator = null;

		public function StatModifier(stat:StatValue, operator:StatOperator)
		{
			this.stat = stat;
			this.operator = operator;
		}
	}
}
