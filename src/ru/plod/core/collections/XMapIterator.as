package ru.plod.core.collections {


	public class XMapIterator implements IIterator {

		private var _treap : XMap;
		private var _current : XMapNode;
		private var _next : XMapNode;
		private var _previous : XMapNode;
		private var _beforeFirst : Boolean = false;
		private var _afterLast : Boolean = false;


		public function XMapIterator(treap : XMap, node : XMapNode) {
			if (!node) return;

			_treap = treap;

			if (node == _treap.getMostLeftNode()) {
				_current = node;
				_beforeFirst = true;
				_next = _current;
			} else {
				_current = _treap.findPrevious(node);
				_next = node;
			}
		}


		public function hasNext() : Boolean {
			if (_next) return true; // called twice
			if (_current) {
				if (_beforeFirst) {
					_next = _current;
				} else {
					_next = _treap.findNext(_current);
				}
			}
			return _next ? true : false;
		}


		public function getNext() : * {
			if (!_next && !hasNext()) {
				_afterLast = true;
				return undefined;
			}

			_current = _next;
			var item : * = _current.item;
			_previous = _next = null;
			_beforeFirst = false;

			return item;
		}


		public function hasPrevious() : Boolean {
			if (_previous) return true;
			if (_current) {
				if (_afterLast) {
					_previous = _current;
				} else {
					_previous = _treap.findPrevious(_current);
				}
			}
			return _previous ? true : false;
		}


		public function getPrevious() : * {
			if (!_previous && !hasPrevious()) {
				_beforeFirst = true;
				return undefined;
			}

			_current = _previous;
			var item : * = _current.item;
			_previous = _next = null;
			_afterLast = false;

			return item;
		}


		public function getCurrent() : * {
			if (_beforeFirst || _afterLast) return undefined;
			if (!_current) return undefined;
			return _current.item;
		}

	}
}
