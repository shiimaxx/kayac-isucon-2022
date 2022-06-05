package main

import "sync"

type PopularCache struct {
	item     []Popular
	mu       sync.RWMutex
	disabled bool
}

func (c *PopularCache) Set(item []Popular) {
	if c.disabled {
		return
	}
	c.mu.Lock()
	c.item = item
	c.mu.Unlock()
}

func (c *PopularCache) Get() []Popular {
	if c.disabled {
		return nil
	}
	c.mu.RLock()
	item := c.item
	c.mu.RUnlock()
	return item
}
