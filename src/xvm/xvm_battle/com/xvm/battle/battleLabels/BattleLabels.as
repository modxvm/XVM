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
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xfw.addCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
            Xfw.addCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            createExtraFields();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xfw.removeCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
            Xfw.removeCommandListener(XvmCommands.AS_ON_UPDATE_STAGE, onUpdateStage);
            removeExtraFields();
            super.onDispose();
        }

        // UIComponent

        override protected function draw():void
        {
            if (isInvalid(InvalidationType.STATE, InvalidationType.POSITION))
            {
                update();
            }
        }

        // PRIVATE

        private function onConfigLoaded(e:Event):void
        {
            removeExtraFields();
            createExtraFields();
        }

        private function onUpdateStage():void
        {
            invalidate(InvalidationType.POSITION);
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
                    CTextFormat.GetDefaultConfigForBattleLabels());
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

        private function onKeyEvent(key:Number, isDown:Boolean):void
        {
            try
            {
                // TODO
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function update():void
        {
            if (_extraFields)
            {
                _extraFields.update();
            }
        }
    }
}
