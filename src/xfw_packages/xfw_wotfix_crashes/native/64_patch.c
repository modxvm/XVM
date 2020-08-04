extern int patch_1_apply();
extern int patch_2_apply();

int patch_get_count() {
    return 2;
}

int patch_apply(int i) {
    int result = -100;

    switch (i) {
    case 1:
        result = patch_1_apply();
        break;
    case 2:
        result = patch_2_apply();
        break;
    default:
        break;
    }

    return result;
}
