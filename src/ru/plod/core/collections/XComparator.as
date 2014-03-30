package ru.plod.core.collections {
    public class XComparator implements IComparator {

        public function XComparator()
        {
        }

        public function compare(item1 : *, item2 : * ) : int
        {
            var dx : int = item1.x - item2.x;
            if(dx > 0) {
                return 1;
            } else if(dx < 0) {
                return -1;
            }
            return 0;
        }
    }
}