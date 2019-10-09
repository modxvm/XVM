import BigWorld

@xvm.export('vinfo.name', deterministic=False)
def vehicle_name():
    typeDescriptor = _typeDescriptor()
    return None if not typeDescriptor else typeDescriptor.type.userString

@xvm.export('vinfo.gun_reload', deterministic=False)
def gun_reload():
    typeDescriptor = _typeDescriptor()
    return None if not typeDescriptor else "%.1f" % (typeDescriptor.gun.reloadTime)

@xvm.export('vinfo.vision_radius', deterministic=False)
def vision_radius():
    typeDescriptor = _typeDescriptor()
    return None if not typeDescriptor else "%i" % (typeDescriptor.turret.circularVisionRadius)

# PRIVATE

def _typeDescriptor():
    vehicle = _vehicle()
    return None if not vehicle else vehicle.typeDescriptor

def _vehicle():
    vehicle = BigWorld.target()
    if not vehicle:
        vehicle = BigWorld.player().getVehicleAttached()
    return vehicle
