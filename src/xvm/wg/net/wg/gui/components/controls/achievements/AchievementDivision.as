package net.wg.gui.components.controls.achievements 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    
    public class AchievementDivision extends net.wg.gui.components.controls.achievements.AchievementCommon
    {
        public function AchievementDivision()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            soundType = net.wg.data.constants.SoundTypes.CAROUSEL_BTN;
            soundId = net.wg.data.constants.SoundManagerStates.CAROUSEL_CELL_BTN;
            super.configUI();
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.ACHIEVMENT, null, data.type, data.description, data.name, false, true);
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            return;
        }

        public override function setData(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            super.setData(net.wg.data.VO.AchievementItemVO(arg1));
            return;
        }

        protected override function applyData():void
        {
            if (data == null) 
                return;
            this.divisionLine.visible = data.hasOwnProperty("showSeparator") ? data.showSeparator : false;
            super.applyData();
            if (data.value <= 1 && counter) 
                counter.visible = false;
            return;
        }

        public var divisionLine:flash.display.MovieClip=null;
    }
}
