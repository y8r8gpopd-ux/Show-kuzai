class Unit < ActiveHash::Base

  self.data = [

    {id: 0, name: "個"},
    {id: 1, name: "g"},
    {id: 2, name: "ml"},
    {id: 3, name: "本"},
    {id: 4, name: "枚"},
    {id: 5, name: "匹"},
    {id: 6, name: "杯"},
    {id: 7, name: "丁"}
    ]

  include ActiveHash::Associations
  has_many :fridge_items

end