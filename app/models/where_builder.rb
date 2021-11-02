class WhereBuilder

    # takes an array of strings that are supposed to be valid sql clauses
    # returns a SQL where statement that joins them with the "AND" keyword
    # if the statements array is empty or has empty strings then return an empty string
    def self.build(statements)
                  
        statements = statements.reject(&:blank?)
        
        if statements.blank?
            where_statement = ""
        else           
            where_statement = "WHERE #{statements.join(' AND ')}"
        end
    end
end


