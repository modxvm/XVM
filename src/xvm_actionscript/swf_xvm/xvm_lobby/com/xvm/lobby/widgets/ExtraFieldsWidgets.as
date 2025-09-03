/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.widgets
{
    import com.xfw.*;
    import com.xvm.extraFields.*;
    import com.xvm.lobby.vo.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.display.*;
    import scaleform.clik.core.*;

    public class ExtraFieldsWidgets extends UIComponent implements IExtraFieldGroupHolder
    {
        private var cfg:Array;

        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;
        private var _extraFields:ExtraFieldsGroup = null;

        public function ExtraFieldsWidgets(cfg:Array)
        {
            super();
            this.cfg = cfg;
            mouseEnabled = false;
            _createExtraFields();
        }

        override protected function onDispose():void
        {
            if (_extraFields)
            {
                _extraFields.dispose();
                _extraFields = null;
            }
            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;
            super.onDispose();
        }

        public function update(options:IVOMacrosOptions):void
        {
            if (_extraFields)
            {
                _extraFields.update(options);
            }
        }

        // IExtraFieldGroupHolder

        public function get isLeftPanel():Boolean
        {
            return true;
        }

        public function get substrateHolder():Sprite
        {
            return _substrateHolder;
        }

        public function get bottomHolder():Sprite
        {
            return _bottomHolder;
        }

        public function get normalHolder():Sprite
        {
            return _normalHolder;
        }

        public function get topHolder():Sprite
        {
            return _topHolder;
        }

        public function getSchemeNameForVehicle(options:IVOMacrosOptions):String
        {
            return null;
        }

        public function getSchemeNameForPlayer(options:IVOMacrosOptions):String
        {
            return null;
        }

        // PRIVATE

        private function _createExtraFields():void
        {
            _substrateHolder = _createExtraFieldsHolder();
            _bottomHolder = _createExtraFieldsHolder();
            _normalHolder = _createExtraFieldsHolder();
            _topHolder = _createExtraFieldsHolder();
            _extraFields = new ExtraFieldsGroup(this, cfg, true, CTextFormat.GetDefaultConfigForLobby());
        }

        private function _createExtraFieldsHolder():Sprite
        {
            var sprite:Sprite = new Sprite();
            sprite.x = 0;
            sprite.y = 0;
            sprite.mouseEnabled = false;
            sprite.scaleX = 1;
            sprite.scaleY = 1;
            this.addChild(sprite);
            return sprite;
        }
    }
}
