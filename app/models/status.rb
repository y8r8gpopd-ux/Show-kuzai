class Status < ActiveHash::Base

  self.data = [

    {id: 0, name: "plenty"},
    {id: 1, name: "little"},
    {id: 2, name: "used_up"}

  ]

  include ActiveHash::Associations
  has_many :fridge_items

end