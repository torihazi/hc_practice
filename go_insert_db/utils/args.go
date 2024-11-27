package utils

import (
	"fmt"
	"os"
)

func GetFilePath()(string, error) {
	if len(os.Args) > 2 {
		return "", fmt.Errorf("引数は1つまでです")
		
	}

	// ファイル名を取得
	filename := os.Args[1]

	// ファイルの存在確認
	if _, err := os.Stat(filename); err != nil {
		return "", fmt.Errorf("ファイルが存在しません")
		
	}

	return filename, nil

}