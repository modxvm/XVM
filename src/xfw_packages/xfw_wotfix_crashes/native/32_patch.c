extern int bugfix1_apply();
extern int bugfix2_apply();
extern int bugfix3_apply();
extern int bugfix4_apply();


int patch_get_count() {
    return 2;
}

int patch_apply(int i) {
    int result = -100;

    switch (i) {
    case 1:
        result = bugfix1_apply();
        break;
    case 2:
        result = bugfix3_apply();
        break;
    case 3:
        result = bugfix2_apply();
        break;
    case 4:
        result = bugfix4_apply();
        break;
    default:
        break;
    }

    return result;
}
