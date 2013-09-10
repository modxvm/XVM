package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.profile.components.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class TechniqueStackComponent extends scaleform.clik.core.UIComponent
    {
        public function TechniqueStackComponent()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.viewStack.cache = true;
            this.buttonBar.dataProvider = new scaleform.clik.data.DataProvider([{"label":PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC, "linkage":"TechniqueStatisticTab_UI", "tooltip":PROFILE.SECTION_TECHNIQUE_TABBTN_STATISTIC_TOOLTIP}, {"label":PROFILE.SECTION_TECHNIQUE_TABBTN_ACHIEVEMENTS, "linkage":"TechniqueAchievementTab_UI", "tooltip":PROFILE.SECTION_TECHNIQUE_TABBTN_AWARDS_TOOLTIP}]);
            this.buttonBar.selectedIndex = 0;
            this.buttonBar.validateNow();
            return;
        }

        public override function dispose():void
        {
            if (this.buttonBar) 
            {
                this.buttonBar.dispose();
                this.buttonBar = null;
            }
            if (this.viewStack) 
            {
                this.viewStack.dispose();
                this.viewStack = null;
            }
            if (this.typeIcon) 
            {
                this.typeIcon.dispose();
                this.typeIcon = null;
            }
            this.tabsBg = null;
            super.dispose();
            return;
        }

        public function setViewSize(arg1:Number, arg2:Number):void
        {
            this.tabsBg.scrollRect = new flash.geom.Rectangle(0, 0, this.tabsBg.width, arg2);
            this.viewStack.setAvailableSize(arg1 - this.viewStack.x, arg2 - this.viewStack.y);
            return;
        }

        public function setData(arg1:net.wg.gui.lobby.profile.pages.technique.TechniqueListVehicleVO):void
        {
            this.vNameTF.text = arg1.userName;
            this.typeIcon.source = arg1.typeIconPath;
            return;
        }

        public function updateTankData(arg1:Object):void
        {
            this.viewStack.updateData(arg1);
            return;
        }

        public var vNameTF:flash.text.TextField;

        public var typeIcon:net.wg.gui.components.controls.UILoaderAlt;

        public var tabsBg:flash.display.MovieClip;

        public var buttonBar:net.wg.gui.components.advanced.ButtonBarEx;

        public var viewStack:net.wg.gui.lobby.profile.components.ResizableViewStack;
    }
}
