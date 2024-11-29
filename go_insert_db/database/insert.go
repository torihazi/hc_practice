package database

import (
	"database/sql"
	"fmt"
)

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
