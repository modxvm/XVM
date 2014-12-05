package net.wg.gui.lobby.quests.components
{
    import flash.display.Sprite;
    import net.wg.gui.lobby.quests.components.interfaces.ITextBlockWelcomeView;
    import flash.text.TextField;
    import net.wg.gui.lobby.quests.data.seasonAwards.TextBlockWelcomeViewVO;
    
    public class TextBlockWelcomeView extends Sprite implements ITextBlockWelcomeView
    {
        
        public function TextBlockWelcomeView()
        {
            super();
        }
        
        public var blockTitleTF:TextField = null;
        
        public var blockBodyTF:TextField = null;
        
        public function update(param1:Object) : void
        {
            var _loc2_:TextBlockWelcomeViewVO = TextBlockWelcomeViewVO(param1);
            this.blockTitleTF.htmlText = _loc2_.blockTitle;
            this.blockBodyTF.htmlText = _loc2_.blockBody;
        }
        
        public function dispose() : void
        {
            this.blockTitleTF = null;
            this.blockBodyTF = null;
        }
    }
}
