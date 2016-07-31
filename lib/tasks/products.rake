namespace :products do

  desc 'Import products from json to database'
  task :script => :environment do
    Dir['lib/json/*'].each do |file|
      json = JSON.parse(File.read(file))
      json.each do |j|
        begin
          Product.create(j)
        rescue
          puts 'Product could not be saved'
        end
      end
    end
  end
end
