package main

import (
	"database/sql"
	"go_insert/config"
	"go_insert/database"
	"go_insert/utils"
	"log"
	"os"

	_ "github.com/lib/pq"
)

// データベースとの接続を管理する*sql.DB型のポインタを定義
var db *sql.DB

func init() {

	// iniのload
	config, err := config.LoadConfig()
	if err != nil {
		log.Fatal(err)
	}

	// DBとの接続
	db, err = database.Connect(config)
	if err != nil {
		log.Fatal(err)
	}

	// 接続後にテーブル作成を実施
	if err := database.SetupTables(db); err != nil {
		log.Fatal(err)
	}

	log.Println("テーブルの準備が完了しました")

}

func main() {

	defer db.Close()

	// コマンドライン引数から値を取得
	filename, err := utils.GetFilePath()
	if err != nil {
		log.Fatal(err)
	}

	// ファイル取得
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
	}

	defer file.Close()

	// 取得したファイルからデータを読み込み、insert
	if err := database.LogImport(file, db); err != nil {
		log.Fatal(err)
	}

	// insertしたファイルの表示
	if err = database.SelectUser(db); err != nil {
		log.Fatal(err)
	}

}
