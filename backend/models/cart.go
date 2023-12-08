package models

type Cart struct {
	ID           uint          `json:"id" gorm:"primary_key"`
	UserID       uint          `json:"-"`
	User         User          `json:"user" gorm:"foreignKey:UserID"`
	CartProducts []CartProduct `json:"products" gorm:"foreignKey:CartID"`
}

type CartProduct struct {
	ID        uint    `json:"id" gorm:"primary_key"`
	CartID    uint    `json:"-"`
	ProductID uint    `json:"-"`
	Product   Product `json:"product" gorm:"foreignKey:ProductID"`
	Quantity  int     `json:"quantity" gorm:"not null"`
}

type CartCreate struct {
	Phone              string              `json:"phone"`
	CartCreateProducts []CartCreateProduct `json:"products"`
}

type CartCreateProduct struct {
	ProductID uint `json:"product_id"`
	Quantity  int  `json:"quantity"`
}
