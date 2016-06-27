/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.text.*;
    import flash.filters.*;
    import mx.utils.*;

    public dynamic class UI_TeamCaptureBar extends TeamCaptureBarUI
    {
        private var cfg:CCaptureBarTeam;
        private var m_captured:Boolean;
        private var m_baseNumText:String = "";

        private var m_points:Number;
        private var m_vehiclesCount:String;
        private var m_timeLeft:String

        public function UI_TeamCaptureBar()
        {
            //Logger.add("UI_TeamCaptureBar()");
            super();

            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);

            initTextFields();
        }

        override public function setData(param1:Number, param2:Number, param3:String, param4:String, param5:Number, param6:String, param7:String):void
        {
            try
            {
                cfg = null;
                super.setData.apply(this, arguments);
                onConfigLoaded(null);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function updateCaptureData(points:Number, param2:Boolean, param3:Boolean, param4:Number, timeLeft:String, vehiclesCount:String):void
        {
            try
            {
                super.updateCaptureData.apply(this, arguments);
                if (!cfg)
                    return;
                m_points = points;
                m_timeLeft = timeLeft;
                m_vehiclesCount = vehiclesCount;
                // TODO: convert from AS2
                /*
                if (!Config.config.captureBar.enabled)
                {
                    wrapper.m_playersTF.htmlText = "<font size='15' face='xvm'>&#x113;</font>  " + wrapper.m_vehiclesCount;
                    wrapper.m_timerTF.htmlText = "<font size='15' face='xvm'>&#x114;</font>  " + wrapper.m_timeLeft;
                }
                */
                updateTextFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function updateTitle(param1:String):void
        {
            try
            {
                super.updateTitle(param1);
                if (!cfg)
                    return;
                m_captured = true;
                updateTextFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function get team():String
        {
            return colorType == "green" ? "ally" : "enemy";
        }

        private function onConfigLoaded(e:Event):Object
        {
            try
            {
                cfg = Config.config.captureBar[team];
                setupCaptureBarColor();
                setupTextField(textField, "title");
                setupTextField(tfVehiclesCount, "timer");
                setupTextField(tfTimeLeft, "players");
                setupTextField(pointsTextField, "points");
                setupProgressBar();
                m_baseNumText = Xfw.cmd(BattleCommands.CAPTURE_BAR_GET_BASE_NUM_TEXT, id);
                updateTextFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function initTextFields():void
        {
            // align: center
            textField.x -= 300;
            textField.width += 600;
            textField.height = 600;
            // align: right
            tfVehiclesCount.x -= 200 - 271;
            tfVehiclesCount.width += 200;
            tfVehiclesCount.height = 600;
            // align: left
            tfTimeLeft.x -= 20 + 265;
            tfTimeLeft.width += 200;
            tfTimeLeft.height = 600;
            // align: center
            pointsTextField.x -= 300;
            pointsTextField.width += 600;
            pointsTextField.height = 600;

            // hack to hide useless icons
            y -= 1000;
            textField.y += 1000;
            tfVehiclesCount.y += 1000;
            tfTimeLeft.y += 1000;
            pointsTextField.y += 1000;
            bg.y += 1000;
            progressBar.y += 1000;
        }

        private function setupCaptureBarColor():void
        {
            // TODO: convert from AS2
            /*
            var color:* = cfg.color;

            //Logger.add("c: " + color);

            if (color != null && !isNaN(color))
                color = parseInt(color);

            if (color == null || isNaN(color))
            {
                color = !Config.config.markers.enabled
                    ? net.wargaming.managers.ColorSchemeManager.instance.getRGB("vm_" + type)
                    : ColorsManager.getSystemColor(type, false);
            }

            GraphicsUtil.colorize(wrapper.m_bgMC, color, 1);
            GraphicsUtil.colorize(wrapper.captureProgress.m_barMC, color, 1);
            */
        }

        private function setupTextField(tf:TextField, name:String):void
        {
            var c:CCaptureBarTextField = cfg[name];
            //tf.border = true; tf.borderColor = 0xFF0000;
            tf.selectable = false;
            tf.x += Macros.FormatNumberGlobal(c.x, 0);
            tf.y += Macros.FormatNumberGlobal(c.y, 0);
            tf.filters = Utils.createShadowFiltersFromConfig(c.shadow);
        }

        private function setupProgressBar():void
        {
            var showProgressBar:Boolean = !Macros.FormatBooleanGlobal(Config.config.captureBar.hideProgressBar, false);
            bg.visible = showProgressBar;
            progressBar.visible = showProgressBar;
        }

        private function updateTextFields():void
        {
            if (!cfg)
                return;

            BattleState.captureBarDataVO.update({
                points: m_points,
                vehiclesCount: m_vehiclesCount,
                timeLeft: m_timeLeft,
                timeLeftSec: m_timeLeft ? Utils.timeStrToSec(m_timeLeft) : -1
            });

            var value:String;
            var name:String = m_captured ? "done" : "format";

            value = Macros.FormatStringGlobal(cfg.title[name]);
            value = StringUtil.substitute(value, m_baseNumText);
            textField.htmlText = value;

            value = Macros.FormatStringGlobal(cfg.players[name]);
            value = StringUtil.substitute(value, m_baseNumText);
            tfTimeLeft.htmlText = value;

            value = Macros.FormatStringGlobal(cfg.timer[name]);
            value = StringUtil.substitute(value, m_baseNumText);
            tfVehiclesCount.htmlText = value;

            value = Macros.FormatStringGlobal(cfg.points[name]);
            value = StringUtil.substitute(value, m_baseNumText);
            pointsTextField.htmlText = value;
        }
    }
}
