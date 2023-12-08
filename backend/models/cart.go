package models

type Cart struct {
	ID       uint      `json:"id" gorm:"primary_key"`
	UserID   uint      `json:"-"`
	User     User      `json:"user" gorm:"foreignKey:UserID"`
	Products []Product `json:"products" gorm:"many2many:cart_products"`
	Quantity int       `json:"quantity" gorm:"not null"`
}
