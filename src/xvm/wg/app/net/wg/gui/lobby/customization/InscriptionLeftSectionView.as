package net.wg.gui.lobby.customization 
{
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.customization.data.*;
    
    public class InscriptionLeftSectionView extends net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView
    {
        public function InscriptionLeftSectionView()
        {
            super();
            return;
        }

        public override function getEmptyDataItem():Object
        {
            return net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider.getEmptyItem();
        }

        public override function getItemsDP():net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider
        {
            return form.inscriptionLeftDP;
        }

        public override function getGroupsDP():net.wg.data.daapi.base.DAAPIDataProvider
        {
            return form.inscriptionLeftGroupsDataProvider;
        }

        public override function getRentalPackagesDP():net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider
        {
            return form.inscriptionLeftRentalPackageDP;
        }

        public override function getViewLinkage():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.INSCRIPTION_GROUP_VIEW;
        }

        public override function getTimeSectionLabel():String
        {
            return MENU.CUSTOMIZATION_LABELS_INSCRIPTION_PERIOD;
        }

        public override function getDropButtonTooltip():String
        {
            return TOOLTIPS.CUSTOMIZATION_INSCRIPTIONLEFT_CURRENT_DROP;
        }

        public override function getSectionName():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.INSCRIPTION_LEFT;
        }
    }
}
