package net.wg.gui.lobby.techtree.data 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.techtree.data.AbstractDataProvider, net.wg.gui.lobby.techtree.data.NationVODataProvider, net.wg.gui.lobby.techtree.data.NationXMLDataProvider, net.wg.gui.lobby.techtree.data.ResearchVODataProvider, net.wg.gui.lobby.techtree.data.ResearchXMLDataProvider]));
            return;
        }
    }
}

import flash.display.*;
import flash.events.*;
import net.wg.infrastructure.*;



{
    var loc1:*=net.wg.gui.lobby.techtree.data.ResearchXMLDataProvider;
    loc1;
}