/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ui.profile
{
    import com.xfw.*;
    import com.xvm.lobby.ui.profile.components.*;
    import flash.utils.*;
	import net.wg.gui.lobby.profile.pages.technique.TechDetailedUnitGroup
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public dynamic class UI_TechniqueStatisticTab extends TechniqueStatisticTab_UI
    {
        private var worker:TechniqueStatisticTabXvm;

        public function UI_TechniqueStatisticTab()
        {
            super();
            worker = new TechniqueStatisticTabXvm(this);
        }

        override protected function configUI():void
        {
            super.configUI();
            worker.configUI();
        }

        override protected function onDispose():void
        {
            super.onDispose();
            worker.onDispose();
        }

        override public function update(arg1:Object):void
        {
            if (_baseDisposed)
                return;

            try
            {
                worker.update(arg1 as ProfileVehicleDossierVO);
                super.update(arg1);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override protected function draw():void
        {
            if (_baseDisposed)
                return;

            try
            {
                super.draw();
				
				var group:TechDetailedUnitGroup = XfwUtils.getPrivateField(this, "xfw_group"); 
                if (group)
                {
                    if (group.unitRendererLinkage != getQualifiedClassName(UI_StatisticsDashLineTextItemIRenderer))
                    {
                        group.unitRendererLinkage = getQualifiedClassName(UI_StatisticsDashLineTextItemIRenderer);
                    }
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PUBLIC

        public function get baseDisposed():Boolean
        {
            return _baseDisposed;
        }
    }
}
