package net.wg.gui.lobby.profile.pages.technique 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.pages.awards.*;
    
    public class TechniqueAchievementTab extends net.wg.gui.lobby.profile.components.ResizableContent
    {
        public function TechniqueAchievementTab()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.warningTextField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            this.warningTextField.text = PROFILE.SECTION_TECHNIQUE_AWARDS_NOACHIEVEMENTS;
            this.warningTextField.visible = false;
            this.scrollPane.visible = false;
            this.getPaneContent().gapBetweenBlocks = 6;
            return;
        }

        protected override function applyResizing():void
        {
            super.applyResizing();
            this.scrollPane.setSize(currentDimension.x - this.scrollPane.x, currentDimension.y - this.scrollPane.y);
            this.listBg.height = currentDimension.y - this.listBg.y;
            return;
        }

        public override function update(arg1:Object):void
        {
            var loc2:*=null;
            var loc3:*=false;
            var loc1:*=net.wg.data.gui_items.dossier.VehicleDossier(arg1);
            if (this._data != loc1) 
            {
                this._data = loc1;
                loc2 = loc1.getAchievements(true);
                if (loc3 = isHasAchievements(loc2)) 
                {
                    this.warningTextField.visible = false;
                    this.scrollPane.visible = true;
                }
                else 
                {
                    this.warningTextField.visible = true;
                    this.scrollPane.visible = false;
                }
                this.getPaneContent().data = loc2;
            }
            return;
        }

        internal function getPaneContent():net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer
        {
            return net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer(this.scrollPane.target);
        }

        public override function dispose():void
        {
            if (this.scrollPane) 
            {
                this.scrollPane.dispose();
                this.scrollPane = null;
            }
            super.dispose();
            return;
        }

        internal static function isHasAchievements(arg1:Array):Boolean
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=arg1;
            for each (loc1 in loc3) 
            {
                if (!(loc1.length > 0)) 
                    continue;
                return true;
            }
            return false;
        }

        public var scrollPane:net.wg.gui.lobby.profile.components.ResizableScrollPane;

        public var warningTextField:flash.text.TextField;

        internal var _data:net.wg.data.gui_items.dossier.VehicleDossier;

        public var listBg:flash.display.MovieClip;
    }
}
