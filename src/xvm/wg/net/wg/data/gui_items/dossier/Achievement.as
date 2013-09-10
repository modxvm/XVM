package net.wg.data.gui_items.dossier 
{
    import net.wg.data.constants.*;
    import net.wg.data.gui_items.*;
    
    public class Achievement extends net.wg.data.gui_items.GUIItem
    {
        public function Achievement(arg1:String, arg2:uint, arg3:*)
        {
            this._dossierType = arg2;
            super(net.wg.data.constants.ItemTypes.ACHIEVEMENT, [arg1, [arg2, arg3]]);
            return;
        }

        public function get isDossierForCurrentUser():*
        {
            var loc1:*=false;
            if (this._dossierType != 16) 
            {
                if (this._dossierType == 17) 
                {
                    loc1 = id[1][1][1] == null;
                }
            }
            else 
            {
                loc1 = id[1][1] == null;
            }
            return loc1;
        }

        public function getSection():String
        {
            return String(_callMethod("getSection"));
        }

        public function getName():String
        {
            return String(_getAttr("name"));
        }

        public function getLvlUpTotalValue():uint
        {
            return uint(_getAttr("lvlUpTotalValue"));
        }

        public function getLvlUpValue():uint
        {
            return uint(_getAttr("lvlUpValue"));
        }

        public function getActivity():Boolean
        {
            return Boolean(_getAttr("isActive"));
        }

        public function getUserName():String
        {
            return String(_getAttr("userName"));
        }

        public function getUserDesription():String
        {
            return String(_getAttr("description"));
        }

        public function getUserHeroInfo():String
        {
            return String(_getAttr("heroInfo"));
        }

        public function isRare():Boolean
        {
            return Boolean(_callMethod("isRare"));
        }

        public function get rareIconId():*
        {
            return _callMethod("requestImageID");
        }

        public function isInDossier():Boolean
        {
            return Boolean(_callMethod("isInDossier"));
        }

        public function getDossierCompDescr():String
        {
            return String(_callMethod("getDossierCompDescr"));
        }

        public function getIcon():Object
        {
            return Object(_getAttr("icon"));
        }

        public function get icon():String
        {
            return this.getIcon()["big"];
        }

        public function get section():String
        {
            return String(_callMethod("getSection"));
        }

        public function get type():String
        {
            return String(_callMethod("getType"));
        }

        public function get value():Number
        {
            return uint(_getAttr("value"));
        }

        internal var _dossierType:int;
    }
}
