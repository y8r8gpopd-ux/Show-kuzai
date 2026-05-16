class Status < ActiveHash::Base

  self.data = [

    {id: 0, name: "たっぷりある"},
    {id: 1, name: "あと少し！"},
    {id: 2, name: "使い切った"}

  ]

  include ActiveHash::Associations
  has_many :fridge_items

end