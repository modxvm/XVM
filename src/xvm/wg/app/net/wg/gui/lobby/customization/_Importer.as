package net.wg.gui.lobby.customization
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.lobby.customization.data.CamouflagesDataProvider;
   import net.wg.data.daapi.base.DAAPIDataProvider;
   import net.wg.gui.lobby.customization.data.DAAPIItemsDataProvider;
   import net.wg.gui.lobby.customization.data.RentalPackageDAAPIDataProvider;
   import net.wg.gui.lobby.customization.renderers.CamoDemoRenderer;
   import net.wg.gui.lobby.customization.renderers.CamouflageItemRenderer;
   import net.wg.gui.lobby.customization.renderers.CustomizationItemRenderer;
   import net.wg.gui.lobby.customization.renderers.PriceItemRenderer;
   import net.wg.gui.lobby.customization.renderers.RendererBorder;
   import net.wg.gui.lobby.customization.renderers.RentalPackageItemRenderer;
   import net.wg.gui.lobby.customization.renderers.SectionItemRenderer;
   import net.wg.gui.lobby.customization.renderers.TextureItemRenderer;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([CamouflagesDataProvider,DAAPIDataProvider,DAAPIItemsDataProvider,RentalPackageDAAPIDataProvider,CamoDemoRenderer,CamouflageItemRenderer,CustomizationItemRenderer,PriceItemRenderer,RendererBorder,RentalPackageItemRenderer,SectionItemRenderer,TextureItemRenderer,BaseTimedCustomizationGroupView,BaseTimedCustomizationSectionView,CamoDropButton,CamouflageGroupView,CamouflageSectionView,CustomizationEvent,EmblemLeftSectionView,EmblemRightSectionView,InscriptionLeftSectionView,InscriptionRightSectionView,VehicleCustomization]));
      }
   }

}