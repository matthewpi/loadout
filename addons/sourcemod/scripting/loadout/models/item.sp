/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

methodmap Item < StringMap {
    public Item() {
        return view_as<Item>(new StringMap());
    }

    public void GetWeapon(char[] buffer, int maxlen) {
        this.GetString("weapon", buffer, maxlen);
    }

    public void SetWeapon(const char[] weapon) {
        this.SetString("weapon", weapon);
    }

    public void GetSkinID(char[] buffer, int maxlen) {
        this.GetString("skinId", buffer, maxlen);
    }

    public void SetSkinID(const char[] skinId) {
        this.SetString("skinId", skinId);
    }

    public int GetPattern() {
        int pattern;
        this.GetValue("pattern", pattern);
        return pattern;
    }

    public void SetPattern(int pattern) {
        this.SetValue("pattern", pattern);
    }

    public float GetFloat() {
        float floatValue;
        this.GetValue("float", floatValue);
        return floatValue;
    }

    public void SetFloat(float floatValue) {
        this.SetValue("float", floatValue);
    }

    public int GetStatTrak() {
        int statTrak;
        this.GetValue("statTrak", statTrak);
        return statTrak;
    }

    public void SetStatTrak(int statTrak) {
        this.SetValue("statTrak", statTrak);
    }
}
