package net.wg.gui.lobby.fortifications.data.sortie
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import net.wg.gui.rally.interfaces.IRallyListItemVO;
    import net.wg.data.constants.Values;
    
    public class SortieRenderVO extends DAAPIDataClass implements IRallyListItemVO
    {
        
        public function SortieRenderVO(param1:Object) {
            this.sortieID = [Values.DEFAULT_INT,Values.DEFAULT_INT];
            super(param1);
        }
        
        public var sortieID:Array;
        
        public var creatorName:String = "";
        
        public var divisionName:String = "";
        
        public var playerCount:int = -1;
        
        public var commandSize:int = -1;
        
        public var color:int = -1;
        
        private var _rallyIndex:Number = -1;
        
        public var igrType:int = -1;
        
        public function set rallyIndex(param1:Number) : void {
            this._rallyIndex = param1;
        }
        
        public function get peripheryID() : Number {
            return this.sortieID[1];
        }
        
        public function get mgrID() : Number {
            return this.sortieID[0];
        }
        
        public function get rallyIndex() : Number {
            return this._rallyIndex;
        }
    }
}
