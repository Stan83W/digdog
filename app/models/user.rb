class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

def fetch_discogs_want_list

  #1 Call à l'api

  #2 Pour chaque item de l'api, créer un Record (Record.new), mais
  # ne pas le persister en base (pas de save/create)

  #3 -> return array de records

end


end
