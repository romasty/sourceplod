package ru.plod.core.collections {




	public class XMap {


		protected var _comparator : IComparator;
		protected var _root : XMapNode;
		protected var _numItems : uint = 0;

        public function XMap(comparator : IComparator) {
			_comparator = comparator;
		}


		public function addItem(item : *) : Boolean {
			return addItemToTree(item);
		}



		public function hasItem(item : *) : Boolean {
			try {
				var node : XMapNode = findNode(item);
			} catch (e : Error) {
				// item not comparable
				return false;
			}
			//return node && node.item === item ? true : false;
			return node != null;
		}



		public function removeItem(item : *) : Boolean {
			try {
				var node : XMapNode = findNode(item);
			} catch (e : Error) {
				// item not comparable
				return false;
			}
			if (!node || node.item !== item) return false;
			removeNodeFromTree(node);
			return true;
		}



		public function clear() : void {
			_root = null;
			_numItems = 0;
		}



		public function toArray() : Array {
			var array : Array = new Array();
			var iterator : IIterator = getIterator();
			while (iterator.hasNext()) {
				array.push(iterator.getNext());
			}
			return array;
		}



		public function get numItems() : uint {
			return _numItems;
		}



		public function getIterator(item : * = null) : IIterator
        {
            var node : XMapNode;
            if(item) {
                node = findNode(item);
            } else {
                node = getMostLeftNode();
            }

			/*var node : XMapNode = getMostLeftNode();
			if (cursor) {
				var i : uint = 0;
				while (node && i < cursor) {
					node = findNext(node);
					i++;
				}
			}*/
			return new XMapIterator(this, node);
		}



		public function hasEqualItem(item : *) : Boolean {
			try {
				var node : XMapNode = findNode(item);
			} catch (e : Error) {
				// item not comparable
				return false;
			}
			return node ? true : false;
		}



		public function getEqualItem(item : *) : * {
			try {
				var node : XMapNode = findNode(item);
			} catch (e : Error) {
				// item not comparable
				return undefined;
			}
			return node ? node.item : undefined;
		}



		public function getFirstItem() : * {
			if (!_root) return undefined;
			return getMostLeftNode().item;
		}



		public function getLastItem() : * {
			if (!_root) return undefined;
			return getMostRightNode().item;
		}



		public function removeFirstItem() : * {
			var node : XMapNode = getMostLeftNode();
			if (!node) return undefined;
			removeNodeFromTree(node);
			return node.item;
		}



		public function removeLastItem() : * {
			var node : XMapNode = getMostRightNode();
			if (!node) return undefined;
			removeNodeFromTree(node);
			return node.item;
		}



		public function toString() : String {
			return "[Treap] items:" + _numItems;
		}



        internal function getMostLeftNode(node : XMapNode = null) : XMapNode {
        	if (!_root) return null;
        	if (!node) node = _root;
        	while (node.left) {
        		node = node.left;
        	}
        	return node;
		}


        internal function getMostRightNode(node : XMapNode = null) : XMapNode {
        	if (!_root) return null;
        	if (!node) node = _root;
        	while (node.right) {
        		node = node.right;
        	}
        	return node;
		}





		internal function findNext(node : XMapNode) : XMapNode {
			if (node.right) {
				 node = getMostLeftNode(node.right);
			} else {
				var parent : XMapNode = node.parent;
				while (parent && node == parent.right) {
					node = parent;
					parent = parent.parent;
				}
				node = parent;
			}
			return node;
		}


		internal function findPrevious(node : XMapNode) : XMapNode {
			if (node.left) {
				 node = getMostRightNode(node.left);
			} else {
				var parent : XMapNode = node.parent;
				while (parent && node == parent.left) {
					node = parent;
					parent = parent.parent;
				}
				node = parent;
			}
			return node;
		}


		/*internal function findNode(item : *) : XMapNode {
			var node : XMapNode = _root;

			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) {
					node = node.left;
				} else if (compare == 1) {
					node = node.right;
				} else {
					return node;
				}
			}

			return null;
		}*/

        
        

        internal function findNode(item : *) : XMapNode
        {
            var node : XMapNode = _root;

            while (node) {
                var compare : int = _comparator.compare(item, node.item);

                if ( compare < 0 ) {
                    if ( node.left != null )
                        node = node.left;
                    else
                        return node;
                } else if ( compare > 0 ) {
                    if ( node.right != null ) {
                        node = node.right;
                    } else {
                        var parent : XMapNode = node.parent;
                        var ch : XMapNode  = node;
                        while ( parent != null && ch == parent.right ) {
                            ch = parent;
                            parent = parent.parent;
                        }
                        return parent;
                    }
                } else {
                    return node;
                }
            }

            return null;
        }



		protected function addItemToTree(item : *) : Boolean {

			// add first node

			if (!_root) {
				_comparator.compare(item, item); // type check, should throw an error if not passed
				_root = new XMapNode(item, null, null, null);
				_numItems++;
				nodeAdded(_root);
				return true;
			}

			// add node to tree

			var node : XMapNode = _root;
			while (node) {
				var compare : int = _comparator.compare(item, node.item);
				if (compare == -1) { // add item in left branch
					if (node.left) {
						node = node.left;
						continue;
					} else {
						node.left = new XMapNode(item, node, null, null);
						node = node.left;
						break;
					}
				} else if (compare == 1) { // add item in right branch
					if (node.right) {
						node = node.right;
						continue;
					} else {
						node.right = new XMapNode(item, node, null, null);
						node = node.right;
						break;
					}
				} else { // add an item for an existing equality not permitted
					return false;
				}
			}


			while (node.parent) {
				if (node.parent.priority >= node.priority) break;
				rotate(node.parent, node);
			}

			_numItems++;

			nodeAdded(node); // notify subclasses

			return true;
		}


		protected function removeNodeFromTree(node : XMapNode) : void {

			willRemoveNode(node); // notify subclasses

			// bubble down

			var child : XMapNode;
			while (node.left || node.right) {
				if (node.left && node.right) child = node.left.priority < node.right.priority ? node.left : node.right;
				else if (node.left) child = node.left;
				else if (node.right) child = node.right;
				else break;
				rotate(node, child);
			}

			// remove node from tree

			if (node.parent) {
				if (node.parent.left == node) {
					node.parent.left = null;
				} else {
					node.parent.right = null;
				}
				node.parent = null;
			} else {
				_root = null;
			}

			_numItems--;

			nodeRemoved();
		}


		protected function rotate(parent : XMapNode, child : XMapNode) : void {
			var grandparent : XMapNode = parent.parent;

			var right : String = "right"; // rotate with right child
			var left : String = "left";
			if (child == parent.left) { // rotate with left child
				right = "left";
				left = "right";
			}

			// set left of child to be the new right of parent
			parent[right] = child[left];
			if (child[left]) XMapNode(child[left]).parent = parent;

			// set child as the new parent
			parent.parent = child;
			child[left] = parent;

			// link grandparent to the child
			child.parent = grandparent;
			if (grandparent) {
				if (grandparent[left] == parent) {
					grandparent[left] = child;
				} else {
					grandparent[right] = child;
				}
			} else {
				_root = child;
			}
		}


		protected function nodeAdded(node : XMapNode) : void {
			// hook
		}

		protected function willRemoveNode(node : XMapNode) : void {
			// hook
		}

		protected function nodeRemoved() : void {
			// hook
		}

	}
}
