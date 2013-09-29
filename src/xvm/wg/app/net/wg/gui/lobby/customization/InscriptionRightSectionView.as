package net.wg.gui.lobby.customization 
{
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.customization.data.*;
    
    public class InscriptionRightSectionView extends net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView
    {
        public function InscriptionRightSectionView()
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
            return form.inscriptionRightDP;
        }

        public override function getGroupsDP():net.wg.data.daapi.base.DAAPIDataProvider
        {
            return form.inscriptionRightGroupsDataProvider;
        }

        public override function getRentalPackagesDP():net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider
        {
            return form.inscriptionRightRentalPackageDP;
        }

        public override function getViewLinkage():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.INSCRIPTION_GROUP_VIEW_COPY;
        }

        public override function getTimeSectionLabel():String
        {
            return MENU.CUSTOMIZATION_LABELS_INSCRIPTION_PERIOD;
        }

        public override function getDropButtonTooltip():String
        {
            return TOOLTIPS.CUSTOMIZATION_INSCRIPTIONRIGHT_CURRENT_DROP;
        }

        public override function getSectionName():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.INSCRIPTION_RIGHT;
        }
    }
}
