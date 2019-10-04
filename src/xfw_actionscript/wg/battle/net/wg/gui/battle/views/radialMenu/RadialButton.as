package net.wg.gui.battle.views.radialMenu
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.battle.views.radialMenu.components.SectorWrapper;
    import net.wg.gui.battle.views.radialMenu.components.Content;
    import net.wg.gui.battle.views.radialMenu.components.Icons;
    import flash.display.Sprite;
    import net.wg.gui.battle.views.radialMenu.components.SectorHoveredWrapper;
    import flash.text.TextField;

    public class RadialButton extends BattleUIComponent
    {

        private static const TITLE_TEXT_FIELD_X_OFFSET:int = 30;

        private static const KEY_TEXT_FIELD_X_OFFSET:int = 10;

        private static const ANGLE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        private static const TITLE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

        private static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;

        public var idx:int = -1;

        public var action:String = "";

        public var selected:Boolean = false;

        public var sectorWrapper:SectorWrapper = null;

        public var content:Content = null;

        public var icons:Icons = null;

        public var hitAreaSpr:Sprite = null;

        public var sectorWrapperHovered:SectorHoveredWrapper = null;

        public var contentHovered:Content = null;

        public var iconsHovered:Icons = null;

        public var titleHoveredTF:TextField = null;

        public var keyHoveredTF:TextField = null;

        public var titleTF:TextField = null;

        public var keyTF:TextField = null;

        private var _angle:Number = 0;

        private var _titleStr:String = "";

        private var _keyStr:String = "";

        private var _currentState:String = "";

        public function RadialButton()
        {
            super();
            this.content = this.sectorWrapper.content;
            this.icons = this.content.icons;
            this.titleTF = this.content.titleTF;
            this.keyTF = this.content.keyTF;
            this.contentHovered = this.sectorWrapperHovered.content;
            this.iconsHovered = this.contentHovered.icons;
            this.titleHoveredTF = this.contentHovered.titleTF;
            this.keyHoveredTF = this.contentHovered.keyTF;
            this.hitAreaSpr = this.sectorWrapper.hitAreaSpr;
            this.hitAreaSpr.visible = false;
        }

        public function set title(param1:String) : void
        {
            if(this._titleStr != param1)
            {
                this._titleStr = param1;
                invalidate(TITLE_VALIDATION);
            }
        }

        public function set icon(param1:String) : void
        {
            this.showIcon(param1);
        }

        public function set hotKey(param1:String) : void
        {
            if(this._keyStr != param1)
            {
                this._keyStr = param1;
                invalidate(KEY_VALIDATION);
            }
        }

        private function showIcon(param1:String) : void
        {
            this.icons.showIcon(param1);
            this.iconsHovered.showIcon(param1);
        }

        public function set angle(param1:Number) : void
        {
            if(this._angle != param1)
            {
                this._angle = param1;
                invalidate(ANGLE_VALIDATION);
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(ANGLE_VALIDATION))
            {
                this.rotation = this._angle;
                this.content.rotation = -this._angle;
                this.contentHovered.rotation = -this._angle;
            }
            if(isInvalid(TITLE_VALIDATION))
            {
                this.titleTF.text = this._titleStr;
                this.titleHoveredTF.text = this._titleStr;
                if(this.rotation < 0)
                {
                    this.titleTF.x = -this.titleTF.textWidth - TITLE_TEXT_FIELD_X_OFFSET ^ 0;
                    this.titleHoveredTF.x = this.titleTF.x;
                    this.keyTF.x = this.titleTF.x + this.titleTF.textWidth - KEY_TEXT_FIELD_X_OFFSET ^ 0;
                    this.keyHoveredTF.x = this.keyTF.x;
                }
            }
            if(isInvalid(KEY_VALIDATION))
            {
                this.keyTF.text = this._keyStr;
                this.keyHoveredTF.text = this._keyStr;
                if(this.rotation < 0)
                {
                    this.keyTF.x = this.titleTF.x + this.titleTF.textWidth - KEY_TEXT_FIELD_X_OFFSET ^ 0;
                    this.keyHoveredTF.x = this.keyTF.x;
                }
            }
        }

        public function set state(param1:String) : void
        {
            if(this._currentState != param1)
            {
                this._currentState = param1;
                gotoAndPlay(param1);
            }
        }

        override protected function onDispose() : void
        {
            this.sectorWrapper.dispose();
            this.sectorWrapperHovered.dispose();
            this.sectorWrapper = null;
            this.sectorWrapperHovered = null;
            this.icons = null;
            this.iconsHovered = null;
            this.content = null;
            this.contentHovered = null;
            this.hitAreaSpr = null;
            this.titleTF = null;
            this.keyTF = null;
            this.titleHoveredTF = null;
            this.keyHoveredTF = null;
            super.onDispose();
        }
    }
}
