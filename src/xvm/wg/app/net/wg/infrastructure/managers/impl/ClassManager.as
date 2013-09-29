package net.wg.infrastructure.managers.impl 
{
    import __AS3__.vec.*;
    import net.wg.data.VO.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.carousels.*;
    import net.wg.gui.components.common.*;
    import net.wg.gui.components.common.crosshair.*;
    import net.wg.gui.components.common.cursor.*;
    import net.wg.gui.components.common.waiting.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.components.controls.achievements.*;
    import net.wg.gui.components.icons.*;
    import net.wg.gui.components.tooltips.*;
    import net.wg.gui.components.tooltips.VO.*;
    import net.wg.gui.components.tooltips.finstats.*;
    import net.wg.gui.components.tooltips.helpers.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.intro.*;
    import net.wg.gui.lobby.*;
    import net.wg.gui.lobby.barracks.*;
    import net.wg.gui.lobby.battleResults.*;
    import net.wg.gui.lobby.battleloading.*;
    import net.wg.gui.lobby.battlequeue.*;
    import net.wg.gui.lobby.browser.*;
    import net.wg.gui.lobby.confirmModuleWindow.*;
    import net.wg.gui.lobby.customization.*;
    import net.wg.gui.lobby.demonstration.*;
    import net.wg.gui.lobby.dialogs.*;
    import net.wg.gui.lobby.eliteWindow.*;
    import net.wg.gui.lobby.hangar.*;
    import net.wg.gui.lobby.hangar.ammunitionPanel.*;
    import net.wg.gui.lobby.hangar.crew.*;
    import net.wg.gui.lobby.hangar.maintenance.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.gui.lobby.header.*;
    import net.wg.gui.lobby.menu.*;
    import net.wg.gui.lobby.messengerBar.*;
    import net.wg.gui.lobby.moduleInfo.*;
    import net.wg.gui.lobby.premiumForm.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.components.chart.*;
    import net.wg.gui.lobby.profile.components.chart.axis.*;
    import net.wg.gui.lobby.profile.components.chart.layout.*;
    import net.wg.gui.lobby.profile.data.*;
    import net.wg.gui.lobby.profile.headerBar.*;
    import net.wg.gui.lobby.profile.pages.awards.*;
    import net.wg.gui.lobby.profile.pages.statistics.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.questsWindow.*;
    import net.wg.gui.lobby.recruitWindow.*;
    import net.wg.gui.lobby.sellDialog.*;
    import net.wg.gui.lobby.settings.*;
    import net.wg.gui.lobby.settings.components.*;
    import net.wg.gui.lobby.store.*;
    import net.wg.gui.lobby.store.inventory.*;
    import net.wg.gui.lobby.store.shop.*;
    import net.wg.gui.lobby.store.views.*;
    import net.wg.gui.lobby.tankman.*;
    import net.wg.gui.lobby.techtree.*;
    import net.wg.gui.lobby.training.*;
    import net.wg.gui.lobby.vehicleBuyWindow.*;
    import net.wg.gui.lobby.vehicleInfo.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.gui.login.EULA.*;
    import net.wg.gui.login.impl.*;
    import net.wg.gui.messenger.*;
    import net.wg.gui.messenger.controls.*;
    import net.wg.gui.messenger.forms.*;
    import net.wg.gui.messenger.windows.*;
    import net.wg.gui.notification.*;
    import net.wg.gui.prebattle.*;
    import net.wg.gui.tutorial.*;
    import net.wg.infrastructure.*;
    
    public class ClassManager extends net.wg.infrastructure.BaseImporter
    {
        public function ClassManager()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.login.impl._Importer, net.wg.gui.intro._Importer, net.wg.gui.lobby.messengerBar._Importer, net.wg.gui.login.EULA._Importer, net.wg.gui.lobby.training._Importer, net.wg.gui.lobby.header._Importer, net.wg.gui.lobby.hangar._Importer, net.wg.gui.lobby.hangar.ammunitionPanel._Importer, net.wg.gui.lobby.hangar.maintenance._Importer, net.wg.gui.lobby.hangar.tcarousel._Importer, net.wg.gui.lobby.hangar.crew._Importer, net.wg.gui.lobby.menu._Importer, net.wg.gui.lobby.barracks._Importer, net.wg.gui.lobby.battlequeue._Importer, net.wg.gui.lobby.battleloading._Importer, net.wg.gui.lobby.vehicleInfo._Importer, net.wg.gui.lobby.moduleInfo._Importer, net.wg.gui.components.icons._Importer, net.wg.gui.components.common._Importer, net.wg.gui.components.common.cursor._Importer, net.wg.gui.components.common.crosshair._Importer, net.wg.gui.components.common.waiting._Importer, net.wg.gui.components.windows._Importer, net.wg.gui.components.controls._Importer, net.wg.gui.components.advanced._Importer, net.wg.gui.components.tooltips._Importer, net.wg.gui.components.tooltips.VO._Importer, net.wg.gui.components.tooltips.finstats._Importer, net.wg.gui.components.tooltips.helpers._Importer, net.wg.gui.lobby.eliteWindow._Importer, net.wg.gui.lobby.sellDialog._Importer, net.wg.gui.lobby.settings._Importer, net.wg.gui.lobby.settings.components._Importer, net.wg.gui.lobby.window._Importer, net.wg.gui.lobby.profile._Importer, net.wg.gui.lobby.store.shop._Importer, net.wg.gui.lobby.store.views._Importer, net.wg.gui.lobby.store.inventory._Importer, net.wg.gui.lobby.store._Importer, net.wg.gui.lobby.techtree._Importer, net.wg.gui.lobby.battleResults._Importer, net.wg.gui.lobby.tankman._Importer, net.wg.gui.lobby.vehicleBuyWindow._Importer, net.wg.gui.lobby.customization._Importer, net.wg.gui.lobby.premiumForm._Importer, net.wg.gui.lobby.demonstration._Importer, net.wg.gui.components.carousels._Importer, net.wg.gui.lobby.confirmModuleWindow._Importer, net.wg.data.VO._Importer, net.wg.gui.prebattle._Importer, net.wg.gui.lobby.recruitWindow._Importer, net.wg.gui.notification._Importer, net.wg.gui.messenger._Importer, net.wg.gui.messenger.controls._Importer, net.wg.gui.messenger.forms._Importer, net.wg.gui.messenger.windows._Importer, net.wg.gui.lobby._Importer, net.wg.gui.lobby.dialogs._Importer, net.wg.gui.notification._Importer, net.wg.gui.tutorial._Importer, net.wg.gui.lobby.browser._Importer, net.wg.gui.tutorial._Importer, net.wg.gui.lobby.profile._Importer, net.wg.gui.lobby.profile.headerBar._Importer, net.wg.gui.lobby.profile.pages.summary._Importer, net.wg.gui.lobby.profile.components._Importer, net.wg.gui.lobby.profile.components.chart.axis._Importer, net.wg.gui.lobby.profile.components.chart.layout._Importer, net.wg.gui.lobby.profile.data._Importer, net.wg.gui.lobby.profile.pages.awards._Importer, net.wg.gui.lobby.profile.pages.statistics._Importer, net.wg.gui.lobby.profile.pages.technique._Importer, net.wg.gui.lobby.profile.components.chart._Importer, net.wg.gui.components.controls.achievements._Importer, net.wg.gui.lobby.questsWindow._Importer]));
            return;
        }
    }
}
