package config

import (
	"fmt"
	"os"

	"gopkg.in/go-ini/ini.v1"
)


type ConfigList struct {
	Host      string
	Port      int
	Dbname    string
	UserName  string
	Password string
	SQLDriver string
}

var Config *ConfigList

func LoadConfig()(*ConfigList, error) {
		// iniのload
		cfg, err := ini.Load("config/config.ini")
		if err != nil {
			if os.IsNotExist(err) {
				return nil, fmt.Errorf("ファイルが存在しません: %w", err)
			}
			return nil, fmt.Errorf("iniファイルの読み込みに失敗しました: %w", err)
		}
	
		return &ConfigList{
			Host:      cfg.Section("database").Key("host").MustString("localhost"),
			Port:      cfg.Section("database").Key("port").MustInt(5432),
			UserName:  cfg.Section("database").Key("username").MustString("postgres"),
			Password:  cfg.Section("database").Key("password").MustString(""),
			Dbname:    cfg.Section("database").Key("dbname").MustString("go_sample"),
			SQLDriver: cfg.Section("database").Key("driver").MustString("postgres"),
		},nil
	
}