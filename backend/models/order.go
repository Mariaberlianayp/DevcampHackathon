package models

type Order struct {
	ID            uint           `json:"id" gorm:"primary_key"`
	UserID        uint           `json:"-"`
	User          User           `json:"user" gorm:"foreignKey:UserID"`
	OrderProducts []OrderProduct `json:"products" gorm:"foreignKey:OrderID"`
	Payments      []Payment      `json:"payments" gorm:"foreignKey:OrderID"`
	Status        string         `json:"status" gorm:"not null"`
}

type OrderProduct struct {
	ID        uint    `json:"id" gorm:"primary_key"`
	OrderID   uint    `json:"-"`
	ProductID uint    `json:"-"`
	Product   Product `json:"product" gorm:"foreignKey:ProductID"`
	Quantity  int     `json:"quantity" gorm:"not null"`
}

type Payment struct {
	ID      uint `json:"id" gorm:"primary_key"`
	OrderID uint `json:"-"`
	UserID  uint `json:"-"`
	User    User `json:"user" gorm:"foreignKey:UserID"`
	Amount  int  `json:"amount" gorm:"not null"`
	IsPaid  bool `json:"is_paid" gorm:"not null"`
}
