package main

import (
	"context"
	"fmt"

	"github.com/gomodule/redigo/redis"
)

func connectRedis() *redis.Pool {
	addr := getEnv("REDIS_ADDR", "redis://127.0.0.1:6379")
	return &redis.Pool{
		Dial: func() (redis.Conn, error) {
			return redis.DialURL(addr)
		},
		MaxIdle: 1000000,
	}
}

func initializeRedis(ctx context.Context) error {
	conn, err := db.Conn(ctx)
	if err != nil {
		return err
	}
	defer conn.Close()

	redisConn := pool.Get()
	defer redisConn.Close()

	if err := redisConn.Send("DEL", "fav"); err != nil {
		return err
	}

	var popular []struct {
		PlaylistID    int `db:"playlist_id"`
		FavoriteCount int `db:"favorite_count"`
	}
	if err := db.Select(
		&popular,
		`SELECT playlist_id, count(*) AS favorite_count FROM playlist_favorite GROUP BY playlist_id ORDER BY count(*) DESC`,
	); err != nil {
		return fmt.Errorf(
			"error Select playlist_favorite: %w",
			err,
		)
	}

	if len(popular) == 0 {
		return nil
	}
	for _, p := range popular {
		if err := redisConn.Send("ZADD", "fav", p.FavoriteCount, p.PlaylistID); err != nil {
			return err
		}
	}

	return nil
}
