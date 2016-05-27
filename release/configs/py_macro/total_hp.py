import xvm_battle.python.fragCorrelationPanel as panel

@xvm.export('xvm.total_hp.ally', deterministic=False)
def ally():
    return panel.teams_totalhp[0]

@xvm.export('xvm.total_hp.enemy', deterministic=False)
def enemy():
    return panel.teams_totalhp[1]

@xvm.export('xvm.total_hp.color', deterministic=False)
def color():
    return panel.total_hp_color

@xvm.export('xvm.total_hp.sign', deterministic=False)
def sign():
    return '&lt;' if panel.total_hp_sign == '<' else '&gt;' if panel.total_hp_sign == '>' else panel.total_hp_sign

@xvm.export('xvm.total_hp.text', deterministic=False)
def text():
    return "<font color='#%s'>%6s %s %-6s</font>" % (color(), ally(), sign(), enemy())
