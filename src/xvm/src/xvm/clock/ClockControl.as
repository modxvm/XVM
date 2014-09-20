/**
 * XVM - clock control
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.clock
{
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.types.*;
    import com.xvm.utils.*;
    import scaleform.clik.constants.*;
    import scaleform.gfx.*;

    public class ClockControl extends LabelControl
    {
        private var cfg:CClock;

        private var prevWidth:Number = 0;
        private var prevHeight:Number = 0;
        private var prevTime:int = 0;
        private var data:String = "";

        public function ClockControl(cfg:CClock)
        {
            this.cfg = cfg;
            Macros.RegisterClockMacros();
        }

        override protected function configUI():void
        {
            super.configUI();

            visible = true;
            this.focusable = false;
            this.mouseChildren = false;
            this.mouseEnabled = false;

            width = cfg.width;
            height = cfg.height;

            textAlign = cfg.textAlign;
            TextFieldEx.setVerticalAlign(textField, cfg.textVAlign);

            alpha = cfg.alpha / 100.0;
            textField.antiAliasType = cfg.antiAliasType;
            if (cfg.bgColor != null && !isNaN(parseInt(cfg.bgColor, 16)))
            {
                textField.background = true;
                textField.backgroundColor = parseInt(cfg.bgColor, 16);
                textField.border = true;
                textField.borderColor = textField.backgroundColor;
            }
            if (cfg.borderColor != null && !isNaN(parseInt(cfg.borderColor, 16)))
            {
                textField.border = true;
                textField.borderColor = parseInt(cfg.borderColor, 16);
            }
            textField.rotation = cfg.rotation;
            if (cfg.shadow.enabled)
                textField.filters = [ Utils.createShadowFilter(cfg.shadow) ];

            invalidate();
            tick();
        }

        override protected function onDispose():void
        {
            App.utils.scheduler.cancelTask(tick);
            super.onDispose();
        }

        override protected function draw():void
        {
            super.draw();

            if (isInvalid(InvalidationType.DATA))
                htmlText = data;

            if (isInvalid(InvalidationType.SIZE))
                this.updatePosition();
        }

        // PRIVATE

        private function updatePosition():void
        {
            prevWidth = App.appWidth;
            prevHeight = App.appHeight;

            x = cfg.x;
            y = cfg.y;

            switch (cfg.align)
            {
                case "center":
                    x += (App.appWidth - cfg.width) / 2;
                    break;
                case "right":
                    x += App.appWidth - cfg.width;
                    break;
            }

            switch (cfg.valign)
            {
                case "center":
                    y += (App.appHeight - cfg.height) / 2;
                    break;
                case "bottom":
                    y += App.appHeight - cfg.height;
                    break;
            }
        }

        private function tick():void
        {
            if (prevWidth != App.appWidth || prevHeight != App.appHeight)
                invalidateSize();

            var time:int = int(App.utils.dateTime.now().time / 1000);
            if (prevTime != time)
            {
                prevTime = time;
                data = Macros.Format(null, cfg.format.split("{{").join("{{_clock."));
                invalidateData();
            }

            App.utils.scheduler.scheduleTask(tick, 100);
        }
    }
}
