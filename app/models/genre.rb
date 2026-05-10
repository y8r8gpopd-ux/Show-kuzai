class Genre < ActiveHash::Base

  self.data = [
    {id: 0, name: "和食"},
    {id: 1, name: "洋食"},
    {id: 2, name: "中華"},
    {id: 3, name: "イタリアン"},
    {id: 4, name: "エスニック"}
  ]

  include ActiveHash::Associations
  has_many :recipes

end