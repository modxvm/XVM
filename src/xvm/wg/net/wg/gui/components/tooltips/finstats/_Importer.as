package net.wg.gui.components.tooltips.finstats 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.components.tooltips.finstats.EfficiencyBlock, net.wg.gui.components.tooltips.finstats.EfficiencyCritsBlock]));
            return;
        }
    }
}
