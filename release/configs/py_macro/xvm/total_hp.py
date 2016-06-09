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
    return "<font color='#%s'>%6s %s %-6s</font>" % (color(), ally(), sign(), enemy())
