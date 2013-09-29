package net.wg.gui.components.common.markers.data 
{
    import net.wg.data.daapi.base.*;
    
    public class VehicleMarkerVO extends net.wg.data.daapi.base.DAAPIDataClass
    {
        public function VehicleMarkerVO(arg1:Object)
        {
            super(arg1);
            return;
        }

        public function set curHealth(arg1:Number):void
        {
            this._curHealth = arg1;
            return;
        }

        public function get maxHealth():Number
        {
            return this._maxHealth;
        }

        public function set maxHealth(arg1:Number):void
        {
            this._maxHealth = arg1;
            return;
        }

        public function get entityName():String
        {
            return this._entityName;
        }

        public function set entityName(arg1:String):void
        {
            this._entityName = arg1;
            return;
        }

        public function get speaking():Boolean
        {
            return this._speaking;
        }

        public function set speaking(arg1:Boolean):void
        {
            this._speaking = arg1;
            return;
        }

        public function get hunt():Boolean
        {
            return this._hunt;
        }

        public function set hunt(arg1:Boolean):void
        {
            this._hunt = arg1;
            return;
        }

        public function get entityType():String
        {
            return this._entityType;
        }

        public function set entityType(arg1:String):void
        {
            this._entityType = arg1;
            return;
        }

        public function get vClass():String
        {
            return this._vClass;
        }

        public function set vClass(arg1:String):void
        {
            this._vClass = arg1;
            return;
        }

        public function get vIconSource():String
        {
            return this._vIconSource;
        }

        public function set vIconSource(arg1:String):void
        {
            this._vIconSource = arg1;
            return;
        }

        public function get vType():String
        {
            return this._vType;
        }

        public function set vType(arg1:String):void
        {
            this._vType = arg1;
            return;
        }

        public function get vLevel():Number
        {
            return this._vLevel;
        }

        public function set vLevel(arg1:Number):void
        {
            this._vLevel = arg1;
            return;
        }

        public function get pFullName():String
        {
            return this._pFullName;
        }

        public function set pFullName(arg1:String):void
        {
            this._pFullName = arg1;
            return;
        }

        public function get curHealth():Number
        {
            return this._curHealth;
        }

        internal var _vClass:String="";

        internal var _vIconSource:String="";

        internal var _vType:String="";

        internal var _vLevel:Number;

        internal var _pFullName:String="";

        internal var _curHealth:Number;

        internal var _maxHealth:Number;

        internal var _entityName:String="";

        internal var _speaking:Boolean;

        internal var _hunt:Boolean;

        internal var _entityType:String="";
    }
}
