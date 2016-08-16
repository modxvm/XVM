import BigWorld

@xvm.export('vinfo.name', deterministic=False)
def vehicle_name():
    return _typeDescriptor().type.userString

@xvm.export('vinfo.gun_reload', deterministic=False)
def gun_reload():
    return "%.1f" % (_typeDescriptor().gun['reloadTime'])

@xvm.export('vinfo.vision_radius', deterministic=False)
def vision_radius():
    return "%i" % (_typeDescriptor().turret['circularVisionRadius'])

# PRIVATE

def _typeDescriptor():
    return _vehicle().typeDescriptor

def _vehicle():
    vehicle = BigWorld.target()
    if not vehicle:
        vehicle = BigWorld.player().getVehicleAttached()
    return vehicle
