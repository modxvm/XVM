package net.wg.gui.lobby.customization 
{
    import flash.text.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.customization.data.*;
    
    public class EmblemLeftSectionView extends net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView
    {
        public function EmblemLeftSectionView()
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
            return form.emblemLeftDP;
        }

        public override function getGroupsDP():net.wg.data.daapi.base.DAAPIDataProvider
        {
            return form.emblemLeftGroupsDataProvider;
        }

        public override function getRentalPackagesDP():net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider
        {
            return form.emblemLeftRentalPackageDP;
        }

        public override function getViewLinkage():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.EMBLEM_GROUP_VIEW;
        }

        public override function getTimeSectionLabel():String
        {
            return MENU.CUSTOMIZATION_LABELS_EMBLEM_PERIOD;
        }

        public override function getDropButtonTooltip():String
        {
            return TOOLTIPS.CUSTOMIZATION_EMBLEMLEFT_CURRENT_DROP;
        }

        public override function getSectionName():String
        {
            return net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView.EMBLEM_LEFT;
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
