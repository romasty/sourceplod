package ru.plod.core.collections {

	public interface IIterator {

		function hasNext() : Boolean;
		function getNext() : *;
		function hasPrevious() : Boolean;
		function getPrevious() : *;
		function getCurrent() : *;

	}
}
