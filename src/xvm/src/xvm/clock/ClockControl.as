/**
 * XVM - clock control
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.clock
{
    import com.xfw.*;
    import com.xfw.types.cfg.*;
    import com.xfw.utils.*;
    import flash.display.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    import net.wg.gui.events.*;
    import scaleform.clik.constants.*;
    import scaleform.gfx.*;

    public class ClockControl extends LabelControl
    {
        private var cfg:CClock;

        private var prevWidth:Number = 0;
        private var prevHeight:Number = 0;
        private var prevTime:int = 0;
        private var data:String = "";

        private var intervalId:uint = 0;

        public function ClockControl(cfg:CClock)
        {
            this.cfg = cfg;
            Macros.RegisterClockMacros();
        }

        override protected function configUI():void
        {
            super.configUI();

            this.visible = true;
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
            if (cfg.bgImage != null)
                createBackgroundImage(cfg.bgImage);
            textField.rotation = cfg.rotation;
            if (cfg.shadow.enabled)
                textField.filters = [ WGUtils.createShadowFilter(cfg.shadow) ];

            invalidate();

            if (intervalId)
                clearInterval(intervalId);
            intervalId = setInterval(tick, 100);
        }

        override protected function onDispose():void
        {
            if (intervalId)
            {
                clearInterval(intervalId);
                intervalId = 0;
            }

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

        private function createBackgroundImage(src:String):void
        {
            // wild coding style :)
            this.addChildAt(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                source: "../../" + Utils.fixImgTag(src).replace("img://", "")
            }), 0).addEventListener(UILoaderEvent.COMPLETE, function(e:UILoaderEvent):void {
                var img:UILoaderAlt = e.currentTarget as UILoaderAlt;
                var loader:Loader = img.getChildAt(1) as Loader;
                img.width = loader.contentLoaderInfo.content.width / scaleX;
                img.height = loader.contentLoaderInfo.content.height / scaleY;
            });
        }

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
            try
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
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
