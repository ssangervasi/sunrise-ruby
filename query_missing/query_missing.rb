
module QueryMissing
  class NoQuery < StandardError; end

  class << self
    def try_all_queries(query_key, *args)
      raise NoQuery, 'Empty condition' if args.empty?

      query_value = args.first if args.count == 1 else args
      query_hash = [query_key, query_value].to_hash

      list_models.each do |model_class|
        begin
          puts 'querying', model_class
          return model_class.find_by(query_hash)
        rescue
        end
      end

      raise NoQuery
    end

    def list_models
      ActiveRecord.Base.descendants
    end
  end
end

def BasicObject.method_missing(*args)
  puts 'missing'
  QueryMissing.try_all_queries(*args)
rescue QueryMissing::NoQuery => e
  puts e
  super
end
