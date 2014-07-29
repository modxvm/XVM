package net.wg.gui.lobby.profile.pages.statistics
{
    import net.wg.infrastructure.base.meta.impl.ProfileStatisticsMeta;
    import net.wg.infrastructure.base.meta.IProfileStatisticsMeta;
    import flash.text.TextField;
    import net.wg.gui.lobby.profile.pages.statistics.header.HeaderContainer;
    import net.wg.gui.lobby.profile.pages.statistics.body.BodyContainer;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.profile.ProfileConstants;
    import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
    
    public class ProfileStatistics extends ProfileStatisticsMeta implements IProfileStatisticsMeta
    {
        
        public function ProfileStatistics()
        {
            super();
        }
        
        public var headerLabel:TextField;
        
        public var headerContainer:HeaderContainer;
        
        public var bodyContainer:BodyContainer;
        
        override protected function initialize() : void
        {
            super.initialize();
            layoutManager = new StatisticsLayoutManager(525,740);
            layoutManager.registerComponents(this.headerContainer);
        }
        
        override protected function applyResizing() : void
        {
            super.applyResizing();
            var _loc1_:* = 100;
            var _loc2_:* = 20;
            var _loc3_:MovieClip = this.headerContainer.image.separator;
            this.bodyContainer.y = this.headerContainer.y + _loc3_.y + _loc3_.height - _loc1_ + _loc2_;
            var _loc4_:Number = Math.min(ProfileConstants.MIN_APP_WIDTH,currentDimension.x);
            this.bodyContainer.setAvailableSize(_loc4_,currentDimension.y);
            this.headerLabel.width = _loc4_;
        }
        
        override public function as_setInitData(param1:Object) : void
        {
            var _loc2_:ProfileBattleTypeInitVO = new ProfileBattleTypeInitVO(param1);
            battlesDropdown.menuProvider = _loc2_.dropDownProvider;
        }
        
        override protected function applyData(param1:Object) : Object
        {
            this.headerLabel.text = param1.headerText;
            this.headerContainer.battlesType = battlesType;
            this.headerContainer.setDossierData(param1.headerParams);
            this.bodyContainer.setDossierData(param1.bodyParams);
            return super.applyData(param1);
        }
        
        override protected function onDispose() : void
        {
            this.headerLabel = null;
            this.headerContainer.dispose();
            this.headerContainer = null;
            this.bodyContainer.dispose();
            this.bodyContainer = null;
            super.onDispose();
        }
    }
}
