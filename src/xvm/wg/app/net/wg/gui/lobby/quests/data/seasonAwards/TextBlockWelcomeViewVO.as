package net.wg.gui.lobby.quests.data.seasonAwards
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    
    public class TextBlockWelcomeViewVO extends DAAPIDataClass
    {
        
        public function TextBlockWelcomeViewVO(param1:Object)
        {
            super(param1);
        }
        
        public var blockTitle:String = "";
        
        public var blockBody:String = "";
        
        override protected function onDispose() : void
        {
            this.blockTitle = null;
            this.blockBody = null;
            super.onDispose();
        }
    }
}
