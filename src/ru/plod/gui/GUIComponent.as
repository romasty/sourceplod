/**
 * Created with IntelliJ IDEA.
 * User: vic
 * Date: 5/23/14
 * Time: 1:33 AM
 * To change this template use File | Settings | File Templates.
 */
package ru.plod.gui {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	import ru.plod.core.ILifecycle;
	import ru.plod.core.base.RuntimeContainer;

	public class GUIComponent extends Sprite implements ILifecycle {

		private var _lifecycleDelegate:RuntimeContainer = new RuntimeContainer();

		private var _width:int;
		private var _height:int;

		private var _sizeInvalid:Boolean;

		public function GUIComponent()
		{
			//addEventListener(Event.ADDED_TO_STAGE, onEventAdded);
			addEventListener(Event.ADDED, onEventAdded);
			addEventListener(Event.REMOVED_FROM_STAGE, onEventRemoved);
			addEventListener(Event.REMOVED, onEventRemoved);
			createChildren();
			arrange();
		}

		protected function createChildren():void
		{
		}

		protected function arrange():void
		{
		}

		override public function get width():Number
		{
			return _width;
		}


		override public function set width(value:Number):void
		{
			if (_width == value) return;
			_width = value;
			_sizeInvalid = true;
		}

		override public function get height():Number
		{
			return _height;
		}


		override public function set height(value:Number):void
		{
			if (_height == value) return;
			_height = value;
			_sizeInvalid = true;
		}


		public function activate():void
		{
			_lifecycleDelegate.activate();
		}

		public function sleep():void
		{
			_lifecycleDelegate.sleep();
		}

		public function finalize():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onEventAdded);
			removeEventListener(Event.REMOVED_FROM_STAGE, onEventRemoved);
			_lifecycleDelegate.finalize();
			removeChildren();
		}


		private function onEventAdded(event:Event):void
		{
			var displayObject:DisplayObject = event.target as DisplayObject;
			if(displayObject == this) return;
			trace(event.type, event.eventPhase, this, event.target, event.currentTarget, displayObject)
			if (displayObject != this && displayObject is GUIComponent) {
				var parent:DisplayObjectContainer = displayObject.parent;
				while (parent != this) {
					if (parent is GUIComponent) return;
					parent = parent.parent;
				}
				_lifecycleDelegate.addComponent(displayObject as GUIComponent);
				trace(this, "addComponent", displayObject);

			}
		}

		private function onEventRemoved(event:Event):void
		{
			var displayObject:DisplayObject = event.target as DisplayObject;
			//if(displayObject == this) return;
			trace(event.type, event.eventPhase, this, event.target, event.currentTarget, displayObject)
			if (displayObject != this && displayObject is GUIComponent) {
				var parent:DisplayObjectContainer = displayObject.parent;
				while (parent != this) {
					if (parent is GUIComponent) return;
				}
				_lifecycleDelegate.removeComponent(displayObject as GUIComponent);
				trace(this, "removeComponent", displayObject);
			}
		}
	}
}
