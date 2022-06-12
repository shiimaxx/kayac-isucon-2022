package main

import "sync"

type PlaylistULIDCache struct {
	Items    sync.Map
	Disabled bool
}

func (c *PlaylistULIDCache) Store(key string, value *PlaylistRow) {
	if c.Disabled {
		return
	}
	c.Items.Store(key, value)
}

func (c *PlaylistULIDCache) Load(key string) (*PlaylistRow, bool) {
	if c.Disabled {
		return nil, false
	}
	if val, found := c.Items.Load(key); found {
		return val.(*PlaylistRow), found
	}
	return nil, false
}

func (c *PlaylistULIDCache) Delete(key string) {
	if c.Disabled {
		return
	}
	c.Items.Delete(key)
}

type FavoritedByCache struct {
	Items    sync.Map
	Disabled bool
}

func (c *FavoritedByCache) Store(key string, value bool) {
	if c.Disabled {
		return
	}
	c.Items.Store(key, value)
}

func (c *FavoritedByCache) Load(key string) (bool, bool) {
	if c.Disabled {
		return false, false
	}
	if val, found := c.Items.Load(key); found {
		return val.(bool), found
	}
	return false, false
}

func (c *FavoritedByCache) Delete(key string) {
	if c.Disabled {
		return
	}
	c.Items.Delete(key)
}

type SongCountCache struct {
	Items    sync.Map
	Disabled bool
}

func (c *SongCountCache) Store(key int, value int) {
	if c.Disabled {
		return
	}
	c.Items.Store(key, value)
}

func (c *SongCountCache) Load(key int) (int, bool) {
	if c.Disabled {
		return 0, false
	}
	if val, found := c.Items.Load(key); found {
		return val.(int), found
	}
	return 0, false
}

func (c *SongCountCache) Delete(key int) {
	if c.Disabled {
		return
	}
	c.Items.Delete(key)
}

type PlaylistSongsCache struct {
	Items    sync.Map
	Disabled bool
}

type PlaylistSongsCacheResult struct {
	SongRow   `db:"song"`
	ArtistRow `db:"artist"`
}

type PlaylistSongsCacheResults []PlaylistSongsCacheResult

func (c *PlaylistSongsCache) Store(key string, value PlaylistSongsCacheResults) {
	if c.Disabled {
		return
	}
	c.Items.Store(key, value)
}

func (c *PlaylistSongsCache) Load(key string) (PlaylistSongsCacheResults, bool) {
	if c.Disabled {
		return nil, false
	}
	if val, found := c.Items.Load(key); found {
		return val.(PlaylistSongsCacheResults), found
	}
	return nil, false
}

func (c *PlaylistSongsCache) Delete(key string) {
	if c.Disabled {
		return
	}
	c.Items.Delete(key)
}
