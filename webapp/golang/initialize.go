package main

import (
	"context"
	"fmt"
)

// initializeQueries := [][]interface{}{
// 	{"DELETE FROM user WHERE ? < `created_at`", lastCreatedAt},
// }
// err := initializeDB(ctx, initializeQueries)
func initializeDB(ctx context.Context, queryArgs [][]interface{}) error {
	conn, err := db.Connx(ctx)
	if err != nil {
		return err
	}
	defer conn.Close()

	for _, qa := range queryArgs {
		query, args := qa[0].(string), qa[1:]

		var err error
		if len(args) > 0 {
			_, err = conn.ExecContext(ctx, query, args...)
		} else {
			_, err = conn.ExecContext(ctx, query)
		}
		if err != nil {
			return fmt.Errorf("error ExecContext: %w", err)
		}
	}
	return nil
}
