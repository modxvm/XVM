package net.wg.gui.login.impl 
{
    import flash.display.*;
    import flash.geom.*;
    import net.wg.gui.login.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public final class SparksManager extends Object implements net.wg.gui.login.ISparksManager
    {
        public function SparksManager()
        {
            super();
            return;
        }

        public function set scope(arg1:flash.display.MovieClip):void
        {
            this._scope = arg1;
            return;
        }

        public function get scope():flash.display.MovieClip
        {
            return this._scope;
        }

        public function set sparkQuantity(arg1:Number):void
        {
            this._sparkQuantity = arg1;
            return;
        }

        public function get sparkQuantity():Number
        {
            return this._sparkQuantity;
        }

        public function set zone(arg1:flash.geom.Rectangle):void
        {
            this._zone = arg1;
            return;
        }

        public function get zone():flash.geom.Rectangle
        {
            return this._zone;
        }

        public function resetZone(arg1:flash.geom.Rectangle):void
        {
            var loc2:*=null;
            this._zone = arg1;
            var loc1:*=0;
            while (loc1 < this._scope.numChildren) 
            {
                loc2 = this._scope.getChildAt(loc1) as net.wg.gui.login.impl.Spark;
                loc2.zone = this._zone;
                ++loc1;
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            while (this._scope.numChildren) 
            {
                loc1 = net.wg.infrastructure.interfaces.entity.IDisposable(this._scope.getChildAt(0));
                loc1.dispose();
                this._scope.removeChildAt(0);
            }
            this._scope = null;
            return;
        }

        public function createSparks():void
        {
            var loc2:*=null;
            var loc1:*=0;
            while (loc1 < this._sparkQuantity) 
            {
                loc2 = new net.wg.gui.login.impl.Spark(this._zone, "spark_" + loc1);
                this._scope.addChild(loc2);
                loc2.startAnimation();
                ++loc1;
            }
            return;
        }

        internal var _sparkQuantity:Number=0;

        internal var _scope:flash.display.MovieClip=null;

        internal var _zone:flash.geom.Rectangle=null;
    }
}
