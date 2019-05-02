/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.ranked.battleloading
{
    import com.xfw.*;
    import com.xvm.battle.shared.battleloading.XvmItemRendererDefaults;
    import com.xvm.battle.shared.battleloading.XvmBattleLoadingItemRendererProxyBase;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.ranked.battleloading.renderers.*;
    import net.wg.gui.components.icons.*;

    public class XvmTipPlayerItemRenderer extends TipPlayerItemRenderer implements IXvmBattleLoadingItemRenderer
    {
        private var _badgeIcon:BattleAtlasSprite;
        private var _nameField:TextField;
        private var _vehicleField:TextField;
        private var _textField:TextField;
        private var _vehicleIcon:BattleAtlasSprite;
        private var _vehicleLevelIcon:BattleAtlasSprite;
        private var _vehicleTypeIcon:BattleAtlasSprite;
        private var _playerActionMarker:PlayerActionMarker;
        private var _icoIGR:BattleAtlasSprite;
        private var _icoTester:BattleAtlasSprite;
        private var _backTester:MovieClip;
        private var _squad:BattleAtlasSprite;

        private var container:BaseRendererContainer;
        private var isEnemy:Boolean;
        private var proxy:XvmBattleLoadingItemRendererProxy;

        public function XvmTipPlayerItemRenderer(container:BaseRendererContainer, position:int, isEnemy:Boolean)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init1(container, position, isEnemy);
            super(container, position, isEnemy);
            _init2(isEnemy);
        }

        private function _init1(container:BaseRendererContainer, position:int, isEnemy:Boolean):void
        {
            this.container = container;
            this.isEnemy = isEnemy;

            if (isEnemy)
            {
                this._vehicleField = container.vehicleFieldsEnemy[position];
                this._textField = container.textFieldsEnemy[position];
                this._vehicleIcon = container.vehicleIconsEnemy[position];
                this._vehicleTypeIcon = container.vehicleTypeIconsEnemy[position];
                this._vehicleLevelIcon = container.vehicleLevelIconsEnemy[position];
                this._playerActionMarker = container.playerActionMarkersEnemy[position];
                this._icoIGR = container.icoIGRsEnemy[position];
                this._icoTester = container.icoTestersEnemy[position];
                this._backTester = container.backTestersEnemy[position];
                this._badgeIcon = container.badgesEnemy[position];
            }
            else
            {
                this._vehicleField = container.vehicleFieldsAlly[position];
                this._textField = container.textFieldsAlly[position];
                this._vehicleIcon = container.vehicleIconsAlly[position];
                this._vehicleTypeIcon = container.vehicleTypeIconsAlly[position];
                this._vehicleLevelIcon = container.vehicleLevelIconsAlly[position];
                this._playerActionMarker = container.playerActionMarkersAlly[position];
                this._icoIGR = container.icoIGRsAlly[position];
                this._icoTester = container.icoTestersAlly[position];
                this._backTester = container.backTestersAlly[position];
                this._badgeIcon = container.badgesAlly[position];
            }

            //Logger.add("XvmTipPlayerItemRenderer");
            var vehicleField:TextField = container.vehicleFieldsAlly[position];
            if (!isEnemy)
            {
                vehicleField.x = container.vehicleTypeIconsAlly[position].x - vehicleField.width;
            }
        }

        private function _init2(isEnemy:Boolean):void
        {
            proxy = new XvmBattleLoadingItemRendererProxy(this, XvmBattleLoadingItemRendererProxyBase.UI_TYPE_TIPS, !isEnemy);
        }

        override protected function onDispose():void
        {
            _badgeIcon = null;
            _nameField = null;
            _vehicleField = null;
            _vehicleIcon = null;
            _vehicleLevelIcon = null;
            _vehicleTypeIcon = null;
            _playerActionMarker = null;
            _icoIGR = null;
            _squad = null;
            container = null;
            proxy.onDispose();
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
            proxy.draw();
        }

        override public function setData(param1:Object):void
        {
            //param1.rankLevel = 1; // DEBUG
            super.setData(param1);
            proxy.setData(DAAPIVehicleInfoVO(param1));
        }

        // IXvmBattleLoadingItemRenderer

        public function get DEFAULTS():XvmItemRendererDefaults
        {
            return isEnemy ? XvmItemRendererDefaults.DEFAULTS_RIGHT_TIP : XvmItemRendererDefaults.DEFAULTS_LEFT_TIP;
        }

        public function get rankIcon():BattleAtlasSprite
        {
            return xfw_rankIcon;
        }

        public function get badgeIcon():BattleAtlasSprite
        {
            return _badgeIcon;
        }

        public function get nameField():TextField
        {
            return _textField;
        }

        public function get vehicleField():TextField
        {
            return _vehicleField;
        }

        public function get vehicleIcon():BattleAtlasSprite
        {
            return _vehicleIcon;
        }

        public function get vehicleLevelIcon():BattleAtlasSprite
        {
            return _vehicleLevelIcon;
        }

        public function get vehicleTypeIcon():BattleAtlasSprite
        {
            return _vehicleTypeIcon;
        }
        public function get playerActionMarker():PlayerActionMarker
        {
            return _playerActionMarker;
        }

        public function get selfBg_pub():BattleAtlasSprite
        {
            return selfBg;
        }

        public function get icoIGR():BattleAtlasSprite
        {
            return _icoIGR;
        }

		public function invalidate2(id:uint = uint.MAX_VALUE):void
        {
            invalidate(id);
        }

        public function addChild(child:DisplayObject):DisplayObject
        {
            return container.addChild(child);
        }

        public function addChildAt(child:DisplayObject, index:int):DisplayObject
        {
            return container.addChildAt(child, index);
        }

        public function getChildIndex(child:DisplayObject):int
        {
            return container.getChildIndex(child);
        }
    }
}
