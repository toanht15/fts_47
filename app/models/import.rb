class Import < ActiveRecord::Base
  class << self
    def import file
      spreadsheet = open_spreadsheet file
      header = spreadsheet.row Settings.csv.row
      (Settings.csv.last_row..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        category = Category.find_by_name(row["name"]) || Category.new
        category.attributes = row.to_hash
        category.save!
      end
    end

    def open_spreadsheet file
      if Settings.csv.type == File.extname(file.original_filename)
        Roo::CSV.new file.path
      else
        raise I18n.t("unfile") + "#{file.original_filename}"
      end
    end
  end
end
