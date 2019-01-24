/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

methodmap Group < StringMap {
    public Group() {
        return view_as<Group>(new StringMap());
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

    public void GetTag(char[] buffer, int maxlen) {
        this.GetString("tag", buffer, maxlen);
    }

    public void SetTag(const char[] tag) {
        this.SetString("tag", tag);
    }

    public int GetImmunity() {
        int immunity;
        this.GetValue("immunity", immunity);
        return immunity;
    }

    public void SetImmunity(int immunity) {
        this.SetValue("immunity", immunity);
    }

    public void GetFlags(char[] buffer, int maxlen) {
        this.GetString("flags", buffer, maxlen);
    }

    public void SetFlags(const char[] flags) {
        this.SetString("flags", flags);
    }
}
