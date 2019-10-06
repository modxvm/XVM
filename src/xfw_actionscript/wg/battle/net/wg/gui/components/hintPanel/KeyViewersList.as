package net.wg.gui.components.hintPanel
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.controls.Image;
    import flash.display.BlendMode;
    import flash.utils.getDefinitionByName;
    import net.wg.data.constants.Linkages;

    public class KeyViewersList extends Sprite implements IDisposable
    {

        private static const KEY_GAP:int = 35;

        private static const PLUS_SIZE:int = 8;

        private static const PLUS_LEFT:int = KEY_GAP + PLUS_SIZE >> 1;

        private var _keys:Vector.<KeyViewer>;

        private var _pluses:Vector.<Image>;

        private var _keyClass:Class;

        public function KeyViewersList()
        {
            this._keys = new Vector.<KeyViewer>(0);
            this._pluses = new Vector.<Image>(0);
            super();
            this._keyClass = getDefinitionByName(Linkages.KEY_VIEWER) as Class;
        }

        public function clearKeys() : void
        {
            var _loc1_:KeyViewer = null;
            var _loc2_:Image = null;
            for each(_loc1_ in this._keys)
            {
                removeChild(_loc1_);
                _loc1_.dispose();
                _loc1_ = null;
            }
            this._keys.splice(0,this._keys.length);
            for each(_loc2_ in this._pluses)
            {
                removeChild(_loc2_);
                _loc2_.dispose();
                _loc2_ = null;
            }
            this._pluses.splice(0,this._pluses.length);
        }

        public final function dispose() : void
        {
            this.clearKeys();
            this._keys = null;
            this._pluses = null;
            this._keyClass = null;
        }

        public function setKeys(param1:Array) : void
        {
            var _loc2_:* = NaN;
            var _loc3_:* = false;
            var _loc4_:String = null;
            var _loc5_:KeyViewer = null;
            var _loc6_:Image = null;
            this.clearKeys();
            if(param1.length > 0)
            {
                _loc2_ = 0;
                _loc3_ = true;
                for each(_loc4_ in param1)
                {
                    _loc5_ = new this._keyClass();
                    _loc5_.setKey(_loc4_);
                    _loc5_.x = _loc2_ >> 0;
                    _loc2_ = _loc2_ + (_loc5_.width + KEY_GAP);
                    if(!_loc3_)
                    {
                        _loc6_ = new Image();
                        _loc6_.source = RES_ICONS.MAPS_ICONS_LIBRARY_HINT_PLUS;
                        _loc6_.x = _loc5_.x - PLUS_LEFT;
                        _loc6_.y = _loc5_.height - PLUS_SIZE >> 1;
                        this._pluses.push(_loc6_);
                        addChild(_loc6_);
                    }
                    _loc3_ = false;
                    this._keys.push(_loc5_);
                    addChild(_loc5_);
                }
                cacheAsBitmap = true;
                blendMode = BlendMode.SCREEN;
            }
        }
    }
}
