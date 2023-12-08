package models

type User struct {
	ID    uint   `json:"id" gorm:"primary_key"`
	Name  string `json:"name" gorm:"not null"`
	Phone string `json:"phone" gorm:"not null;unique"`
	Pin   string `json:"pin" gorm:"not null"`
}
