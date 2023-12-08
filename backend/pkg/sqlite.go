package pkg

import (
	"boilerplate/config"

	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var Database *gorm.DB

func InitializeSqlite(dbConfig config.DatabaseConfig) error {
	var err error
	Database, err = gorm.Open(sqlite.Open(dbConfig.FileName), &gorm.Config{})

	if err != nil {
		return err
	}

	// Database.AutoMigrate(models.Example{})
	return nil
}
