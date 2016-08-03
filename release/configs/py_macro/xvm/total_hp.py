import xvm_main.python.config as config
import xvm_battle.python.fragCorrelationPanel as panel

def ally():
    return panel.teams_totalhp[0]

def enemy():
    return panel.teams_totalhp[1]

def color():
    return panel.total_hp_color

def sign():
    return '&lt;' if panel.total_hp_sign == '<' else '&gt;' if panel.total_hp_sign == '>' else panel.total_hp_sign

def text():
    font = config.get('battle/totalHP/fontName', 'mono')
    return "<font face='%s' color='#%s'>&nbsp;%6s %s %-6s&nbsp;</font>" % (font, color(), ally(), sign(), enemy())
