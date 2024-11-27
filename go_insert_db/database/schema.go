package database

import (
	"database/sql"
	"fmt"
)

// テーブルを作成管理
func SetupTables (db *sql.DB) error {

	// usersテーブル作成
	if err := createTable(db); err != nil {
		return fmt.Errorf("usersテーブルの作成に失敗しました")
	}

	return nil
}


// usersテーブルを作成する
func createTable(db *sql.DB) error {
	query := `
	CREATE TABLE IF NOT EXISTS users (
	id SERIAL PRIMARY KEY,
	age INTEGER,
	name VARCHAR(500),
	role CHAR(15)
	)`

	_, err := db.Exec(query)

	return err
}