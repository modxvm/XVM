package net.wg.gui.lobby.quests.components
{
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.text.TextField;
    import net.wg.gui.lobby.quests.data.seasonAwards.BaseSeasonAwardVO;
    import net.wg.gui.lobby.quests.data.seasonAwards.IconTitleDescSeasonAwardVO;
    
    public class IconTitleDescSeasonAward extends SeasonAward
    {
        
        public function IconTitleDescSeasonAward()
        {
            super();
        }
        
        public var iconLoader:UILoaderAlt;
        
        public var descriptionTf:TextField;
        
        public var titleTf:TextField;
        
        override public function setData(param1:BaseSeasonAwardVO) : void
        {
            var _loc2_:IconTitleDescSeasonAwardVO = param1 as IconTitleDescSeasonAwardVO;
            App.utils.asserter.assertNotNull(_loc2_,"data must be SeasonExtraAwardVO");
            this.iconLoader.source = _loc2_.iconPath;
            this.descriptionTf.htmlText = _loc2_.description;
            this.titleTf.htmlText = _loc2_.title;
        }
        
        override protected function onDispose() : void
        {
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.descriptionTf = null;
            this.titleTf = null;
            super.onDispose();
        }
    }
}
