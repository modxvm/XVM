package net.wg.gui.lobby.customization
{
    import flash.text.TextField;
    import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
    
    public class EmblemLeftSectionView extends BaseTimedCustomizationSectionView
    {
        
        public function EmblemLeftSectionView()
        {
            super();
        }
        
        public var curLabel:TextField;
        
        public var newLabel:TextField;
        
        override public function getEmptyDataItem() : Object
        {
            return DAAPIItemsDataProvider.getEmptyItem();
        }
        
        override public function getItemsDP() : DAAPIItemsDataProvider
        {
            return form.emblemLeftDP;
        }
        
        override public function getGroupsDP() : DAAPIDataProvider
        {
            return form.emblemLeftGroupsDataProvider;
        }
        
        override public function getRentalPackagesDP() : RentalPackageDAAPIDataProvider
        {
            return form.emblemLeftRentalPackageDP;
        }
        
        override public function getViewLinkage() : String
        {
            return BaseTimedCustomizationSectionView.EMBLEM_GROUP_VIEW;
        }
        
        override public function getTimeSectionLabel() : String
        {
            return MENU.CUSTOMIZATION_LABELS_EMBLEM_PERIOD;
        }
        
        override public function getDropButtonTooltip() : String
        {
            if(currentItemData.price.isGold)
            {
                return TOOLTIPS.CUSTOMIZATION_EMBLEMLEFT_CURRENT_DISMOUNT;
            }
            return TOOLTIPS.CUSTOMIZATION_EMBLEMLEFT_CURRENT_DROP;
        }
        
        override public function getSectionName() : String
        {
            return BaseTimedCustomizationSectionView.EMBLEM_LEFT;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.curLabel.text = MENU.CUSTOMIZATION_LABELS_EMBLEM_CURRENT;
            this.newLabel.text = MENU.CUSTOMIZATION_LABELS_EMBLEM_NEW;
        }
    }
}
