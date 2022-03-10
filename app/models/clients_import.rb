class ClientsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file 

  def initialize(attributes={})
  	attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
  	false
  end

  def open_spreadsheet
  	case File.extname(file.original_filename)
  	when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
  	when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  	when ".xlsx" then Roo::Excelx.new(file.path)
  	else raise "Unknown file type: #{file.original_filename}"
  	end
  end

  def load_imported_clients 
  	spreadsheet = open_spreadsheet
  	header = spreadsheet.row(1)
  	(2..spreadsheet.last_row).map do |i|
  		row = Hash[[header, spreadsheet.row(i)].transpose]
  		client = Client.find_by_id(row["id"]) || Client.new
  		client.attributes = row.to_hash
  		client
  	end
  end

  def imported_clients
  	@imported_clients ||= load_imported_clients
  end

  def save 
  	if imported_clients.map(&:valid?).all?
  	  imported_clients.each(&:save!)
  	  true 
  	else
  		imported_clients.each_with_index do |item, index|
  			client.errors.full_messages.each do |msg|
  				errors.add :base, "Row #{index + 2}: #{msg}"
  			end
  		end
  		false
  	end
  end
end