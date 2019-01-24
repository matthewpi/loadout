/**
 * Copyright (c) 2019 Matthew Penner <me@matthewp.io>
 * All rights reserved.
 */

methodmap User < StringMap {
    public User() {
        return view_as<User>(new StringMap());
    }

    public int GetID() {
        int id;
        this.GetValue("id", id);
        return id;
    }

    public void SetID(int id) {
        this.SetValue("id", id);
    }

    public void GetUsername(char[] buffer, int maxlen) {
        this.GetString("username", buffer, maxlen);
    }

    public void SetUsername(const char[] username) {
        this.SetString("username", username);
    }

    public void GetSteamID(char[] buffer, int maxlen) {
        this.GetString("steamId", buffer, maxlen);
    }

    public void SetSteamID(const char[] steamId) {
        this.SetString("steamId", steamId);
    }

    public int GetGroup() {
        int group;
        this.GetValue("group", group);
        return group;
    }

    public void SetGroup(int group) {
        this.SetValue("group", group);
    }

    public int GetCreatedAt(char[] buffer, int maxlen) {
        int createdAt;
        this.GetValue("createdAt", createdAt);
        return createdAt;
    }

    public void SetCreatedAt(int createdAt) {
        this.SetValue("createdAt", createdAt);
    }
}
