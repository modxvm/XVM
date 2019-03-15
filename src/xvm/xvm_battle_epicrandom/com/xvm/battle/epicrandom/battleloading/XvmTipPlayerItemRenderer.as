/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.epicrandom.battleloading
{
    import com.xfw.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.VO.daapi.*;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
    import net.wg.gui.battle.components.*;
    import net.wg.gui.battle.epicRandom.battleloading.renderers.*;
    import net.wg.gui.components.icons.*;

    public class XvmTipPlayerItemRenderer extends TableEpicRandomPlayerItemRenderer implements IXvmBattleLoadingItemRenderer
    {
        private var container:BaseRendererContainer;
        private var proxy:XvmBattleLoadingItemRendererProxy;

        // TODO:EPIC
        /*
        public function XvmTipPlayerItemRenderer(container:BaseRendererContainer, position:int, isEnemy:Boolean)
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
        */

        public function XvmTipPlayerItemRenderer()
        {
            super();
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
            //param1.rankLevel = 1; // DEBUG
            super.setData(param1);
            proxy.setData(DAAPIVehicleInfoVO(param1));
        }

        public function get isEnemy():Boolean
        {
            return false; // TODO:EPIC
        }

        // IXvmBattleLoadingItemRenderer

        public function get DEFAULTS():XvmItemRendererDefaults
        {
            return isEnemy ? XvmItemRendererDefaults.DEFAULTS_RIGHT_TIP : XvmItemRendererDefaults.DEFAULTS_LEFT_TIP;
        }

        public function get f_rankIcon():BattleAtlasSprite
        {
            return null; // TODO:EPIC
        }

        public function get f_badgeIcon():BattleAtlasSprite
        {
            return rankBadge;
        }

        public function get f_nameField():TextField
        {
            return textField;
        }

        public function get f_vehicleField():TextField
        {
            return vehicleField;
        }

        public function get f_vehicleIcon():BattleAtlasSprite
        {
            return vehicleIcon;
        }

        public function get f_vehicleLevelIcon():BattleAtlasSprite
        {
            return vehicleLevelIcon;
        }

        public function get f_vehicleTypeIcon():BattleAtlasSprite
        {
            return vehicleTypeIcon;
        }
        public function get f_playerActionMarker():PlayerActionMarker
        {
            return playerActionMarker;
        }

        public function get f_selfBg():BattleAtlasSprite
        {
            return selfBg;
        }

        public function get f_icoIGR():BattleAtlasSprite
        {
            return icoIGR;
        }

        public function invalidate2(id:uint = uint.MAX_VALUE):void
        {
            invalidate(id);
        }

        /*
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
        */
    }
}
