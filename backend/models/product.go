package models

type Product struct {
	ID       uint   `json:"id" gorm:"primary_key"`
	Name     string `json:"name" gorm:"not null"`
	ImageUrl string `json:"image_url" gorm:"not null"`
	Price    int    `json:"price" gorm:"not null"`
}
