/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author wotunion <https://kr.cm/f/p/27262/>
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.shared.battleLabels
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.extraFields.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.gui.battle.views.*;
    import scaleform.clik.core.*;

    public class BattleLabels extends UIComponent implements IExtraFieldGroupHolder
    {
        private var _substrateHolder:Sprite;
        private var _bottomHolder:Sprite;
        private var _normalHolder:Sprite;
        private var _topHolder:Sprite;
        private var extraFields:ExtraFieldsGroup = null;

        public function BattleLabels(battlePage:BaseBattlePage)
        {
            mouseEnabled = false;
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLE, onStatLoaded, false, 0, true);

            _substrateHolder = battlePage.addChildAt(new Sprite(), 0) as Sprite;
            _substrateHolder.mouseEnabled = false;
            _substrateHolder.name = "_substrateHolder";

            _bottomHolder = battlePage.addChildAt(new Sprite(), 1) as Sprite;
            _bottomHolder.mouseEnabled = false;
            _bottomHolder.name = "_bottomHolder";

            var radialMenu:DisplayObject = battlePage.getChildByName("radialMenu");
            if (radialMenu == null)
            {
                _normalHolder = battlePage.addChild(new Sprite()) as Sprite;
            }
            else
            {
                _normalHolder = battlePage.addChildAt(new Sprite(), battlePage.getChildIndex(radialMenu)) as Sprite;
            }
            _normalHolder.mouseEnabled = false;
            _normalHolder.name = "_normalHolder";

            _topHolder = battlePage.addChild(new Sprite()) as Sprite;
            _topHolder.mouseEnabled = false;
            _topHolder.name = "_topHolder";

            createExtraFields();
        }

        override protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.removeEventListener(BattleEvents.TEAM_BASES_PANEL_VISIBLE, onBattleComponentsVisible);
            Stat.instance.removeEventListener(Stat.COMPLETE_BATTLE, onStatLoaded);

            disposeExtraFields();
            _substrateHolder = null;
            _bottomHolder = null;
            _normalHolder = null;
            _topHolder = null;

            super.onDispose();
        }

        // UIComponent

        override protected function draw():void
        {
            if (isInvalid(InvalidationType.STATE, InvalidationType.POSITION))
            {
                if (extraFields)
                {
                    extraFields.update(BattleState.get(BattleGlobalData.playerVehicleID));
                }
            }
        }

        override public function set visible(value:Boolean):void
        {
            extraFields.visible = value;
            super.visible = value;
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

        private function onConfigLoaded(e:Event):void
        {
            disposeExtraFields();
            createExtraFields();
        }

        private function onBattleComponentsVisible(e:BooleanEvent):void
        {
            visible = e.value;
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            invalidate(InvalidationType.STATE);
        }

        private function createExtraFields():void
        {
            try
            {
                var cfg:CBattleLabels = Config.config.battleLabels;
                var formats:Array = cfg.formats;
                if (formats)
                {
                    if (formats.length)
                    {
                        extraFields = new ExtraFieldsGroup(this, formats, true, CTextFormat.GetDefaultConfigForBattle());
                        invalidate(InvalidationType.ALL);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function disposeExtraFields():void
        {
            if (extraFields)
            {
                extraFields.dispose();
                extraFields = null;
            }
        }
    }
}
