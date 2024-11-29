package database

import (
	"database/sql"
	"fmt"
)

type UserResult struct {
	ID   int
	Age  int
	Name string
	Role string
}

func SelectUser(db *sql.DB) error {

	query := `
		SELECT id, age, name, role
		FROM users ORDER BY id
		`

	rows, err := db.Query(query)
	if err != nil {
		return fmt.Errorf("クエリ実行エラー: %v", err)
	}
	defer rows.Close()

	fmt.Println("-----ユーザ一覧-------")
	for rows.Next() {
		var user UserResult
		err := rows.Scan(&user.ID, &user.Age, &user.Name, &user.Role)
		if err != nil {
			return fmt.Errorf("読み取りエラー: %v", err)
		}
		fmt.Printf("id: %d, age: %d, name: %s, role: %s", user.ID, user.Age, user.Name, user.Role)
	}

	if err = rows.Err(); err != nil {
		return fmt.Errorf("結果セット処理エラー: %v", err)
	}

	return nil

}
