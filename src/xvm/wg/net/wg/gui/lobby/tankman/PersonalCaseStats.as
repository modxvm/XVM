package net.wg.gui.lobby.tankman 
{
    import flash.display.*;
    import net.wg.gui.components.carousels.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    
    public class PersonalCaseStats extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function PersonalCaseStats()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.achievements.visible = false;
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            if (this.achievements) 
            {
                this.achievements.dispose();
                this.achievements = null;
            }
            if (this.blocksArea) 
            {
                this.blocksArea.dispose();
                this.blocksArea = null;
            }
            return;
        }

        public function update(arg1:Object):void
        {
            if (arg1 == null) 
                return;
            this.data = arg1;
            if (arg1.achievements.length > 0) 
            {
                this.achievements.dataProvider = new scaleform.clik.data.DataProvider(this.data.achievements);
                this.achievements.invalidate(net.wg.gui.components.carousels.CarouselBase.INIT_CAROUSEL);
                this.achivsBg.visible = false;
            }
            this.blocksArea.setData(arg1.stats);
            return;
        }

        public var blocksArea:net.wg.gui.lobby.tankman.PersonalCaseBlocksArea;

        public var achievements:net.wg.gui.components.carousels.AchievementCarousel;

        public var achivsBg:flash.display.MovieClip;

        internal var data:Object;
    }
}
