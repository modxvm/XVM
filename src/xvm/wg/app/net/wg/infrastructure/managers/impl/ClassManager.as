package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.BaseImporter;
   import __AS3__.vec.Vector;
   import net.wg.gui.login.impl._Importer;
   import net.wg.gui.intro._Importer;
   import net.wg.gui.lobby.messengerBar._Importer;
   import net.wg.gui.login.EULA._Importer;
   import net.wg.gui.lobby.training._Importer;
   import net.wg.gui.lobby.header._Importer;
   import net.wg.gui.lobby.hangar._Importer;
   import net.wg.gui.lobby.hangar.ammunitionPanel._Importer;
   import net.wg.gui.lobby.hangar.maintenance._Importer;
   import net.wg.gui.lobby.hangar.tcarousel._Importer;
   import net.wg.gui.lobby.hangar.crew._Importer;
   import net.wg.gui.lobby.menu._Importer;
   import net.wg.gui.lobby.barracks._Importer;
   import net.wg.gui.lobby.battlequeue._Importer;
   import net.wg.gui.lobby.battleloading._Importer;
   import net.wg.gui.lobby.vehicleInfo._Importer;
   import net.wg.gui.lobby.moduleInfo._Importer;
   import net.wg.gui.components.icons._Importer;
   import net.wg.gui.components.common._Importer;
   import net.wg.gui.components.common.cursor._Importer;
   import net.wg.gui.components.common.crosshair._Importer;
   import net.wg.gui.components.common.waiting._Importer;
   import net.wg.gui.components.windows._Importer;
   import net.wg.gui.components.controls._Importer;
   import net.wg.gui.components.advanced._Importer;
   import net.wg.gui.components.tooltips._Importer;
   import net.wg.gui.components.tooltips.VO._Importer;
   import net.wg.gui.components.tooltips.finstats._Importer;
   import net.wg.gui.components.tooltips.helpers._Importer;
   import net.wg.gui.lobby.eliteWindow._Importer;
   import net.wg.gui.lobby.sellDialog._Importer;
   import net.wg.gui.lobby.settings._Importer;
   import net.wg.gui.lobby.settings.components._Importer;
   import net.wg.gui.lobby.window._Importer;
   import net.wg.gui.lobby.profile._Importer;
   import net.wg.gui.lobby.store.shop._Importer;
   import net.wg.gui.lobby.store.views._Importer;
   import net.wg.gui.lobby.store.inventory._Importer;
   import net.wg.gui.lobby.store._Importer;
   import net.wg.gui.lobby.techtree._Importer;
   import net.wg.gui.lobby.battleResults._Importer;
   import net.wg.gui.lobby.tankman._Importer;
   import net.wg.gui.lobby.vehicleBuyWindow._Importer;
   import net.wg.gui.lobby.customization._Importer;
   import net.wg.gui.lobby.premiumForm._Importer;
   import net.wg.gui.lobby.demonstration._Importer;
   import net.wg.gui.components.carousels._Importer;
   import net.wg.gui.lobby.confirmModuleWindow._Importer;
   import net.wg.data.VO._Importer;
   import net.wg.gui.prebattle._Importer;
   import net.wg.gui.lobby.recruitWindow._Importer;
   import net.wg.gui.notification._Importer;
   import net.wg.gui.messenger._Importer;
   import net.wg.gui.messenger.controls._Importer;
   import net.wg.gui.messenger.forms._Importer;
   import net.wg.gui.messenger.windows._Importer;
   import net.wg.gui.lobby._Importer;
   import net.wg.gui.lobby.dialogs._Importer;
   import net.wg.gui.tutorial._Importer;
   import net.wg.gui.lobby.browser._Importer;
   import net.wg.gui.lobby.profile.headerBar._Importer;
   import net.wg.gui.lobby.profile.pages.summary._Importer;
   import net.wg.gui.lobby.profile.components._Importer;
   import net.wg.gui.lobby.profile.components.chart.axis._Importer;
   import net.wg.gui.lobby.profile.components.chart.layout._Importer;
   import net.wg.gui.lobby.profile.data._Importer;
   import net.wg.gui.lobby.profile.pages.awards._Importer;
   import net.wg.gui.lobby.profile.pages.statistics._Importer;
   import net.wg.gui.lobby.profile.pages.technique._Importer;
   import net.wg.gui.lobby.profile.components.chart._Importer;
   import net.wg.gui.components.controls.achievements._Importer;
   import net.wg.gui.cyberSport.controls._Importer;
   import net.wg.gui.cyberSport._Importer;
   import net.wg.gui.lobby.questsWindow._Importer;
   import net.wg.gui.lobby.GUIEditor._Importer;


   public class ClassManager extends BaseImporter
   {
          
      public function ClassManager() {
         super();
         importClasses(getAllClasses());
      }

      public static function getAllClasses() : Vector.<Class> {
         return Vector.<Class>([net.wg.gui.login.impl._Importer,net.wg.gui.intro._Importer,net.wg.gui.lobby.messengerBar._Importer,net.wg.gui.login.EULA._Importer,net.wg.gui.lobby.training._Importer,net.wg.gui.lobby.header._Importer,net.wg.gui.lobby.hangar._Importer,net.wg.gui.lobby.hangar.ammunitionPanel._Importer,net.wg.gui.lobby.hangar.maintenance._Importer,net.wg.gui.lobby.hangar.tcarousel._Importer,net.wg.gui.lobby.hangar.crew._Importer,net.wg.gui.lobby.menu._Importer,net.wg.gui.lobby.barracks._Importer,net.wg.gui.lobby.battlequeue._Importer,net.wg.gui.lobby.battleloading._Importer,net.wg.gui.lobby.vehicleInfo._Importer,net.wg.gui.lobby.moduleInfo._Importer,net.wg.gui.components.icons._Importer,net.wg.gui.components.common._Importer,net.wg.gui.components.common.cursor._Importer,net.wg.gui.components.common.crosshair._Importer,net.wg.gui.components.common.waiting._Importer,net.wg.gui.components.windows._Importer,net.wg.gui.components.controls._Importer,net.wg.gui.components.advanced._Importer,net.wg.gui.components.tooltips._Importer,net.wg.gui.components.tooltips.VO._Importer,net.wg.gui.components.tooltips.finstats._Importer,net.wg.gui.components.tooltips.helpers._Importer,net.wg.gui.lobby.eliteWindow._Importer,net.wg.gui.lobby.sellDialog._Importer,net.wg.gui.lobby.settings._Importer,net.wg.gui.lobby.settings.components._Importer,net.wg.gui.lobby.window._Importer,net.wg.gui.lobby.profile._Importer,net.wg.gui.lobby.store.shop._Importer,net.wg.gui.lobby.store.views._Importer,net.wg.gui.lobby.store.inventory._Importer,net.wg.gui.lobby.store._Importer,net.wg.gui.lobby.techtree._Importer,net.wg.gui.lobby.battleResults._Importer,net.wg.gui.lobby.tankman._Importer,net.wg.gui.lobby.vehicleBuyWindow._Importer,net.wg.gui.lobby.customization._Importer,net.wg.gui.lobby.premiumForm._Importer,net.wg.gui.lobby.demonstration._Importer,net.wg.gui.components.carousels._Importer,net.wg.gui.lobby.confirmModuleWindow._Importer,net.wg.data.VO._Importer,net.wg.gui.prebattle._Importer,net.wg.gui.lobby.recruitWindow._Importer,net.wg.gui.notification._Importer,net.wg.gui.messenger._Importer,net.wg.gui.messenger.controls._Importer,net.wg.gui.messenger.forms._Importer,net.wg.gui.messenger.windows._Importer,net.wg.gui.lobby._Importer,net.wg.gui.lobby.dialogs._Importer,net.wg.gui.notification._Importer,net.wg.gui.tutorial._Importer,net.wg.gui.lobby.browser._Importer,net.wg.gui.tutorial._Importer,net.wg.gui.lobby.profile._Importer,net.wg.gui.lobby.profile.headerBar._Importer,net.wg.gui.lobby.profile.pages.summary._Importer,net.wg.gui.lobby.profile.components._Importer,net.wg.gui.lobby.profile.components.chart.axis._Importer,net.wg.gui.lobby.profile.components.chart.layout._Importer,net.wg.gui.lobby.profile.data._Importer,net.wg.gui.lobby.profile.pages.awards._Importer,net.wg.gui.lobby.profile.pages.statistics._Importer,net.wg.gui.lobby.profile.pages.technique._Importer,net.wg.gui.lobby.profile.components.chart._Importer,net.wg.gui.components.controls.achievements._Importer,net.wg.gui.cyberSport.controls._Importer,net.wg.gui.cyberSport._Importer,net.wg.gui.lobby.questsWindow._Importer,net.wg.gui.lobby.GUIEditor._Importer]);
      }
   }

}