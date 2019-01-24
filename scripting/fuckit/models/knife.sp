/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

methodmap Knife < StringMap {
    public Knife() {
        return view_as<Knife>(new StringMap());
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
}
