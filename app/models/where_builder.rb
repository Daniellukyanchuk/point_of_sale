class WhereBuilder

	# takes an array of strings that are supposed to be valid sql clauses
    # returns a SQL where statement that joins them with the "AND" keyword
    # if the statements array is empty or has empty strings then return an empty string
	def self.build(statements)

	  where_clause = ""

      if @client_report.client_id_where.blank? && @client_report.search_text_where.blank?
        where_clause = ""  
      else 
        where_clause = "WHERE"
      end 
      
      if @client_report.client_id_where.blank? || @client_report.search_text_where.blank?
        joiner = ""
      else
        joiner = "OR"
      end

      where_clause += " #{client_id_where} #{joiner} #{search_text_where}"

	end
end