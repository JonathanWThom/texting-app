class RenameFavoritesContacts < ActiveRecord::Migration[5.0]
  def change
    rename_table :favorites, :contacts
  end
end
