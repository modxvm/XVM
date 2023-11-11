﻿/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.battle.winback.battleloading
{
    import com.xfw.*;
    import com.xvm.battle.shared.battleloading.XvmBattleLoadingItemRendererProxyBase;
    import flash.text.TextField;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.gui.battle.battleloading.renderers.BaseRendererContainer;
    import net.wg.gui.battle.battleloading.renderers.TipPlayerItemRenderer;

    public class XvmWinbackTipPlayerItemRenderer extends TipPlayerItemRenderer
    {
        private var _proxy:XvmWinbackBattleLoadingItemRendererProxy;

        public function XvmWinbackTipPlayerItemRenderer(container:BaseRendererContainer, position:int, isEnemy:Boolean)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init1(container, position, isEnemy);
            super(container, position, isEnemy);
            _init2(container, position, isEnemy);
        }

        private function _init1(container:BaseRendererContainer, position:int, isEnemy:Boolean):void
        {
            var vehicleField:TextField = container.vehicleFieldsAlly[position];
            if (!isEnemy)
            {
                vehicleField.x = container.vehicleTypeIconsAlly[position].x - vehicleField.width;
            }
        }

        private function _init2(container:BaseRendererContainer, position:int, isEnemy:Boolean):void
        {
            _proxy = new XvmWinbackBattleLoadingItemRendererProxy(this, XvmBattleLoadingItemRendererProxyBase.UI_TYPE_TIP,
                container, position, isEnemy, selfBg, invalidate);
        }

        override protected function onDispose():void
        {
            _proxy.onDispose();
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();
            _proxy.draw();
        }

        override public function setData(param1:Object):void
        {
            //param1.squadIndex = 1; param1.playerStatus |= PlayerStatus.IS_SQUAD_MAN; // DEBUG
            super.setData(param1);
            _proxy.setData(DAAPIVehicleInfoVO(param1));
        }
    }
}
