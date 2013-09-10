package net.wg.gui.lobby.customization 
{
    import flash.text.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.customization.data.*;
    
    public class EmblemRightSectionView extends net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView
    {
        public function EmblemRightSectionView()
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
            return form.emblemRightDP;
        }

        public override function getGroupsDP():net.wg.data.daapi.base.DAAPIDataProvider
        {
            return form.emblemRightGroupsDataProvider;
        }

        public override function getRentalPackagesDP():net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider
        {
            return form.emblemRightRentalPackageDP;
        }

        public override function getViewLinkage():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.EMBLEM_GROUP_VIEW_COPY;
        }

        public override function getTimeSectionLabel():String
        {
            return MENU.CUSTOMIZATION_LABELS_EMBLEM_PERIOD;
        }

        public override function getDropButtonTooltip():String
        {
            return TOOLTIPS.CUSTOMIZATION_EMBLEMRIGHT_CURRENT_DROP;
        }

        public override function getSectionName():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.EMBLEM_RIGHT;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.curLabel.text = MENU.CUSTOMIZATION_LABELS_EMBLEM_CURRENT;
            this.newLabel.text = MENU.CUSTOMIZATION_LABELS_EMBLEM_NEW;
            return;
        }

        public var curLabel:flash.text.TextField;

        public var newLabel:flash.text.TextField;
    }
}
