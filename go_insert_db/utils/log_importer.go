package utils

import (
	"database/sql"
	"fmt"
	"go_insert/database"
	"log"
	"os"
)

func LogImport(file *os.File, db *sql.DB) error {

	// トランザクション開始
	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("トランザクションの開始に失敗しました:%w", err)
	}

	// 確実にrollbackする
	defer func() {
		if r := recover(); r != nil {
			fmt.Println("ロールバックしました")
			tx.Rollback()
			panic(r)
		}
	}()

	// jsonのパース処理
	entries, err := ParseLogFile(file)
	if err != nil {
		return fmt.Errorf("パース処理失敗: %w", err)
	}

	for _, entry := range entries {
		if err := database.InsertData(tx, entry.User.Age, entry.User.Name, entry.User.Role); err != nil {

			panic(fmt.Errorf("insertに失敗しました:%w", err))

		}
		log.Printf("INSERT成功 Age=%d, Name=%s, Role=%s", entry.User.Age, entry.User.Name, entry.User.Role)
	}

	return tx.Commit()
}
