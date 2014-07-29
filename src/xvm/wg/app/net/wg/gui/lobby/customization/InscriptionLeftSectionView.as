package net.wg.gui.lobby.customization
{
    import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
    
    public class InscriptionLeftSectionView extends BaseTimedCustomizationSectionView
    {
        
        public function InscriptionLeftSectionView()
        {
            super();
        }
        
        override public function getEmptyDataItem() : Object
        {
            return DAAPIItemsDataProvider.getEmptyItem();
        }
        
        override public function getItemsDP() : DAAPIItemsDataProvider
        {
            return form.inscriptionLeftDP;
        }
        
        override public function getGroupsDP() : DAAPIDataProvider
        {
            return form.inscriptionLeftGroupsDataProvider;
        }
        
        override public function getRentalPackagesDP() : RentalPackageDAAPIDataProvider
        {
            return form.inscriptionLeftRentalPackageDP;
        }
        
        override public function getViewLinkage() : String
        {
            return BaseTimedCustomizationSectionView.INSCRIPTION_GROUP_VIEW;
        }
        
        override public function getTimeSectionLabel() : String
        {
            return MENU.CUSTOMIZATION_LABELS_INSCRIPTION_PERIOD;
        }
        
        override public function getDropButtonTooltip() : String
        {
            return TOOLTIPS.CUSTOMIZATION_INSCRIPTIONLEFT_CURRENT_DROP;
        }
        
        override public function getSectionName() : String
        {
            return BaseTimedCustomizationSectionView.INSCRIPTION_LEFT;
        }
    }
}
