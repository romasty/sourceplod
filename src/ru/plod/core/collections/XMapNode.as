package ru.plod.core.collections {


	public class XMapNode {


		public var item : *;
  		public var parent : XMapNode;
		public var left : XMapNode;
		public var right : XMapNode;
		public var priority : uint;


		public function XMapNode(theItem : *, theParent : XMapNode, theLeft : XMapNode, theRight : XMapNode) {
			item = theItem;
			parent = theParent;
			left = theLeft;
			right = theRight;
			priority = Math.random() * uint.MAX_VALUE;
		}

	}
}
