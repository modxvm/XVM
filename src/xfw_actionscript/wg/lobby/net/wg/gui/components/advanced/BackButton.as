package net.wg.gui.components.advanced
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.components.advanced.interfaces.IBackButton;
    import net.wg.gui.components.advanced.backButton.BackButtonStates;
    import net.wg.gui.components.advanced.backButton.BackButtonHelper;
    import org.idmedia.as3commons.util.StringUtils;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.helpers.ComponentStatesHelper;
    import scaleform.clik.core.UIComponent;

    public class BackButton extends SoundButtonEx implements IBackButton
    {

        private static const SECONDARY_TEXT_OFFSET:int = 3;

        private static const HIT_AREA_OFFSET:int = 10;

        public var mainStates:BackButtonStates = null;

        public var secondaryStates:BackButtonStates = null;

        private var _hitWidth:int = 0;

        public function BackButton()
        {
            super();
            constraintsDisabled = true;
            preventAutosizing = true;
        }

        override protected function onDispose() : void
        {
            this.mainStates.dispose();
            this.secondaryStates.dispose();
            this.mainStates = null;
            this.secondaryStates = null;
            super.onDispose();
        }

        override protected function updateText() : void
        {
            super.updateText();
            var _loc1_:BackButtonHelper = BackButtonHelper.getInstance();
            _loc1_.updateStatesWidth(this.mainStates);
            _loc1_.updateStatesWidth(this.secondaryStates);
            if(hitMc != null)
            {
                this._hitWidth = this.mainStates.x + this.mainStates.textMc.x + this.mainStates.textMc.width;
                if(StringUtils.isNotEmpty(this.secondaryStates.textMc.textField.text))
                {
                    this.secondaryStates.x = this.mainStates.textMc.x + this.mainStates.textMc.width + SECONDARY_TEXT_OFFSET ^ 0;
                    this._hitWidth = this.secondaryStates.x + this.secondaryStates.width;
                }
                else
                {
                    this.secondaryStates.x = 0;
                }
                hitMc.width = this._hitWidth + HIT_AREA_OFFSET;
            }
        }

        override protected function setState(param1:String) : void
        {
            super.setState(param1);
            this.mainStates.gotoAndPlay(param1);
            this.secondaryStates.gotoAndPlay(param1);
        }

        override protected function initialize() : void
        {
            super.initialize();
            var _loc1_:Vector.<MovieClip> = new <MovieClip>[this.mainStates,this.secondaryStates];
            App.utils.asserter.assert(ComponentStatesHelper.getInstance().compareStatesLabels(_loc1_),"Timeline labels in \'mainStates\' and \'secondaryStates\' must be equals!");
            _loc1_.splice(0,_loc1_.length);
            _labelHash = UIComponent.generateLabelHash(this.mainStates);
        }

        override public function set label(param1:String) : void
        {
            this.mainStates.textMc.textField.text = param1;
            super.label = param1;
        }

        public function set descrLabel(param1:String) : void
        {
            this.secondaryStates.textMc.textField.text = param1;
            invalidateData();
        }

        public function get descrVisible() : Boolean
        {
            return this.secondaryStates.textMc.visible;
        }

        public function set descrVisible(param1:Boolean) : void
        {
            this.secondaryStates.textMc.visible = param1;
        }

        public function get hitWidth() : int
        {
            return this._hitWidth;
        }
    }
}
