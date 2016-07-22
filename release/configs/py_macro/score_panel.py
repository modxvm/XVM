import xvm_battle.python.fragCorrelationPanel as panel

@xvm.export('score_panel.ally_frags', deterministic=False)
def ally_frags():
    return panel.ally_frags

@xvm.export('score_panel.enemy_frags', deterministic=False)
def enemy_frags():
    return panel.enemy_frags

@xvm.export('score_panel.ally_vehicles', deterministic=False)
def ally_vehicles():
    return panel.ally_vehicles

@xvm.export('score_panel.enemy_vehicles', deterministic=False)
def enemy_vehicles():
    return panel.enemy_vehicles

@xvm.export('score_panel.ally_frags_inverse', deterministic=False)    
def ally_frags_inverse():
    return ally_vehicles() - enemy_frags()

@xvm.export('score_panel.enemy_frags_inverse', deterministic=False)
def enemy_frags_inverse():
    return enemy_vehicles() - ally_frags()
