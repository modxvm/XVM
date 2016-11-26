/**
 * XVM
 * @author wotunion <http://www.koreanrandom.com/forum/user/27262-wotunion/>
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.battleLabels
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import net.wg.data.constants.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;

    public class BattleLabels extends UIComponent
    {
        private var _extraFields:ExtraFields = null;

        public function BattleLabels()
        {
            mouseEnabled = false;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true);
            createExtraFields();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.removeEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            Stat.instance.removeEventListener(Stat.COMPLETE_BATTLE, onStatLoaded);
            removeExtraFields();
            super.onDispose();
        }

        // UIComponent

        override protected function draw():void
        {
            if (isInvalid(InvalidationType.STATE, InvalidationType.POSITION))
            {
                if (_extraFields)
                {
                    _extraFields.update(BattleState.get(BattleGlobalData.playerVehicleID)); // TODO: BigWorld.target()
                }
            }
        }

        // PRIVATE

        private function onConfigLoaded(e:Event):void
        {
            removeExtraFields();
            createExtraFields();
        }

        private function onBattleComponentsVisible(e:BooleanEvent):void
        {
            visible = e.value;
        }

        private function onUpdateStage():void
        {
            _extraFields.updateBounds(new Rectangle(0, 0, App.appWidth, App.appHeight));
            invalidate(InvalidationType.POSITION);
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            invalidate(InvalidationType.STATE);
        }

        private function createExtraFields():void
        {
            try
            {
                removeExtraFields();
                var cfg:CBattleLabels = Config.config.battleLabels;
                _extraFields = new ExtraFields(
                    cfg.formats,
                    true,
                    null,
                    null,
                    new Rectangle(0, 0, App.appWidth, App.appHeight),
                    ExtraFields.LAYOUT_ROOT,
                    TextFormatAlign.LEFT,
                    CTextFormat.GetDefaultConfigForBattle());
                addChild(_extraFields);
                invalidate(InvalidationType.ALL);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function removeExtraFields():void
        {
            if (_extraFields)
            {
                _extraFields.dispose();
                _extraFields = null;
            }
        }
    }
}
