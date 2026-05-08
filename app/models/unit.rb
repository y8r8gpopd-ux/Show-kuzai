class Unit < ActiveHash::Base

  self.data[

    {id: 0, name: "個"},
    {id: 1, name: "g"},
    {id: 2, name: "ml"},
    {id: 0, name: "本"},
    {id: 0, name: "枚"},
    {id: 0, name: "匹"},
    {id: 0, name: "杯"},
    {id: 0, name: "丁"}
    ]

  include ActiveHash::Associations
  has_many :FridgeItem

end