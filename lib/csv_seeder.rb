require "csv_seeder/version"
require "csv"

module CsvSeeder
  class Error < StandardError; end
  # Your code goes here...

  def exec(folder_path: 'db/seeds', orders: [])
    ins = CSVSeeder.new(folder_path, orders)
    ins.dirs_loop!
  end  

  class CSVSeeder

    def initialize(folder_path, orders)
      @folder_path = folder_path
      @orders = orders
      @dirs = Dir.glob(folder_path + "/*").shuffle
    end
  
    def dirs_loop!
      while !@dirs.empty?
        if invalid_order?
          postpone!
          next
        end
        if has_relations?
          postpone!
          next
        end
        /db\/seeds\/(\w*)\.csv/ =~ @dirs[0]
        model = $1.classify
        CSV.foreach(@dirs[0], headers: true) do |row|
          Object.const_get(model).create!(**row.to_hash)
        rescue => e
          p "Error! During #{model}"
          p e
        end
        p "#{model} saved!"
        @dirs.shift
      end    
    end
  
    def invalid_order?
      @orders.each do |order|
        index = order.index(dir_to_plural(@dirs[0]).to_sym)
        next if !index || index == 0
        return true if @dirs.any?{|dir| order[0..(index-1)].map(&:to_s).include? dir_to_plural(dir)}
      end
      false
    end
  
    def has_relations?
      CSV.open(@dirs[0], &:readline).any? do |header| 
        id_list = @dirs.map do |dir|
          dir_to_plural(dir).singularize + '_id'
        end
        id_list.include? header
      end
    end
  
    def dir_to_plural(dir)
      /db\/seeds\/(\w*)\.csv/ =~ dir
      return $1
    end
  
    def postpone!
      @dirs.push @dirs.shift
    end
  
  end
end
