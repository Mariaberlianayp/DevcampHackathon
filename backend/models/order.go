package models

type Order struct {
	ID       uint      `json:"id" gorm:"primary_key"`
	UserID   uint      `json:"-"`
	User     User      `json:"user" gorm:"foreignKey:UserID"`
	Products []Product `json:"products" gorm:"many2many:order_products"`
	Quantity int       `json:"quantity" gorm:"not null"`
	Payments []Payment `json:"payments" gorm:"foreignKey:OrderID"`
	Status   string    `json:"status" gorm:"not null"`
}

type Payment struct {
	ID      uint `json:"id" gorm:"primary_key"`
	OrderID uint `json:"-"`
	UserID  uint `json:"-"`
	User    User `json:"user" gorm:"foreignKey:UserID"`
	Amount  int  `json:"amount" gorm:"not null"`
	IsPaid  bool `json:"is_paid" gorm:"not null"`
}
