package net.wg.gui.lobby.fortifications.cmp.battleRoom
{
    import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
    import flash.display.Sprite;
    import net.wg.gui.interfaces.IButtonIconTextTransparent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.data.constants.Errors;
    import flash.events.MouseEvent;
    
    public class SortieSimpleSlot extends RallySimpleSlotRenderer
    {
        
        public function SortieSimpleSlot()
        {
            super();
        }
        
        public var lockBackground:Sprite = null;
        
        public function get grayTakePlaceFirstButton() : IButtonIconTextTransparent
        {
            return takePlaceFirstTimeBtn as IButtonIconTextTransparent;
        }
        
        public function set grayTakePlaceFirstButton(param1:IButtonIconTextTransparent) : void
        {
            takePlaceFirstTimeBtn = param1 as SoundButtonEx;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            App.utils.asserter.assertNotNull(this.lockBackground,"lockBackground in " + name + Errors.CANT_NULL);
            takePlaceBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
            this.grayTakePlaceFirstButton.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
            if(commander)
            {
                commander.addEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
        }
        
        override protected function onDispose() : void
        {
            if(commander)
            {
                commander.removeEventListener(MouseEvent.ROLL_OVER,onControlRollOver);
                commander.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            this.lockBackground = null;
            super.onDispose();
        }
    }
}
