package database

import (
	"database/sql"
	"fmt"
	"go_insert/config"
	"log"
)

func Connect(config *config.ConfigList) (*sql.DB, error) {
	conStr := fmt.Sprintf(
		"host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		config.Host,
		config.Port,
		config.UserName,
		config.Password,
		config.Dbname,
	)
	log.Printf("接続文字列: %s", conStr)

	db, err := sql.Open(config.SQLDriver, conStr)
	if err != nil {
		return nil, fmt.Errorf("データベースの初期化に失敗しました: %w", err)
	}

	if err := db.Ping(); err != nil {
		return nil, fmt.Errorf("データベースとの接続に失敗しました: %w", err)
	}

	return db, nil

}
