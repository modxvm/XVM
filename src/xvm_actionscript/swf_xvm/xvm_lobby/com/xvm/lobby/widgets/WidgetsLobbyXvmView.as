/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.widgets
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.lobby.vo.*;
    import com.xvm.types.dossier.*;
    import flash.display.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.interfaces.*;

    public class WidgetsLobbyXvmView extends WidgetsBaseXvmView
    {
        public function WidgetsLobbyXvmView(view:IView)
        {
            super(view);
        }

        public function get page():LobbyPage
        {
            return view as LobbyPage;
        }

        public function setVisibility(isHangar:Boolean):void
        {
            if (extraFieldsWidgetsBottom)
            {
                extraFieldsWidgetsBottom.visible = isHangar;
            }
            if (extraFieldsWidgetsNormal)
            {
                extraFieldsWidgetsNormal.visible = isHangar;
            }
            if (extraFieldsWidgetsTop)
            {
                CLIENT::WG {
                    extraFieldsWidgetsTop.visible = isHangar;
                }
                CLIENT::LESTA {
                    var page:LobbyPage = view as LobbyPage;
                    extraFieldsWidgetsTop.visible = page.header.visible;
                }
            }
        }

        // PROTECTED

        override protected function init():void
        {
            //Logger.add("[widgets] init lobby");

            Xfw.addCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);

            Dossier.requestAccountDossier(null, null, PROFILE_DROPDOWN_KEYS.ALL);

            cfg = Config.config.hangar.widgets;

            //XfwUtils.logChilds(page);

            //Logger.add("page.subViewContainer = " + page.subViewContainer);
            if (page.subViewContainer == null)
                return;

            var index:int;

            var widgets:Array = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_BOTTOM);
            if (widgets != null)
            {
                if (widgets.length > 0)
                {
                    CLIENT::WG {
                        // temporarily spawn all widgets at the same layer
                        extraFieldsWidgetsBottom = page.addChild(new ExtraFieldsWidgets(widgets)) as ExtraFieldsWidgets;
                    }
                    CLIENT::LESTA {
                        index = 0;
                        extraFieldsWidgetsBottom = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
                    }
                    extraFieldsWidgetsBottom.name = "extraFieldsWidgetsBottom";
                    extraFieldsWidgetsBottom.visible = false;
                }
            }

            widgets = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_NORMAL);
            if (widgets != null)
            {
                if (widgets.length > 0)
                {
                    CLIENT::WG {
                        // temporarily spawn all widgets at the same layer
                        extraFieldsWidgetsNormal = page.addChild(new ExtraFieldsWidgets(widgets)) as ExtraFieldsWidgets;
                    }
                    CLIENT::LESTA {
                        index = page.getChildIndex(page.subViewContainer as DisplayObject) + 1;
                        extraFieldsWidgetsNormal = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
                    }
                    extraFieldsWidgetsNormal.name = "extraFieldsWidgetsNormal";
                    extraFieldsWidgetsNormal.visible = false;
                }
            }

            widgets = filterWidgets(cfg, Defines.WIDGET_TYPE_EXTRAFIELD, Defines.LAYER_TOP);
            if (widgets != null)
            {
                if (widgets.length > 0)
                {
                    CLIENT::WG {
                        // temporarily spawn all widgets at the same layer
                        extraFieldsWidgetsTop = page.addChild(new ExtraFieldsWidgets(widgets)) as ExtraFieldsWidgets;
                    }
                    CLIENT::LESTA {
                        index = page.getChildIndex(page.header) + 1;
                        extraFieldsWidgetsTop = page.addChildAt(new ExtraFieldsWidgets(widgets), index) as ExtraFieldsWidgets;
                    }
                    extraFieldsWidgetsTop.name = "extraFieldsWidgetsTop";
                    extraFieldsWidgetsTop.visible = false;
                }
            }

            onUpdateCurrentVehicle(Xfw.cmd(XvmCommands.GET_CURRENT_VEH_CD), null);
        }

        override protected function remove():void
        {
            Xfw.removeCommandListener(XvmCommands.AS_UPDATE_CURRENT_VEHICLE, onUpdateCurrentVehicle);
            super.remove();
        }

        // PRIVATE

        private function onUpdateCurrentVehicle(vehCD:int, data:Object):Object
        {
            //Logger.add("onUpdateCurrentVehicle: " + vehCD);
            var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
            options.vehCD = vehCD;
            var dossier:AccountDossier = Dossier.getAccountDossier();
            if (dossier)
            {
                if (options.vehicleData)
                {
                    options.vehicleData.__vehicleDossierCut = dossier.getVehicleDossierCut(options.vehCD);
                }
                if (extraFieldsWidgetsBottom)
                {
                    extraFieldsWidgetsBottom.update(options);
                }
                if (extraFieldsWidgetsNormal)
                {
                    extraFieldsWidgetsNormal.update(options);
                }
                if (extraFieldsWidgetsTop)
                {
                    extraFieldsWidgetsTop.update(options);
                }
            }
            //Logger.addObject(options, 3);
            return null;
        }
    }
}