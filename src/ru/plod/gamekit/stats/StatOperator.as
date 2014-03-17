/**
 * Created by IntelliJ IDEA.
 * User: user1
 * Date: 04.06.12
 * Time: 15:23
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gamekit.stats {


	public class StatOperator {

		public static const NONE:StatOperator = new StatOperator("NONE", function(val1 : Number, val2 : Number) : Number {return -1});

		public static const ADD:StatOperator = new StatOperator("ADD",  function(val1 : Number, val2 : Number) : Number {return val1 + val2});
		public static const DELTA:StatOperator = new StatOperator("DELTA", function(val1 : Number, val2 : Number) : Number {return val1 - val2});
		public static const MULTIPLY:StatOperator = new StatOperator("MULTIPLY",  function(val1 : Number, val2 : Number) : Number {return val1 * val2});

		public static const OVERRIDE:StatOperator = new StatOperator("OVERRIDE",  function(val1 : Number, val2 : Number) : Number {return val2});
		public static const OVERRIDE_LESS:StatOperator = new StatOperator("OVERRIDE_LESS", function(val1 : Number, val2 : Number) : Number {return Math.min(val1 , val2)});
		public static const OVERRIDE_LARGER:StatOperator = new StatOperator("OVERRIDE_LARGER",  function(val1 : Number, val2 : Number) : Number {return Math.max(val1 , val2)});

		public var name:String;
		private var _resultFunc : Function;

		public function StatOperator(name:String, resultFunc : Function)
		{
			this.name = name;
			_resultFunc = resultFunc;
		}

		public function toString():String
		{
			return name;
		}

		public function result(val1 : Number,  val2 : Number) : Number
		{
			return _resultFunc(val1, val2);
		}
	}
}
