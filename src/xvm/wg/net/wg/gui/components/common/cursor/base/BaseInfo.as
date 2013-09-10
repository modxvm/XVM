package net.wg.gui.components.common.cursor.base 
{
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import net.wg.utils.*;
    
    public class BaseInfo extends Object implements net.wg.infrastructure.interfaces.entity.IDisposable
    {
        public function BaseInfo(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea, arg2:String, arg3:String)
        {
            super();
            var loc1:*="drag or drop object must be InteractiveObject";
            var loc2:*;
            (loc2 = App.utils.asserter).assertNotNull(arg1, "dragDropObject" + net.wg.data.constants.Errors.CANT_NULL);
            loc2.assert(arg1 is flash.display.InteractiveObject, loc1);
            this._container = arg1;
            this._cursor = arg2 ? arg2 : arg3;
            return;
        }

        public function get hit():flash.display.InteractiveObject
        {
            return net.wg.gui.components.common.cursor.base.BaseInfo.getHitFromContainer(this._container);
        }

        public function get cursor():String
        {
            return this._cursor;
        }

        protected final function getContainer():net.wg.infrastructure.interfaces.entity.IDragDropHitArea
        {
            return this._container;
        }

        public function dispose():void
        {
            this._cursor = null;
            this._container = null;
            return;
        }

        protected final function getCursor():String
        {
            return this._cursor;
        }

        public function get processStarted():Boolean
        {
            return this._processStarted;
        }

        public function set processStarted(arg1:Boolean):void
        {
            this._processStarted = arg1;
            return;
        }

        public static function getHitFromContainer(arg1:net.wg.infrastructure.interfaces.entity.IDragDropHitArea):flash.display.InteractiveObject
        {
            var loc1:*=arg1.getHitArea();
            return loc1 ? loc1 : flash.display.InteractiveObject(arg1);
        }

        internal var _cursor:String=null;

        internal var _container:net.wg.infrastructure.interfaces.entity.IDragDropHitArea=null;

        internal var _processStarted:Boolean=false;
    }
}
