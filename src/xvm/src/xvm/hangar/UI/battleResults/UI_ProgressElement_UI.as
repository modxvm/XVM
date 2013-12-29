package xvm.hangar.UI.battleResults
{
    import com.xvm.Defines;

    /**
     * @author Pavel Máca
     */
    public class UI_ProgressElement_UI extends ProgressElement_UI
    {
        public function UI_ProgressElement_UI()
        {
            super();
            this.progressIndicator.textField.textColor = Defines.UICOLOR_VALUE;
        }
    }

}