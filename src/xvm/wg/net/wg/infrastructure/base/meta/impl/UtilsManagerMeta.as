package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class UtilsManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function UtilsManagerMeta()
        {
            super();
            return;
        }

        public function getNationNamesS():Array
        {
            App.utils.asserter.assertNotNull(this.getNationNames, "getNationNames" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getNationNames();
        }

        public function getNationIndicesS():Object
        {
            App.utils.asserter.assertNotNull(this.getNationIndices, "getNationIndices" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getNationIndices();
        }

        public function getGUINationsS():Array
        {
            App.utils.asserter.assertNotNull(this.getGUINations, "getGUINations" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getGUINations();
        }

        public var getNationNames:Function=null;

        public var getNationIndices:Function=null;

        public var getGUINations:Function=null;
    }
}
