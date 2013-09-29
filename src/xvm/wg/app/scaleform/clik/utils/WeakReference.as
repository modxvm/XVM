package scaleform.clik.utils 
{
    import flash.utils.*;
    
    public class WeakReference extends Object
    {
        public function WeakReference(arg1:Object)
        {
            super();
            this._dictionary = new flash.utils.Dictionary(true);
            this._dictionary[arg1] = 1;
            return;
        }

        public function get value():Object
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._dictionary;
            for (loc1 in loc3) 
            {
                return loc1;
            }
            return null;
        }

        protected var _dictionary:flash.utils.Dictionary;
    }
}
