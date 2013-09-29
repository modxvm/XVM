package net.wg.gui.lobby.customization 
{
    import __AS3__.vec.*;
    import net.wg.data.daapi.base.*;
    import net.wg.gui.lobby.customization.data.*;
    import net.wg.gui.lobby.customization.renderers.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.customization.data.CamouflagesDataProvider, net.wg.data.daapi.base.DAAPIDataProvider, net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider, net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider, net.wg.gui.lobby.customization.renderers.CamoDemoRenderer, net.wg.gui.lobby.customization.renderers.CamouflageItemRenderer, net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer, net.wg.gui.lobby.customization.renderers.PriceItemRenderer, net.wg.gui.lobby.customization.renderers.RendererBorder, net.wg.gui.lobby.customization.renderers.RentalPackageItemRenderer, net.wg.gui.lobby.customization.renderers.SectionItemRenderer, net.wg.gui.lobby.customization.renderers.TextureItemRenderer, net.wg.gui.lobby.customization.BaseTimedCustomizationGroupView, net.wg.gui.lobby.customization.BaseTimedCustomizationSectionView, net.wg.gui.lobby.customization.CamoDropButton, net.wg.gui.lobby.customization.CamouflageGroupView, net.wg.gui.lobby.customization.CamouflageSectionView, net.wg.gui.lobby.customization.CustomizationEvent, net.wg.gui.lobby.customization.EmblemLeftSectionView, net.wg.gui.lobby.customization.EmblemRightSectionView, net.wg.gui.lobby.customization.InscriptionLeftSectionView, net.wg.gui.lobby.customization.InscriptionRightSectionView, net.wg.gui.lobby.customization.VehicleCustomization]));
            return;
        }
    }
}
