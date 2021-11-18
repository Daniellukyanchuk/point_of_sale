class SqlHelper
  def self.escape_sql_param(*param)
    ActiveRecord::Base::send(:sanitize_sql_array, (["?"] + param))
  end
     
  def self.p(sql)
  	sql.tr("\n", " ").tr("\t", " ")
  end
end