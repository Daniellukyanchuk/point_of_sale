class WhereBuilder

	# takes an array of strings that are supposed to be valid sql clauses
    # returns a SQL where statement that joins them with the "AND" keyword
    # if the statements array is empty or has empty strings then return an empty string
	def self.build(statements)


	  # the build method should take the statments I just made and combine them
      # if there are blank nothing should come back
      # if one of them has sql then it should say "WHERE #{_that_statement_here}"
      # if both of them have sql then they should be combined by the "AND" operator
      # WhereBuilder.build([client_id_where, search_text_where])

      # when done this should be the whole WHERE section of sql
	  where_clause = ""

	  # statements = ["client_id IN (1, 2)", ""]
	  
	  statements = statements.reject { |c| c.empty? }

	  # statements = ["", ""]
	  if statements == []
	  	return ""
      else
      	where_clause = "WHERE "
	  end

	  # I want to join statements by AND 
      where_clause += statements.join(" AND ")
      
	  return where_clause

	end
end