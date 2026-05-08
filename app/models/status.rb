class Status < ActiveHash::base

  self.data[

    {id: 0, name: plenty},
    {id: 1, name: little},
    {id: 2, name: used_up}

  ]

  include ActiveHash::Associations
  has_many :FridgeItem

end