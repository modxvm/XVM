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

    public class XvmTablePlayerItemRenderer extends TablePlayerItemRenderer implements IXvmBattleLoadingItemRenderer
    {
        private const _DEFAULTS_LEFT:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 250,
            VEHICLE_FIELD_WIDTH: 250,
            SQUAD_X: 65,
            NAME_FIELD_X: 86,
            VEHICLE_FIELD_X: 120,
            VEHICLE_ICON_X: 402,
            VEHICLE_LEVEL_X: 421,
            VEHICLE_TYPE_ICON_X: 371,
            EXTRA_FIELDS_X: 10
        }, XvmItemRendererDefaults);

        private const _DEFAULTS_RIGHT:XvmItemRendererDefaults = ObjectConverter.convertData({
            NAME_FIELD_WIDTH: 250,
            VEHICLE_FIELD_WIDTH: 250,
            SQUAD_X: 934,
            NAME_FIELD_X: 680,
            VEHICLE_FIELD_X: 644,
            VEHICLE_ICON_X: 612,
            VEHICLE_LEVEL_X: 592,
            VEHICLE_TYPE_ICON_X: 618,
            EXTRA_FIELDS_X: 1011
        }, XvmItemRendererDefaults);

        private var container:BaseRendererContainer;
        private var isEnemy:Boolean;
        private var proxy:XvmBattleLoadingItemRendererProxy;

        public function XvmTablePlayerItemRenderer(container:BaseRendererContainer, position:int, isEnemy:Boolean)
        {
            this.container = container;
            this.isEnemy = isEnemy;

            //Logger.add("XvmTablePlayerItemRenderer");
            var vehicleField:TextField = container.vehicleFieldsAlly[position];
            if (!isEnemy)
            {
                vehicleField.x = container.vehicleTypeIconsAlly[position].x - vehicleField.width;
            }
            super(container, position, isEnemy);
            proxy = new XvmBattleLoadingItemRendererProxy(this, XvmBattleLoadingItemRendererProxy.UI_TYPE_TABLE, !isEnemy);
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
