package net.wg.gui.lobby.customization
{
    import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
    
    public class InscriptionRightSectionView extends BaseTimedCustomizationSectionView
    {
        
        public function InscriptionRightSectionView()
        {
            super();
        }
        
        override public function getEmptyDataItem() : Object
        {
            return DAAPIItemsDataProvider.getEmptyItem();
        }
        
        override public function getItemsDP() : DAAPIItemsDataProvider
        {
            return form.inscriptionRightDP;
        }
        
        override public function getGroupsDP() : DAAPIDataProvider
        {
            return form.inscriptionRightGroupsDataProvider;
        }
        
        override public function getRentalPackagesDP() : RentalPackageDAAPIDataProvider
        {
            return form.inscriptionRightRentalPackageDP;
        }
        
        override public function getViewLinkage() : String
        {
            return BaseTimedCustomizationSectionView.INSCRIPTION_GROUP_VIEW_COPY;
        }
        
        override public function getTimeSectionLabel() : String
        {
            return MENU.CUSTOMIZATION_LABELS_INSCRIPTION_PERIOD;
        }
        
        override public function getDropButtonTooltip() : String
        {
            return TOOLTIPS.CUSTOMIZATION_INSCRIPTIONRIGHT_CURRENT_DROP;
        }
        
        override public function getSectionName() : String
        {
            return BaseTimedCustomizationSectionView.INSCRIPTION_RIGHT;
        }
    }
}
