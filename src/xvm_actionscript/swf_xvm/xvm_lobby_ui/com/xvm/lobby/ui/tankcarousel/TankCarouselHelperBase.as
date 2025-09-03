package com.xvm.lobby.ui.tankcarousel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.hangar.tcarousel.helper.*;
    import net.wg.infrastructure.exceptions.*;
    import scaleform.clik.utils.*;

    public class TankCarouselHelperBase implements ITankCarouselHelper
    {
        private var _gap:int;
        private var _padding:Padding;
        private var _width:int;
        private var _height:int;
        private var _visibleHeight:int;
        private var _heightDiff:int;

        public function TankCarouselHelperBase(cfg:CCarouselCell)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(cfg);
        }

        private function _init(cfg:CCarouselCell):void
        {
            _gap = Macros.FormatNumberGlobal(cfg.gap, DEFAULT_GAP);
            _padding = new Padding(_gap);
            _width = Macros.FormatNumberGlobal(cfg.width, DEFAULT_RENDERER_WIDTH - 8) + 2;
            _heightDiff = DEFAULT_RENDERER_HEIGHT - DEFAULT_RENDERER_VISIBLE_HEIGHT;
            _height = Macros.FormatNumberGlobal(cfg.height, DEFAULT_RENDERER_WIDTH - 8) + 2;
            _visibleHeight = _height + _heightDiff;
        }

        public function get linkRenderer():String
        {
            throw new AbstractException(XfwUtils.stack() + " " + Errors.ABSTRACT_INVOKE);
        }

        public function get rendererWidth():int
        {
            return _width;
        }

        public function get rendererHeight():int
        {
            return _height;
        }

        public function get horizontalGap():int
        {
            return _gap;
        }

        public function get verticalGap():int
        {
            return _gap;
        }

        public function get padding():Padding
        {
            return _padding;
        }

        CLIENT::WG {
            public function get isSmall():Boolean
            {
                throw new AbstractException(XfwUtils.stack() + " " + Errors.ABSTRACT_INVOKE);
            }
        }

        public function get rendererVisibleHeight():int
        {
            return _visibleHeight;
        }

        public function get rendererHeightDiff():int
        {
            return _heightDiff;
        }

        // protected

        protected function get DEFAULT_GAP():int
        {
            return 10;
        }

        protected function get DEFAULT_RENDERER_WIDTH():int
        {
            throw new AbstractException(XfwUtils.stack() + " " + Errors.ABSTRACT_INVOKE);
        }

        protected function get DEFAULT_RENDERER_HEIGHT():int
        {
            throw new AbstractException(XfwUtils.stack() + " " + Errors.ABSTRACT_INVOKE);
        }

        protected function get DEFAULT_RENDERER_VISIBLE_HEIGHT():int
        {
            throw new AbstractException(XfwUtils.stack() + " " + Errors.ABSTRACT_INVOKE);
        }
    }
}
