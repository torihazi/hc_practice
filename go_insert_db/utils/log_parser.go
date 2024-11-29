package utils

import (
	"bufio"
	"encoding/json"
	"fmt"
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

type LogEntries []LogInfo

func ParseLogFile(file *os.File) (LogEntries, error) {

	var entries LogEntries
	// Scannerを作成
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		var loginfo LogInfo
		if err := json.Unmarshal([]byte(scanner.Text()), &loginfo); err != nil {
			return nil, fmt.Errorf("jsonのデシリアライズに失敗しました: %w", err)
		}
		entries = append(entries, loginfo)
	}

	if err := scanner.Err(); err != nil {
		return nil, fmt.Errorf("ファイル読み込み中にエラー: %w", err)
	}

	return entries, nil

}
