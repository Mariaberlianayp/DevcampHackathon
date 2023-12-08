package models

type Example struct {
	ID   uint   `json:"id" gorm:"primary_key"`
	Name string `json:"name" gorm:"not null"`
	Desc string `json:"description"`
}

type ExampleCreate struct {
	Name string `json:"name" binding:"required"`
	Desc string `json:"description" binding:"-"`
}

type ExampleUpdate struct {
	Name string `json:"name" binding:"-"`
	Desc string `json:"description" binding:"-"`
}
