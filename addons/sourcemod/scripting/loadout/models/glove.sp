/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

methodmap GloveSkin < StringMap {
    public GloveSkin() {
        return view_as<GloveSkin>(new StringMap());
    }

    public int GetID() {
        int id;
        this.GetValue("id", id);
        return id;
    }

    public void SetID(const int id) {
        this.SetValue("id", id);
    }

    public void GetName(char[] buffer, const int maxlen) {
        this.GetString("name", buffer, maxlen);
    }

    public void SetName(const char[] name) {
        this.SetString("name", name);
    }

    public int GetGloveID() {
        int gloveId;
        this.GetValue("gloveId", gloveId);
        return gloveId;
    }

    public void SetGloveID(const int gloveId) {
        this.SetValue("gloveId", gloveId);
    }

    public int GetPaintID() {
        int paintId;
        this.GetValue("paintId", paintId);
        return paintId;
    }

    public void SetPaintID(const int paintId) {
        this.SetValue("paintId", paintId);
    }
}

methodmap Glove < StringMap {
    public Glove() {
        return view_as<Glove>(new StringMap());
    }

    public int GetID() {
        int id;
        this.GetValue("id", id);
        return id;
    }

    public void SetID(const int id) {
        this.SetValue("id", id);
    }

    public void GetName(char[] buffer, int maxlen) {
        this.GetString("name", buffer, maxlen);
    }

    public void SetName(const char[] name) {
        this.SetString("name", name);
    }

    public int GetItemID() {
        int itemId;
        this.GetValue("itemId", itemId);
        return itemId;
    }

    public void SetItemID(const int itemId) {
        this.SetValue("itemId", itemId);
    }

    public void GetSkins(GloveSkin[] buffer, const int maxlen) {
        this.GetArray("skins", buffer, maxlen);
    }

    public void SetSkins(const GloveSkin[] skins, const int maxlen) {
        this.SetArray("skins", skins, maxlen, true);
    }

    public void AddSkin(const int index, const GloveSkin skin) {
        GloveSkin skins[LOADOUT_GLOVE_SKIN_MAX + 1];
        this.GetSkins(skins, sizeof(skins));

        skins[index] = skin;
        this.SetSkins(skins, sizeof(skins));
    }

    public GloveSkin GetSkin(const int index) {
        GloveSkin skins[LOADOUT_GLOVE_SKIN_MAX + 1];
        this.GetSkins(skins, sizeof(skins));
        return skins[index];
    }
}
