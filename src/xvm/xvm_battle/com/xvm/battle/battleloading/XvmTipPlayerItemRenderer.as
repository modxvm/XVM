/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleloading
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.gui.battle.battleloading.renderers.*;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.components.icons.*;

    public class XvmTipPlayerItemRenderer extends TipPlayerItemRenderer implements IXvmBattleLoadingItemRenderer
    {
        private const _DEFAULTS_LEFT:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 100,
            VEHICLE_FIELD_WIDTH: 100,
            SQUAD_X: 8,
            NAME_FIELD_X: 29,
            VEHICLE_FIELD_X: 84,
            VEHICLE_ICON_X: 204,
            VEHICLE_LEVEL_X: 223,
            VEHICLE_TYPE_ICON_X: 183,
            EXTRA_FIELDS_X: 0
        }, XvmItemRendererDefaults);

        private const _DEFAULTS_RIGHT:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 100,
            VEHICLE_FIELD_WIDTH: 100,
            SQUAD_X: 992,
            NAME_FIELD_X: 888,
            VEHICLE_FIELD_X: 831,
            VEHICLE_ICON_X: 815,
            VEHICLE_LEVEL_X: 797,
            VEHICLE_TYPE_ICON_X: 811,
            EXTRA_FIELDS_X: 1011
        }, XvmItemRendererDefaults);

        private var container:RendererContainer;
        private var isEnemy:Boolean;
        private var proxy:XvmBattleLoadingItemRendererProxy;

        public function XvmTipPlayerItemRenderer(container:RendererContainer, position:int, isEnemy:Boolean)
        {
            this.container = container;
            this.isEnemy = isEnemy;

            //Logger.add("XvmTipPlayerItemRenderer");
            var vehicleField:TextField = container.vehicleFieldsAlly[position];
            if (!isEnemy)
            {
                vehicleField.x = container.vehicleTypeIconsAlly[position].x - vehicleField.width;
            }
            super(container, position, isEnemy);
            proxy = new XvmBattleLoadingItemRendererProxy(this, XvmBattleLoadingItemRendererProxy.UI_TYPE_TIPS, !isEnemy);
        }

        override protected function onDispose():void
        {
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
            //param1.squadIndex = 1; param1.playerStatus |= PlayerStatus.IS_SQUAD_MAN; // DEBUG
            super.setData(param1);
            proxy.setData(DAAPIVehicleInfoVO(param1));
        }

        // IXvmBattleLoadingItemRenderer

        public function get DEFAULTS():XvmItemRendererDefaults
        {
            return isEnemy ? _DEFAULTS_RIGHT : _DEFAULTS_LEFT;
        }

        public function get squad():BattleAtlasSprite
        {
            return _squad;
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

        public function get selfBg():BattleAtlasSprite
        {
            return _selfBg;
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
