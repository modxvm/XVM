package net.wg.gui.lobby.fortifications.settings.impl
{
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.lobby.fortifications.settings.IFortSettingsContainer;
    import net.wg.gui.components.advanced.ClanEmblem;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.data.settings.FortSettingsClanInfoVO;
    
    public class FortSettingsClanInfo extends UIComponent implements IFortSettingsContainer
    {
        
        public function FortSettingsClanInfo()
        {
            super();
        }
        
        public var clanIcon:ClanEmblem = null;
        
        public var clanTag:TextField = null;
        
        public var creationDate:TextField = null;
        
        public var buildingsCount:TextField = null;
        
        public function update(param1:Object) : void
        {
            var _loc2_:FortSettingsClanInfoVO = FortSettingsClanInfoVO(param1);
            if(this.clanIcon.loader.source != "img://" + _loc2_.clanIcon)
            {
                this.clanIcon.setImage(_loc2_.clanIcon);
            }
            if(this.clanTag.htmlText != _loc2_.clanTag)
            {
                this.clanTag.htmlText = _loc2_.clanTag;
            }
            if(this.creationDate.htmlText != _loc2_.creationDate)
            {
                this.creationDate.htmlText = _loc2_.creationDate;
            }
            if(this.buildingsCount.htmlText != _loc2_.buildingCount)
            {
                this.buildingsCount.htmlText = _loc2_.buildingCount;
            }
        }
        
        override protected function onDispose() : void
        {
            this.clanIcon.dispose();
            this.clanIcon = null;
            this.clanTag = null;
            this.creationDate = null;
            this.buildingsCount = null;
            super.onDispose();
        }
    }
}
