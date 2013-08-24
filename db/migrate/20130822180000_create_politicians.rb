require_relative '../config'

class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |entry|
      entry.string :type
      entry.string :title
      entry.string :firstname
      entry.string :middlename
      entry.string :lastname
      entry.string :name_suffix
      entry.string :gender
      entry.string :party
      entry.integer :in_office
      entry.string :state
      entry.string :district
      entry.string :phone
      entry.string :fax
      entry.string :website
      entry.string :webform
      entry.string :district
      entry.string :birthdate
      entry.string :twitter_id

      entry.timestamps
    end
  end
end