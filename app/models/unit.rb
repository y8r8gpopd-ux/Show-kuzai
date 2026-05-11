class Unit < ActiveHash::Base

  self.data = [
    
    {id: 0, name: "---"},
    {id: 1, name: "個"},
    {id: 2, name: "g"},
    {id: 3, name: "ml"},
    {id: 4, name: "本"},
    {id: 5, name: "枚"},
    {id: 6, name: "匹"},
    {id: 7, name: "杯"},
    {id: 8, name: "丁"}
    
    ]

  include ActiveHash::Associations
  has_many :fridge_items
  has_many :recipe_ingredients

end