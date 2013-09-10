package net.wg.infrastructure.managers.utils.impl 
{
    import net.wg.utils.*;
    
    public class Nations extends Object implements net.wg.utils.INations
    {
        public function Nations(arg1:net.wg.utils.IUtils)
        {
            super();
            this._utilsProxy = arg1;
            return;
        }

        public function getNationName(arg1:uint):String
        {
            return this._utilsProxy.getNationNamesS()[arg1];
        }

        public function getNationID(arg1:String):uint
        {
            return this._utilsProxy.getNationIndicesS()[arg1];
        }

        public function getNations():Array
        {
            return this._utilsProxy.getGUINationsS();
        }

        public function getNationsData():Array
        {
            var loc1:*=[];
            var loc2:*=this.getNations();
            var loc3:*=0;
            while (loc3 < loc2.length) 
            {
                loc1.push({"label":MENU.nations(loc2[loc3]), "data":this.getNationID(loc2[loc3])});
                ++loc3;
            }
            return loc1;
        }

        public function getNationIcon(arg1:int):String
        {
            return "../maps/icons/filters/nations/" + this.getNationName(arg1) + ".png";
        }

        protected var _utilsProxy:net.wg.utils.IUtils=null;
    }
}
