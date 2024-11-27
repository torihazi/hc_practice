package database

import (
	"bufio"
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"os"
)

// JSON用の構造体作成
type User struct {
	Age  int    `json:"age"`
	Name string `json:"name"`
	Role string `json:"role"`
}

type LogInfo struct {
	User  User   `json:"user"`
	Dist  string `json:"-"`
	Level string `json:"-"`
	Msg   string `json:"-"`
	Src   string `json:"-"`
	Time  string `json:"-"`
}

func LogImport (file *os.File, db *sql.DB) error {
	
	// Scannerを作成
	scanner := bufio.NewScanner(file)

	var loginfo LogInfo

	// トランザクション開始
	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("トランザクションの開始に失敗しました:%w", err)
	}

	// 確実にrollbackする
	defer func() {
		if r:= recover(); r != nil {
			fmt.Println("ロールバックしました")
			tx.Rollback()
			panic(r)
		}
	}()

	for scanner.Scan() {
		line := scanner.Text()
		err := json.Unmarshal([]byte(line), &loginfo)
		if err != nil {
			panic(fmt.Errorf("jsonのデシリアライズに失敗しました: %w", err))
		}

		// insert処理
		if err := InsertData(tx, loginfo.User.Age, loginfo.User.Name, loginfo.User.Role); err != nil {
			
			panic(fmt.Errorf("insertに失敗しました:%w", err))
			
		}
		log.Printf("INSERT成功 Age=%d, Name=%s, Role=%s", loginfo.User.Age, loginfo.User.Name, loginfo.User.Role)

	}

	return tx.Commit()
}


func InsertData(tx *sql.Tx, age int, name, role string) error {
	
		query := `
		INSERT INTO users (age, name, role) 
		VALUES ($1, $2, $3)
		`
	
		_, err := tx.Exec(query, age, name, role)
		if err != nil {
			return fmt.Errorf("insertに失敗しました")
		}
	
		return nil
	
}