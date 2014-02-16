/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 2/15/14
 * Time: 1:23 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui.layout.measure {
	public class LayoutMeasureType {

		public static const FIXED : String = "fixed";
		public static const UNION : String = "union";
		public static const INDIVIDUAL : String = "individual";

		public static function getMeasure(type:String, ...args):ILayoutMeasure
		{
			if(type == FIXED) {
				return new LayoutMeasureFixed(args[0], args[1]);
			} else if(type == UNION) {
				return new LayoutMeasureUnion(args[0]);
			} else if(type == INDIVIDUAL) {
				return new LayoutMeasureIndividual(args[0]);
			}
		 	return null;
		}
	}
}
