package net.wg.gui.lobby.techtree.data.vo
{
    import net.wg.gui.lobby.techtree.interfaces.IValueObject;
    import net.wg.utils.ILocale;
    
    public class ResearchDisplayInfo extends Object implements IValueObject
    {
        
        public function ResearchDisplayInfo(param1:Array = null, param2:String = "", param3:int = -1) {
            super();
            this._path = param1;
            this._renderer = param2;
            this._level = param3;
        }
        
        public static var ITEM_RENDERER:String = "item";
        
        public static var VEHICLE_RENDERER:String = "vehicle";
        
        private var _path:Array;
        
        private var _renderer:String;
        
        private var _level:int;
        
        public function get path() : Array {
            return this._path;
        }
        
        public function get renderer() : String {
            return this._renderer;
        }
        
        public function get level() : int {
            return this._level;
        }
        
        public function fromArray(param1:Array, param2:ILocale) : void {
            if(param1.length > 2)
            {
                this._path = param1[0];
                this._renderer = param1[1];
                this._level = param1[2];
            }
        }
        
        public function fromObject(param1:Object, param2:ILocale) : void {
            if(param1 == null)
            {
                return;
            }
            if(param1.path)
            {
                this._path = param1.path;
            }
            if(param1.renderer)
            {
                this._renderer = param1.renderer;
            }
            if(param1.level)
            {
                this._level = param1.level;
            }
        }
        
        public function clearUp() : void {
            this._renderer = "";
            this._level = -1;
            if(this._path != null)
            {
                this._path.splice(0,this._path.length);
            }
        }
        
        public function isDrawItem() : Boolean {
            return this._renderer == ITEM_RENDERER;
        }
        
        public function isDrawVehicle() : Boolean {
            return this._renderer == VEHICLE_RENDERER;
        }
        
        public function getDepthOfPath() : Number {
            return this._path != null?this._path.length:0;
        }
        
        public function toString() : String {
            return "[ResearchDisplayInfo: path = " + this._path + ", renderer = " + this._renderer + ", level = " + this._level + "]";
        }
    }
}
