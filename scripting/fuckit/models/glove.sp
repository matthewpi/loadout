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

    public void SetID(int id) {
        this.SetValue("id", id);
    }

    public void GetName(char[] buffer, int maxlen) {
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

    public void SetGloveID(int gloveId) {
        this.SetValue("gloveId", gloveId);
    }

    public int GetPaintID() {
        int paintId;
        this.GetValue("paintId", paintId);
        return paintId;
    }

    public void SetPaintID(int paintId) {
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

    public void SetID(int id) {
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

    public void SetItemID(int itemId) {
        this.SetValue("itemId", itemId);
    }

    public void GetSkins(GloveSkin[] buffer, int maxlen) {
        this.GetArray("skins", buffer, maxlen);
    }

    public void SetSkins(GloveSkin[] skins, int maxlen) {
        this.SetArray("skins", skins, maxlen, true);
    }

    public void AddSkin(int index, GloveSkin skin) {
        GloveSkin skins[GLOVE_SKIN_MAX];
        this.GetSkins(skins, sizeof(skins));

        skins[index] = skin;
        this.SetSkins(skins, sizeof(skins));
    }

    public GloveSkin GetSkin(int index) {
        GloveSkin skins[GLOVE_SKIN_MAX];
        this.GetSkins(skins, sizeof(skins));
        return skins[index];
    }
}
