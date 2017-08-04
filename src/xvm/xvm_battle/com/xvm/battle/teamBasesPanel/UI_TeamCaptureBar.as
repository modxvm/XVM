/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.battle.teamBasesPanel
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import flash.text.*;
    import mx.utils.*;

    public dynamic class UI_TeamCaptureBar extends TeamCaptureBarUI
    {
        private static const HIDE_ICONS_HACK_OFFSET_Y:Number = -10000;

        private var DEFAULT_TEXTFIELD_X:Number;
        private var DEFAULT_TEXTFIELD_Y:Number;
        private var DEFAULT_TFVEHICLESCOUNT_X:Number;
        private var DEFAULT_TFVEHICLESCOUNT_Y:Number;
        private var DEFAULT_TFTIMELEFT_X:Number;
        private var DEFAULT_TFTIMELEFT_Y:Number;
        private var DEFAULT_POINTSTEXTFIELD_X:Number;
        private var DEFAULT_POINTSTEXTFIELD_Y:Number;

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

        override public function set y(value:Number):void
        {
            super.y = value - HIDE_ICONS_HACK_OFFSET_Y;
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

        override public function updateCaptureData(points:Number, param2:Boolean, param3:Boolean, param4:Number, timeLeft:String, vehiclesCount:String, title:String):void
        {
            try
            {
                super.updateCaptureData.apply(this, arguments);
                if (!cfg)
                    return;
                m_points = points;
                m_timeLeft = timeLeft;
                m_vehiclesCount = vehiclesCount;
                updateTextFields();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        override public function setCaptured(param1:String):void
        {
            try
            {
                super.setCaptured(param1);
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
                setupTextField(textField, "title", DEFAULT_TEXTFIELD_X, DEFAULT_TEXTFIELD_Y);
                setupTextField(tfVehiclesCount, "timer", DEFAULT_TFVEHICLESCOUNT_X, DEFAULT_TFVEHICLESCOUNT_Y);
                setupTextField(tfTimeLeft, "players", DEFAULT_TFTIMELEFT_X, DEFAULT_TFTIMELEFT_Y);
                //TODO:9.20 setupTextField(pointsTextField, "points", DEFAULT_POINTSTEXTFIELD_X, DEFAULT_POINTSTEXTFIELD_Y);
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
            //TODO:9.20 pointsTextField.x -= 300;
            //TODO:9.20 pointsTextField.width += 600;
            //TODO:9.20 pointsTextField.height = 600;

            // hack to hide useless icons
            textField.y += HIDE_ICONS_HACK_OFFSET_Y;
            tfVehiclesCount.y += HIDE_ICONS_HACK_OFFSET_Y;
            tfTimeLeft.y += HIDE_ICONS_HACK_OFFSET_Y;
            //TODO:9.20 pointsTextField.y += HIDE_ICONS_HACK_OFFSET_Y;
            bg.y += HIDE_ICONS_HACK_OFFSET_Y;
            progressBar.y += HIDE_ICONS_HACK_OFFSET_Y;

            DEFAULT_TEXTFIELD_X = textField.x;
            DEFAULT_TEXTFIELD_Y = textField.y;
            DEFAULT_TFVEHICLESCOUNT_X = tfVehiclesCount.x;
            DEFAULT_TFVEHICLESCOUNT_Y = tfVehiclesCount.y;
            DEFAULT_TFTIMELEFT_X = tfTimeLeft.x;
            DEFAULT_TFTIMELEFT_Y = tfTimeLeft.y;
            //TODO:9.20 DEFAULT_POINTSTEXTFIELD_X = pointsTextField.x;
            //TODO:9.20 DEFAULT_POINTSTEXTFIELD_Y = pointsTextField.y;
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

        private function setupTextField(tf:TextField, name:String, defaultX:Number, defaultY:Number):void
        {
            var c:CCaptureBarTextField = cfg[name];
            //tf.border = true; tf.borderColor = 0xFF0000;
            tf.selectable = false;
            tf.x = defaultX + Macros.FormatNumberGlobal(c.x, 0);
            tf.y = defaultY + Macros.FormatNumberGlobal(c.y, 0);
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
            //TODO:9.20 pointsTextField.htmlText = value;
        }
    }
}
