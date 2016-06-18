// AS3:DONE /**
// AS3:DONE  * Capture progress bar
// AS3:DONE  *
// AS3:DONE  * @author ilitvinov
// AS3:DONE  */
// AS3:DONE import com.xvm.*;
// AS3:DONE import flash.filters.*;
// AS3:DONE import flash.geom.Rectangle;
// AS3:DONE
// AS3:DONE class wot.TeamBasesPanel.CaptureBar
// AS3:DONE {
// AS3:DONE     /////////////////////////////////////////////////////////////////
// AS3:DONE     // wrapped methods
// AS3:DONE
// AS3:DONE     private var wrapper:net.wargaming.ingame.CaptureBar;
// AS3:DONE     private var base:net.wargaming.ingame.CaptureBar;
// AS3:DONE
// AS3:DONE     public function CaptureBar(wrapper:net.wargaming.ingame.CaptureBar, base:net.wargaming.ingame.CaptureBar)
// AS3:DONE     {
// AS3:DONE         this.wrapper = wrapper;
// AS3:DONE         this.base = base;
// AS3:DONE         wrapper.xvm_worker = this;
// AS3:DONE         CaptureBarCtor();
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function updateCaptureData()
// AS3:DONE     {
// AS3:DONE         return this.updateCaptureDataImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function updateTitle()
// AS3:DONE     {
// AS3:DONE         return this.updateTitleImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     function configUI()
// AS3:DONE     {
// AS3:DONE         return this.configUIImpl.apply(this, arguments);
// AS3:DONE     }
// AS3:DONE
// AS3:DONE     // wrapped methods
// AS3:DONE     /////////////////////////////////////////////////////////////////
// AS3:DONE
// AS3:DONE     private var cfg:Object;
// AS3:DONE     private var m_captured:Boolean;
// AS3:DONE     private var m_baseNumText:String = "";
// AS3:DONE 
// AS3:DONE     public function CaptureBarCtor()
// AS3:DONE     {
// AS3:DONE         //Logger.add("CaptureBar");
// AS3:DONE 
// AS3:DONE         cfg = Config.config.captureBar[type];
// AS3:DONE 
// AS3:DONE         // Colorize capture bar
// AS3:DONE         var color = cfg.color;
// AS3:DONE 
// AS3:DONE         //Logger.add("c: " + color);
// AS3:DONE 
// AS3:DONE         if (color != null && !isNaN(color))
// AS3:DONE             color = parseInt(color);
// AS3:DONE 
// AS3:DONE         if (color == null || isNaN(color))
// AS3:DONE         {
// AS3:DONE             color = Config.config.markers.useStandardMarkers
// AS3:DONE                 ? net.wargaming.managers.ColorSchemeManager.instance.getRGB("vm_" + type)
// AS3:DONE                 : ColorsManager.getSystemColor(type, false);
// AS3:DONE         }
// AS3:DONE 
// AS3:DONE         GraphicsUtil.colorize(wrapper.m_bgMC, color, 1);
// AS3:DONE         GraphicsUtil.colorize(wrapper.captureProgress.m_barMC, color, 1);
// AS3:DONE 
// AS3:DONE         if (!Config.config.captureBar.enabled)
// AS3:DONE         {
// AS3:DONE             wrapper.m_playersTF._x -= 50;
// AS3:DONE             wrapper.m_playersTF._width += 50;
// AS3:DONE             wrapper.m_timerTF._x -= 20;
// AS3:DONE             wrapper.m_timerTF._width += 50;
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             // align: center
// AS3:DONE             wrapper.m_titleTF._x -= 300;
// AS3:DONE             wrapper.m_titleTF._width += 600;
// AS3:DONE             wrapper.m_titleTF._height = 600;
// AS3:DONE             setupTextField(wrapper.m_titleTF, "title");
// AS3:DONE 
// AS3:DONE             // align: right
// AS3:DONE             wrapper.m_playersTF._x -= 200 - 271;
// AS3:DONE             wrapper.m_playersTF._width += 200;
// AS3:DONE             wrapper.m_playersTF._height = 600;
// AS3:DONE             setupTextField(wrapper.m_playersTF, "timer");
// AS3:DONE 
// AS3:DONE             // align: left
// AS3:DONE             wrapper.m_timerTF._x -= 20 + 265;
// AS3:DONE             wrapper.m_timerTF._width += 200;
// AS3:DONE             wrapper.m_timerTF._height = 600;
// AS3:DONE             setupTextField(wrapper.m_timerTF, "players");
// AS3:DONE 
// AS3:DONE             // align: center
// AS3:DONE             wrapper.m_pointsTF._x -= 300;
// AS3:DONE             wrapper.m_pointsTF._width += 600;
// AS3:DONE             wrapper.m_pointsTF._height = 600;
// AS3:DONE             setupTextField(wrapper.m_pointsTF, "points");
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // override
// AS3:DONE     public function configUIImpl()
// AS3:DONE     {
// AS3:DONE         //Logger.add("CaptureBar.configUI");
// AS3:DONE 
// AS3:DONE         base.configUI();
// AS3:DONE 
// AS3:DONE         if (!Config.config.captureBar.enabled)
// AS3:DONE         {
// AS3:DONE             wrapper.m_playersTF.htmlText = "<font size='15' face='xvm'>&#x113;</font>  " + wrapper.m_vehiclesCount;
// AS3:DONE             wrapper.m_timerTF.htmlText = "<font size='15' face='xvm'>&#x114;</font>  " + wrapper.m_timeLeft;
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             var showProgressBar:Boolean = !Macros.FormatGlobalBooleanValue(Config.config.captureBar.hideProgressBar, false);
// AS3:DONE             wrapper.m_bgMC._visible = showProgressBar;
// AS3:DONE             wrapper.barColors._visible = showProgressBar;
// AS3:DONE 
// AS3:DONE             m_baseNumText = DAAPI.py_xvm_captureBarGetBaseNumText(wrapper.id);
// AS3:DONE             updateTextFields();
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // override
// AS3:DONE     public function updateCaptureDataImpl(points, rate, timeLeft, vehiclesCount)
// AS3:DONE     {
// AS3:DONE         //Logger.add("CaptureBar.updateCaptureData: " + arguments);
// AS3:DONE 
// AS3:DONE         base.updateCaptureData(points, rate, timeLeft, vehiclesCount);
// AS3:DONE 
// AS3:DONE         if (!Config.config.captureBar.enabled)
// AS3:DONE         {
// AS3:DONE             wrapper.m_playersTF.htmlText = "<font size='15' face='xvm'>&#x113;</font>  " + wrapper.m_vehiclesCount;
// AS3:DONE             wrapper.m_timerTF.htmlText = "<font size='15' face='xvm'>&#x114;</font>  " + wrapper.m_timeLeft;
// AS3:DONE         }
// AS3:DONE         else
// AS3:DONE         {
// AS3:DONE             updateTextFields();
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // override
// AS3:DONE     public function updateTitleImpl()
// AS3:DONE     {
// AS3:DONE         //Logger.add("CaptureBar.updateTitle: " + arguments);
// AS3:DONE 
// AS3:DONE         base.updateTitle.apply(base, arguments);
// AS3:DONE 
// AS3:DONE         if (Config.config.captureBar.enabled)
// AS3:DONE         {
// AS3:DONE             m_captured = true;
// AS3:DONE             updateTextFields();
// AS3:DONE         }
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     // PRIVATE
// AS3:DONE 
// AS3:DONE     private function get type():String
// AS3:DONE     {
// AS3:DONE         return wrapper.m_colorFeature == "green" ? "ally" : "enemy";
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function setupTextField(tf:TextField, name:String):Void
// AS3:DONE     {
// AS3:DONE         var c = cfg[name];
// AS3:DONE         //tf.border = true; tf.borderColor = 0xFF0000;
// AS3:DONE         tf.selectable = false;
// AS3:DONE         tf._x += Macros.FormatGlobalNumberValue(c.x, 0);
// AS3:DONE         tf._y += Macros.FormatGlobalNumberValue(c.y, 0);
// AS3:DONE         tf.filters = [new DropShadowFilter(
// AS3:DONE             0, // distance
// AS3:DONE             0, // angle
// AS3:DONE             Macros.FormatGlobalNumberValue(c.shadow.color, 0x000000),
// AS3:DONE             Macros.FormatGlobalNumberValue(c.shadow.alpha, 100) / 100.0,
// AS3:DONE             Macros.FormatGlobalNumberValue(c.shadow.blur, 1),
// AS3:DONE             Macros.FormatGlobalNumberValue(c.shadow.blur, 1),
// AS3:DONE             Macros.FormatGlobalNumberValue(c.shadow.strength, 1))];
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private function updateTextFields():Void
// AS3:DONE     {
// AS3:DONE         var o = {
// AS3:DONE             points: wrapper.m_points,
// AS3:DONE             vehiclesCount: wrapper.m_vehiclesCount,
// AS3:DONE             timeLeft: wrapper.m_timeLeft,
// AS3:DONE             timeLeftSec: Utils.timeStrToSec(wrapper.m_timeLeft)
// AS3:DONE         };
// AS3:DONE 
// AS3:DONE         var value:String;
// AS3:DONE         var name = m_captured ? "done" : "format";
// AS3:DONE 
// AS3:DONE         value = Macros.Format(null, cfg.title[name], o);
// AS3:DONE         value = Strings.substitute(value, [ m_baseNumText ]);
// AS3:DONE         wrapper.m_titleTF.htmlText = value;
// AS3:DONE 
// AS3:DONE         value = Macros.Format(null, cfg.players[name], o);
// AS3:DONE         value = Strings.substitute(value, [ m_baseNumText ]);
// AS3:DONE         wrapper.m_timerTF.htmlText = value;
// AS3:DONE 
// AS3:DONE         value = Macros.Format(null, cfg.timer[name], o);
// AS3:DONE         value = Strings.substitute(value, [ m_baseNumText ]);
// AS3:DONE         wrapper.m_playersTF.htmlText = value;
// AS3:DONE 
// AS3:DONE         value = Macros.Format(null, cfg.points[name], o);
// AS3:DONE         value = Strings.substitute(value, [ m_baseNumText ]);
// AS3:DONE         wrapper.m_pointsTF.htmlText = value;
// AS3:DONE     }
// AS3:DONE }
