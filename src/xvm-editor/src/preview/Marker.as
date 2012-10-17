package preview
{
    import flash.display.MovieClip;
    import flash.events.Event;
    
    import mx.core.UIComponent;
    
    import preview.*;
    
    import utils.*;

    public class Marker extends UIComponent
    {
        public var xvm:Xvm;
        private var isInitialized:Boolean = false;

        public var vehicleIcon:MovieClip;
        private var vehicleIconAlly:MovieClip;
        private var vehicleIconEnemy:MovieClip;
        public var levelIcon:MovieClip;
        private var actionMarkerHelp:MovieClip;
        private var actionMarkerVictim:MovieClip;
        private var actionMarkerArta:MovieClip;

        private var _zoom:Number = 1;
        private var _extmode:Boolean = false;
        private var _actionMarkerVisible:Boolean = true;

        /*

        private var _cfg: Object;

        private var textFields: Array = [];
*/

        public function Marker()
        {
            // Create marker
            xvm = new Xvm(this);
        }

        public function init(vtype:String, vclass:String, vlevel:Number):void
        {
            // draw grid
            graphics.beginFill(0xFFFF00, 0.1);
            graphics.drawRect(-75, 0, 150, 1);
            graphics.endFill();
            graphics.beginFill(0xFFFF00, 0.1);
            graphics.drawRect(0, -75, 1, 150);
            graphics.endFill();

            var entity:String = vtype == "ally" || vtype == "ally_dead" ? "ally" : "enemy";
            xvm.init(vclass, null, vtype, vlevel, '___Player___[CLAN]', 100, 100, entity, false, false, entity); 

            loadSWF(Resources.markersSWF);
        }

        private var loader:ClassLoader;
        private function loadSWF(swf_class:Class):void
        {
            loader = new ClassLoader();
            loader.addEventListener(ClassLoader.LOAD_ERROR,loadErrorHandler);
            loader.addEventListener(ClassLoader.CLASS_LOADED,classLoadedHandler);
            loader.load(swf_class);
        }

        private function loadErrorHandler(e:Event):void {
            throw new Error("Cannot load the specified file.");
        }

        private function classLoadedHandler(e:Event):void
        {
            vehicleIconAlly = CreateMC("markerAlly");
            vehicleIconEnemy = CreateMC("markerEnemy");
            levelIcon = CreateMC("level");
            actionMarkerHelp = CreateMC("actionHelp");
            actionMarkerVictim = CreateMC("actionVictim");
            actionMarkerArta = CreateMC("actionArta");

            addEventListener(Event.ENTER_FRAME, PostInit);
        }

        private function CreateMC(className: String):MovieClip
        {
            var mc:MovieClip = className != null ? new (loader.getClass(className))() as MovieClip : new MovieClip();
            var dow:DisplayObjectWrapper = new DisplayObjectWrapper(mc);
            dow.content.visible = false;
            addChild(dow);
            return mc;
        }

        private function PostInit(event: Event):void
        {
            removeEventListener(Event.ENTER_FRAME, PostInit);

            vehicleIconAlly.marker.icon.gotoAndStop(xvm.vehicleTypeComponent.getVehicleClass());
            vehicleIconAlly.gotoAndPlay(xvm.m_isDead == false ? "normal" : "immediate_dead");
            vehicleIconAlly.marker.scaleX = vehicleIconAlly.marker.scaleY = _zoom;
            vehicleIconAlly.visible = false;

            vehicleIconEnemy.marker.icon.gotoAndStop(xvm.vehicleTypeComponent.getVehicleClass());
            vehicleIconEnemy.gotoAndPlay(xvm.m_isDead == false ? "normal" : "immediate_dead");
            vehicleIconEnemy.marker.scaleX = vehicleIconEnemy.marker.scaleY = _zoom;
            vehicleIconEnemy.visible = false;

            vehicleIcon = xvm.m_entityType == "ally" ? vehicleIconAlly : vehicleIconEnemy;

            actionMarkerHelp.stop();
            actionMarkerHelp.visible = false;
            actionMarkerVictim.stop();
            actionMarkerVictim.visible = false;
            actionMarkerArta.stop();
            actionMarkerArta.visible = false;

            levelIcon.gotoAndStop(xvm.m_level);
            levelIcon.visible = false;

            isInitialized = true;

            update();
        }

        public function action():void
        {
            var mc:MovieClip;
            if (xvm.m_entityType == "ally")
                mc = actionMarkerHelp;
            else
                mc = Math.round(Math.random()) == 0 ? actionMarkerVictim : actionMarkerArta;
            actionMarkerHelp.stop();
            actionMarkerHelp.visible = false;
            actionMarkerVictim.stop();
            actionMarkerVictim.visible = false;
            actionMarkerArta.stop();
            actionMarkerArta.visible = false;
            mc.visible = _actionMarkerVisible;
            mc.gotoAndPlay(0);
        }

        public function update():void
        {
            if (!isInitialized)
                return;
            if (!Config.s_config || !Config.s_config.markers)
                return;

            var cfg:Object = Config.s_config.markers;
            cfg = xvm.m_entityType == "ally" ? cfg.ally : cfg.enemy;
            cfg = xvm.m_isDead == false ? cfg.alive : cfg.dead;
            cfg = _extmode ? cfg.extended : cfg.normal;
//            _cfg = cfg;

            var c:Object;
            
            // actionMarker
            c = cfg.actionMarker;
            _actionMarkerVisible = c.visible;
            if (actionMarkerHelp.isPlaying)
                actionMarkerHelp.visible = _actionMarkerVisible;
            if (actionMarkerVictim.isPlaying)
                actionMarkerVictim.visible = _actionMarkerVisible;
            if (actionMarkerArta.isPlaying)
                actionMarkerArta.visible = _actionMarkerVisible;
            actionMarkerHelp.x = actionMarkerVictim.x = actionMarkerArta.x = c.x;
            actionMarkerHelp.y = actionMarkerVictim.y = actionMarkerArta.y = c.y;
            actionMarkerHelp.alpha = actionMarkerVictim.alpha = actionMarkerArta.alpha = c.alpha / 100;

            xvm.update();
                /*                        var c:Object;

            // vehicleIcon
            c = cfg.vehicleIcon;
            vehicleIcon.visible = c.visible || c.showSpeaker;
            vehicleIcon.marker.icon.gotoAndStop(c.visible ? vehicleClass : "dynamic");
            vehicleIcon.x = c.x;
            vehicleIcon.y = c.y;
            vehicleIcon.marker.alpha = XVMFormatDynamicAlpha(c.alpha, m_curHealth) / 100;
            vehicleIcon.marker.icon.x = c.scaleX * c.maxScale / 100;
            vehicleIcon.marker.icon.y = c.scaleY * c.maxScale / 100;
            vehicleIcon.marker.icon.scaleX = vehicleIcon.marker.icon.scaleY = c.maxScale / 100;

            // damageText
            c = cfg.damageText;
            damageHolder.visible = c.visible;
            damageHolder.x = c.x;
            damageHolder.y = c.y;

            // contourIcon
            c = cfg.contourIcon;
            contourIconHolder.visible = c.visible;
            contourIcon.x = c.x - contourIcon.width / 2.0;
            contourIcon.y = c.y - contourIcon.height / 2.0;
            var tintColor: Number = XVMFormatDynamicColor(XVMFormatStaticColorText(c.color), m_curHealth);
            var tintAmount: Number = Math.min(100, Math.max(0, c.amount)) * 0.01;
            GraphicsUtil.setColor(contourIcon, tintColor, tintAmount);
            contourIconHolder.alpha = XVMFormatDynamicAlpha(c.alpha, m_curHealth) / 100;

            // clanIcon
            c = cfg.clanIcon;
            clanIcon.visible = c.visible;
            clanIcon.x = c.x - c.w / 2.0;
            clanIcon.y = c.y - c.h / 2.0;
            clanIcon.width = c.w;
            clanIcon.height = c.h;
            clanIcon.alpha = XVMFormatDynamicAlpha(c.alpha, m_curHealth) / 100;

            // levelIcon
            c = cfg.levelIcon;
            levelIcon.visible = c.visible;
            levelIcon.x = c.x;
            levelIcon.y = c.y;
            levelIcon.alpha = XVMFormatDynamicAlpha(c.alpha, m_curHealth) / 100;

            // Update HB
            XVMUpdateHealthBar(m_curHealth);
            // Update Text Fields
            XVMUpdateUI(m_curHealth);
*/
        }

        public function hit():void
        {
            var blowup:Boolean = Math.round(Math.random() * 5) == 0;
            var hp:Number = blowup ? -1 : xvm.m_curHealth - Math.min(xvm.m_curHealth, Math.round(Math.random() * 500) + 5);
            if (xvm.m_curHealth <= 0)
                hp = xvm.m_maxHealth;
            xvm.updateHealth(hp, xvm.m_entityType == "ally" ? Defines.FROM_ENEMY : Defines.FROM_ALLY, "attack");
        }

        public function set deadType(value:Boolean):void
        {
            xvm.m_entityType = xvm.m_entityName = value == true ? "enemy" : "ally";
            vehicleIcon.visible = false;
            vehicleIcon = value == true ? vehicleIconEnemy : vehicleIconAlly;
            vehicleIcon.marker.scaleX = vehicleIcon.marker.scaleY = _zoom;
            xvm.clanIconComponent.m_clanIcon.source = value ? new Resources.IMG_clan2() : new Resources.IMG_clan1();
            update();
        }

        public function set extMode(value:Boolean):void
        {
            this._extmode = value;
            update();
        }

        public function set maxHP(value:Number):void
        {
            xvm.m_maxHealth = xvm.m_curHealth = value;
            update();
        }

        public function set zoom(value:Number):void
        {
            this._zoom = value;
            if (vehicleIcon)
                vehicleIcon.marker.scaleX = vehicleIcon.marker.scaleY = value;
        }

        /*
        // Damage Visualization
        private function removeTextField(f: TextField):void
        {
            damageHolder.removeChild(f);
        }

        private function XVMShowDamage(curHealth:Number, delta:Number):void
        {
            var cfg:Object = Config.s_config.markers;
            cfg = xvm.m_entityType == "ally" ? cfg.ally : cfg.enemy;
            cfg = curHealth > 0 ? cfg.alive : cfg.dead;
            cfg = _extmode ? cfg.extended : cfg.normal;

            cfg = cfg.damageText;

            if (!cfg.visible)
                return;

            var msg:String = (curHealth < 0) ? cfg.blowupMessage : cfg.damageMessage;
            var text:String = XVMFormatDynamicText(XVMFormatStaticText(msg), curHealth, delta);

            var damageField: TextField = new TextField();
            damageHolder.addChild(damageField);

            damageField.width = 140;
            damageField.height = 20;

            damageField.text = " " + text + " ";
            damageField.antiAliasType = AntiAliasType.ADVANCED;
            damageField.border = false;
            damageField.embedFonts = cfg.font.name == "$FieldFont";
            damageField.defaultTextFormat = XVMCreateNewTextFormat(cfg.font);
            damageField.text = " " + text + " ";
            damageField.textColor = !isNaN(parseInt(cfg.color)) ? int(cfg.color)
                : Config.s_config.colors.system[xvm.m_entityType + "_alive_" + (s_isColorBlindMode ? "blind" : "normal")];
            damageField.x = -(damageField.width / 2.0);

            if (cfg.shadow)
            {
                var sh_color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = XVMFormatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                damageField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            var st:Number = (new Date()).time;
            var timer:Timer = new Timer(10);
            var timerFunc:Function = function():void {
                var d:Number = (new Date()).time - st;
                if (d > cfg.speed * 1000)
                {
                    damageHolder.removeChild(damageField);
                    timer.stop();
                    timer.removeEventListener(TimerEvent.TIMER, timerFunc);
                    timer = null;
                    timerFunc = null;
                    return;
                }
                damageField.y = cfg.maxRange * (cfg.speed * 1000 - d) / (cfg.speed * 1000) - cfg.maxRange;
            };
            timer.addEventListener(TimerEvent.TIMER, timerFunc);
            timer.start();
        }

        // Health Visualization
        private var dmgTimer:Timer = new Timer(10);
        private var dmgTimerFunc:Function = null;
        private function XVMSetupNewHealth(curHealth:Number):void
        {
            dmgTimer.stop();
            if (dmgTimerFunc != null)
            {
                dmgTimer.removeEventListener(TimerEvent.TIMER, dmgTimerFunc);
                dmgTimerFunc = null;
            }

            XVMUpdateHealthBar(curHealth); // colorizing health bar after taking damage

            var delta: Number = curHealth - m_curHealth;
            if (delta >= 0)
            {
                m_curHealth = curHealth;
                xvmHBDamage.graphics.clear();
                return;
            }

            XVMShowDamage(curHealth, -delta);

            m_curHealth = curHealth;

            //Flow bar animation
            var cfg:Object = _cfg.healthBar;
            if (cfg.damage.fade > 0)
            {
                var fade:Number = cfg.damage.fade * 1000;
                var color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.damage.color), curHealth);
                var alpha:Number = XVMFormatDynamicAlpha(cfg.damage.alpha, curHealth) / 100;
                var st:Number = (new Date()).time;
                var drawing: Boolean = false;
                dmgTimerFunc = function():void
                {
                    if (drawing)
                        return;
                    drawing = true;
                    var d:Number = (new Date()).time - st;
                    var w:Number = cfg.width * (-delta / m_maxHealth) * (fade - d) / fade;
                    xvmHBDamage.graphics.clear();
                    if (w <= 0)
                    {
                        dmgTimer.stop();
                        dmgTimer.removeEventListener(TimerEvent.TIMER, dmgTimerFunc);
                        dmgTimerFunc = null;
                        return;
                    }
                    xvmHBDamage.graphics.beginFill(color, alpha);
                    xvmHBDamage.graphics.drawRect(
                        cfg.border.size + cfg.width * (1.0 * curHealth / m_maxHealth) - 1, cfg.border.size,
                        w, cfg.height);
                    xvmHBDamage.graphics.endFill();
                    drawing = false;
                };
                dmgTimer.addEventListener(TimerEvent.TIMER, dmgTimerFunc);
                dmgTimer.start();
            }
        }

        private function XVMUpdateUI(curHealth:Number):void
        {
            xvmHBFill.scaleX = Math.min(curHealth / m_maxHealth * 100, 100) / 100;

            while (textFields.length > 0)
                removeChild(textFields.pop());

            textFields = [];
            for (var i:String in _cfg.textFields)
            {
                var cfg:Object = _cfg.textFields[i];
                if (cfg.visible)
                {
                    var tf:TextField = XVMCreateTextField(cfg);
                    tf.text = XVMFormatDynamicText(XVMFormatStaticText(cfg.format), curHealth);
                    tf.textColor = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.color), curHealth);
                    tf.alpha = XVMFormatDynamicAlpha(cfg.alpha, curHealth) / 100;
                    addChild(tf);
                    textFields.push(tf);
                }
            }
        }

        private function XVMUpdateHealthBar(curHealth:Number):void
        {
            var cfg:Object = _cfg.healthBar;

            xvmHB.alpha = XVMFormatDynamicAlpha(cfg.alpha, curHealth) / 100;

            var fullColor: Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.color), curHealth);
            var lowColor: Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.lcolor || cfg.color), curHealth);

            var percent: Number = curHealth / m_maxHealth;

            // determ current (real-time) color
            var currColor:Number = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);
        }

        private function XVMFormatDynamicAlpha(format: String, curHealth: Number): Number
        {
            if (!format || format == "0")
                return 100;

            if (!isNaN(parseInt(format)))
                return int(format);

            var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
            var formatArr:Array = format.split("{{a:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, curHealth).toString());
            formatArr = format.split("{{a:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hpRatio).toString());
            formatArr = format.split("{{a:hp_ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hpRatio).toString());

            var n:Number = !isNaN(parseInt(format)) ? int(format) : 100;
            return (n <= 0) ? 1 : (n > 100) ? 100 : n;
        }

        private function get pname():String
        {
            return "Player" + (xvm.m_entityType == "ally" ? "Ally" : "Enemy");
        }

        private const rlevel:Array = [ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" ];
        private function XVMFormatStaticText(format: String): String
        {
            // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
            format = format.split("{{nick}}").join(pname);
            format = format.split("{{vehicle}}").join(_vdead ? "Hummel" : xvm.m_entityType == "ally" ? "ИС-3" : "Ferdinand");
            var level:int = _vdead ? 5 : 8;
            format = format.split("{{level}}").join(String(level));
            format = format.split("{{rlevel}}").join(rlevel[level - 1]);
            format = format.split("{{turret}}").join(Config.s_config.turretMarkers.highVulnerability);

            format = format.split("{{kb}}").join("4k");
            format = format.split("{{battles}}").join("4321");
            format = format.split("{{wins}}").join("3210");
            format = format.split("{{rating}}").join("48%");
            format = format.split("{{eff}}").join("1234");

            format = format.split("{{t-kb}}").join("1k");
            format = format.split("{{t-kb-0}}").join("1.1k");
            format = format.split("{{t-hb}}").join("12h");
            format = format.split("{{t-battles}}").join("1234");
            format = format.split("{{t-wins}}").join("1000");
            format = format.split("{{t-rating}}").join("54%");

            // This code is stupid, and needs to be rewritten
            format = format.split("{{kb:3}}").join(" 4k");
            format = format.split("{{rating:3}}").join("48%");
            format = format.split("{{eff:4}}").join("1234");

            format = format.split("{{t-kb:4}}").join("  1k");
            format = format.split("{{t_kb:4}}").join("  1k");
            format = format.split("{{t-hb:3}}").join("12h");
            format = format.split("{{t_hb:3}}").join("12h");
            format = format.split("{{t-battles:4}}").join("1234");
            format = format.split("{{t_battles:4}}").join("1234");
            format = format.split("{{t-rating:3}}").join("54%");
            format = format.split("{{t_rating:3}}").join("54%");

            return format;
        }

        private function XVMFormatDynamicText(format: String, curHealth: Number, delta: Number = 0): String
        {
            if (format.indexOf("{{") == -1)
                return format;

            var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
            format = format.split("{{hp}}").join(String(curHealth));
            format = format.split("{{hp-max}}").join(String(m_maxHealth));
            format = format.split("{{hp-ratio}}").join(String(hpRatio));

            var dmgRatio: Number = delta ? Math.ceil(delta / m_maxHealth * 100) : 0;
            format = format.split("{{dmg}}").join(delta ? String(delta) : "");
            format = format.split("{{dmg-ratio}}").join(delta ? String(dmgRatio) : "");
            format = format.split("{{dmg-kind}}").join(delta ? String("attack") : "");

            return format;
        }

        private function XVMCreateNewTextFormat(config_font: Object): TextFormat
        {
            var name:String = config_font.name || "$FieldFont";
            if (name == "$TextFont")
                name = "Tahoma";
            return new TextFormat(
                name,
                config_font.size || 13,
                0x000000,
                config_font.bold,
                config_font.italic,
                false, null, null,
                config_font.align || "center",
                0, 0, 0, 0);
        }

        private function XVMCreateTextField(cfg:Object):TextField
        {
            var textField: TextField = new TextField();
            textField.width = 140;
            textField.height = 30;
            //textField.height = cfg.font.size + 4;

            textField.selectable = false;
            textField.multiline = false;
            textField.wordWrap = false;
            //textField.antiAliasType = AntiAliasType.ADVANCED;
            //textField.gridFitType = GridFitType.SUBPIXEL;
            //textField.border = true;
            //textField.borderColor = 0xFFFFFF;
            textField.embedFonts = !cfg.font.name || cfg.font.name == "$FieldFont";
            textField.defaultTextFormat = XVMCreateNewTextFormat(cfg.font);

            if (cfg.shadow)
            {
                var sh_color:Number = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.shadow.color), m_curHealth);
                var sh_alpha:Number = XVMFormatDynamicAlpha(cfg.shadow.alpha, m_curHealth);
                textField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow.distance,
                    cfg.shadow.angle, sh_color, sh_alpha, cfg.shadow.size, cfg.shadow.strength) ];
            }

            textField.textColor = XVMFormatDynamicColor(XVMFormatStaticColorText(cfg.color), m_curHealth);
            textField.alpha = XVMFormatDynamicAlpha(cfg.alpha, m_curHealth) / 100;
            textField.x = cfg.x - (textField.width / 2.0);
            textField.y = cfg.y - (textField.height / 2.0);
            if (cfg.font.name != "$FieldFont")
                textField.y--; // -1 to be equal with ScaleForm renderer

            textField.visible = cfg.visible;

            return textField;
        }

        private function XVMFormatDynamicColor(format: String, curHealth: Number): Number
        {
            var systemColorName: String = xvm.m_entityType + "_";
            systemColorName += !_vdead ? "alive_" : m_curHealth < 0 ? "blowedup_" : "dead_";
            systemColorName += s_isColorBlindMode ? "blind" : "normal";
            var systemColor:Number = Config.s_config.colors.system[systemColorName];

            if (!format)
                return systemColor;

            if (!isNaN(parseInt(format)))
                return int(format);

            var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
            var formatArr:Array = format.split("{{c:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, curHealth, "0x"));
            formatArr = format.split("{{c:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"));
            formatArr = format.split("{{c:hp_ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio, "0x"));
            formatArr = format.split("{{c:dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(Config.s_config.colors.dmg_kind.attack);
            formatArr = format.split("{{c:dmg_kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(Config.s_config.colors.dmg_kind.attack);
            formatArr = format.split("{{c:vtype}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetVTypeColorValue(Utils.vehicleClassToVehicleType(vehicleClass), "0x"));
            return !isNaN(parseInt(format)) ? int(format) : systemColor;
        }

        private function XVMFormatStaticColorText(format: String): String
        {
            if (!format || !isNaN(parseInt(format)))
                return format;

            // Dynamic colors
            format = format.split("{{c:eff}}").join(
                GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, 1234, "#", _vdead));
            format = format.split("{{c:rating}}").join(
                GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 48, "#", _vdead));
            format = format.split("{{c:kb}}").join(
                GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_KB, 1, "#", _vdead));
            format = format.split("{{c:t-rating}}").join(
                GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 54, "#", _vdead));
            format = format.split("{{c:t_rating}}").join(
                GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, 54, "#", _vdead));
            format = format.split("{{c:t-battles}}").join(
                GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, 1234, "#", _vdead));
            format = format.split("{{c:t_battles}}").join(
                GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, 1234, "#", _vdead));

            return format;
        }*/
    }
}
