package net.wg.gui.lobby.tankman 
{
    import net.wg.gui.components.controls.*;
    import scaleform.clik.core.*;
    
    public class SkillsItemsRendererRankIcon extends scaleform.clik.core.UIComponent
    {
        public function SkillsItemsRendererRankIcon()
        {
            super();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            this.iconRank.dispose();
            return;
        }

        public function setData(arg1:String, arg2:*):void
        {
            this.imageUrl = arg1;
            this.isEnabled = arg2;
            invalidate(this.UPDATE_DATA);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(this.UPDATE_DATA)) 
            {
                if (this.imageUrl) 
                    this.iconRank.source = this.imageUrl;
                if (enabled != this.isEnabled) 
                    enabled = this.isEnabled;
            }
            return;
        }

        internal const UPDATE_DATA:String="updateData";

        public var iconRank:net.wg.gui.components.controls.UILoaderAlt;

        internal var imageUrl:String;

        internal var isEnabled:Boolean=true;
    }
}
